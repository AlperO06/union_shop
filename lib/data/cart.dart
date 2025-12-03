import 'dart:convert';
import 'dart:async';
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
  // Reworked to guarantee non-null fields and robust parsing.
  factory CartItem.fromMap(Map<String, dynamic> map) {
    // Local helper parsers to ensure non-null values and safe defaults.
    String parseString(dynamic v) {
      if (v == null) return '';
      try {
        return v.toString();
      } catch (_) {
        return '';
      }
    }

    int parseInt(dynamic v, [int fallback = 1]) {
      if (v == null) return fallback;
      if (v is int) return v;
      if (v is double) return v.toInt();
      final s = v.toString();
      return int.tryParse(s) ?? fallback;
    }

    double parseDouble(dynamic v, [double fallback = 0.0]) {
      if (v == null) return fallback;
      if (v is double) return v;
      if (v is int) return v.toDouble();
      final s = v.toString();
      return double.tryParse(s) ?? fallback;
    }

    final id = parseString(map['id']);
    final name = parseString(map['name']);
    final quantity = parseInt(map['quantity'], 1);
    final price = parseDouble(map['price'], 0.0);
    final size = parseString(map['size']);
    final colour = parseString(map['colour']);
    final image = parseString(map['image']);

    return CartItem(
      id: id,
      name: name,
      quantity: quantity,
      price: price,
      size: size,
      colour: colour,
      image: image,
    );
  }

  // Added: JSON helpers using existing map (defensive on parse errors)
  String toJson() => jsonEncode(toMap());

  // Hardened fromJson: accepts JSON string or Map-like values and always
  // returns a CartItem with non-null fields (defaults applied).
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
    // Return safe default instance (no nulls).
    return CartItem(id: '', name: '', quantity: 1, price: 0.0, size: '', colour: '', image: '');
  }

  // Convenience factory: accept null / String / Map and always return a non-null instance.
  factory CartItem.safeFrom(dynamic source) {
    if (source == null) {
      return CartItem(id: '', name: '', quantity: 1, price: 0.0, size: '', colour: '', image: '');
    }
    if (source is String) {
      return CartItem.fromJson(source);
    }
    if (source is Map<String, dynamic>) {
      return CartItem.fromMap(source);
    }
    if (source is Map) {
      return CartItem.fromMap(Map<String, dynamic>.from(source));
    }
    // Fallback safe default.
    return CartItem(id: '', name: '', quantity: 1, price: 0.0, size: '', colour: '', image: '');
  }
}

// Reactive list of cart items: listen to this to update UI immediately
// Use a plain ValueNotifier instead of the removed PersistentCartNotifier.
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
    // Debug: log save operation and payload size (safe for development)
    debugPrint('Saving cart to SharedPreferences ($_kCartPrefsKey) with ${list.length} items.');
    debugPrint('Cart payload: $encoded');
    await prefs.setString(_kCartPrefsKey, encoded);
    debugPrint('Cart successfully saved.');
  } catch (e, st) {
    // log error for diagnostics but don't crash the app
    debugPrint('Failed to save cart to prefs: $e\n$st');
  }
}

Future<void> loadCartFromPrefs() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final encoded = prefs.getString(_kCartPrefsKey);
    if (encoded == null || encoded.isEmpty) {
      debugPrint('No saved cart found in SharedPreferences ($_kCartPrefsKey).');
      return;
    }

    debugPrint('Found saved cart payload: $encoded');

    dynamic decoded;
    try {
      decoded = jsonDecode(encoded);
    } catch (e, st) {
      debugPrint('Warning: corrupt cart JSON detected; clearing saved cart. Error: $e\n$st');
      // Remove corrupted value to avoid repeated failures.
      try {
        await prefs.remove(_kCartPrefsKey);
      } catch (removeErr) {
        debugPrint('Failed to remove corrupted cart key: $removeErr');
      }
      cartItemsNotifier.value = [];
      return;
    }

    if (decoded is! List) {
      debugPrint('Warning: saved cart payload has unexpected type ${decoded.runtimeType}; clearing saved cart.');
      try {
        await prefs.remove(_kCartPrefsKey);
      } catch (removeErr) {
        debugPrint('Failed to remove unexpected cart payload: $removeErr');
      }
      cartItemsNotifier.value = [];
      return;
    }

    final restored = <CartItem>[];
    var invalidFound = false;

    for (final item in decoded) {
      try {
        final ci = CartItem.safeFrom(item);
        // validate essential fields
        if (ci.id.isEmpty || ci.name.isEmpty) {
          debugPrint('Warning: cart item missing required id/name; abandoning restore.');
          invalidFound = true;
          break;
        }
        restored.add(ci);
      } catch (e, st) {
        debugPrint('Warning: failed to parse a cart item; abandoning restore. Error: $e\n$st');
        invalidFound = true;
        break;
      }
    }

    if (invalidFound) {
      try {
        await prefs.remove(_kCartPrefsKey);
      } catch (removeErr) {
        debugPrint('Failed to remove invalid cart payload: $removeErr');
      }
      cartItemsNotifier.value = [];
      return;
    }

    // Successful restore
    cartItemsNotifier.value = restored;
    debugPrint('Loaded ${restored.length} cart items from prefs.');
  } catch (e, st) {
    debugPrint('Failed to load cart from prefs: $e\n$st. Clearing in-memory cart to be safe.');
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_kCartPrefsKey);
    } catch (_) {}
    try {
      cartItemsNotifier.value = [];
    } catch (_) {}
  } finally {
    // Always attach the persistence listener so future changes are persisted.
    _attachPersistenceListener();
  }
}

// Add a named top-level listener function to avoid potential initialization-order issues
// and to ensure a stable identity for removeListener/addListener.
void _cartPersistenceListener() {
  // call the async saver but don't await here (listener must be a void callback).
  _saveCartToPrefs();
}

bool _persistenceListenerAttached = false;

void _attachPersistenceListener() {

  try {
    cartItemsNotifier.removeListener(_cartPersistenceListener);
  } catch (_) {
    // ignore removal errors
  }
  cartItemsNotifier.addListener(_cartPersistenceListener);
  _persistenceListenerAttached = true;
}

// Public wrapper so callers (e.g. main.dart) can enable the listener.
void enableCartPersistence() => _attachPersistenceListener();

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
  // Setting .value will notify listeners (including the persistence listener).
  cartItemsNotifier.value = updated;
  // No direct call to _saveCartToPrefs() here — persistence is handled by the listener.
}

void removeFromCart(String id) {
  final updated = cartItemsNotifier.value.where((i) => i.id != id).toList();
  // Setting .value will notify listeners (including the persistence listener).
  cartItemsNotifier.value = List<CartItem>.from(updated);
  // Removed explicit notifyListeners() and direct _saveCartToPrefs() call.
}

void clearCart() {
  cartItemsNotifier.value = [];
  // Persistence handled by the listener; no direct _saveCartToPrefs() call.
}

// Public wrapper so callers can explicitly await a save operation.
// This forwards to the internal async saver.
Future<void> saveCartToPrefs() => _saveCartToPrefs();
