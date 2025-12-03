import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Simple cart item model (expand as needed)
class CartItem {
  final String id;
  final String name;
  int quantity;

  // Use private backing fields and expose non-nullable getters.
  final double _price;
  final String _size;
  final String _colour;
  final String _image;

  // Constructor accepts nullable inputs but converts them to safe defaults.
  CartItem({
    required this.id,
    required this.name,
    this.quantity = 1,
    double? price,
    String? size,
    String? colour,
    String? image,
  })  : _price = price ?? 0.0,
        _size = size ?? '',
        _colour = colour ?? '',
        _image = image ?? '';

  // Public non-nullable accessors (never return null).
  double get price => _price;
  String get size => _size;
  String get colour => _colour;
  String get image => _image;

  // Add: copyWith to create new instances instead of mutating existing ones
  CartItem copyWith({
    String? id,
    String? name,
    int? quantity,
    double? price,
    String? size,
    String? colour,
    String? image,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this._price,
      size: size ?? this._size,
      colour: colour ?? this._colour,
      image: image ?? this._image,
    );
  }

  // Serialize to a Map for saving.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': _price,
      'size': _size,
      'colour': _colour,
      'image': _image,
    };
  }

  // Create from a Map (defensive: provide defaults).
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      quantity: (map['quantity'] is int) ? map['quantity'] as int : int.tryParse(map['quantity']?.toString() ?? '') ?? 1,
      price: (map['price'] is num) ? (map['price'] as num).toDouble() : double.tryParse(map['price']?.toString() ?? '') ?? 0.0,
      size: map['size']?.toString() ?? '',
      colour: map['colour']?.toString() ?? '',
      image: map['image']?.toString() ?? '',
    );
  }

  // Added: JSON helpers using existing map (defensive on parse errors)
  String toJson() => jsonEncode(toMap());

  factory CartItem.fromJson(String source) {
    try {
      final decoded = jsonDecode(source);
      if (decoded is Map<String, dynamic>) {
        return CartItem.fromMap(decoded);
      }
      if (decoded is Map) {
        return CartItem.fromMap(Map<String, dynamic>.from(decoded));
      }
    } catch (_) {
      // fall through to return a safe default below
    }
    return CartItem(id: '', name: '', quantity: 1, price: 0.0, size: '', colour: '', image: '');
  }
}

// Reactive list of cart items: listen to this to update UI immediately
final ValueNotifier<List<CartItem>> cartItemsNotifier = ValueNotifier<List<CartItem>>([]);

// Backwards-compatible getter used in existing code
List<CartItem> get cartItems => cartItemsNotifier.value;

// Persistence helpers
const String _kCartPrefsKey = 'cart_items_v1';

Future<void> _saveCartToPrefs() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final list = cartItemsNotifier.value.map((i) => i.toMap()).toList();
    final encoded = jsonEncode(list);
    await prefs.setString(_kCartPrefsKey, encoded);
  } catch (_) {
    // ignore persistence errors silently; do not crash the app
  }
}

Future<void> loadCartFromPrefs() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final encoded = prefs.getString(_kCartPrefsKey);
    if (encoded == null || encoded.isEmpty) return;
    final decoded = jsonDecode(encoded);
    if (decoded is List) {
      final restored = decoded
          .whereType<Map<String, dynamic>>()
          .map((m) => CartItem.fromMap(Map<String, dynamic>.from(m)))
          .toList();
      // Replace notifier value once with restored list
      cartItemsNotifier.value = restored;
    }
  } catch (_) {
    // ignore parse errors
  }
}

void _attachPersistenceListener() {
  if (_persistenceListenerAttached) return;
  cartItemsNotifier.addListener(() {
    _saveCartToPrefs();
  });
  _persistenceListenerAttached = true;
}

bool _persistenceListenerAttached = false;

void addToCart(CartItem item) {
  // create a new list instance and replace the element with a new CartItem when merging
  final updated = List<CartItem>.from(cartItemsNotifier.value);
  final index = updated.indexWhere((i) =>
      i.id == item.id && i.size == item.size && i.colour == item.colour);
  if (index >= 0) {
    final existing = updated[index];
    // create a new CartItem instead of mutating existing.quantity
    updated[index] = existing.copyWith(quantity: existing.quantity + item.quantity);
  } else {
    // add the provided item (it's already a separate instance)
    updated.add(item);
  }
  cartItemsNotifier.value = updated;
}

void removeFromCart(String id) {
  // produce a new List (no in-place mutation)
  final updated = cartItemsNotifier.value.where((i) => i.id != id).toList();
  cartItemsNotifier.value = updated;
}

void clearCart() {
  cartItemsNotifier.value = [];
}
