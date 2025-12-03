import 'package:flutter/foundation.dart';

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
}

// Reactive list of cart items: listen to this to update UI immediately
final ValueNotifier<List<CartItem>> cartItemsNotifier = ValueNotifier<List<CartItem>>([]);

// Backwards-compatible getter used in existing code
List<CartItem> get cartItems => cartItemsNotifier.value;

// Helpers to modify the cart - these update the notifier's value so listeners rebuild
void addToCart(CartItem item) {
  final updated = List<CartItem>.from(cartItemsNotifier.value);
  // Find existing item with same id, size and colour and merge quantities
  final index = updated.indexWhere((i) =>
      i.id == item.id && i.size == item.size && i.colour == item.colour);
  if (index >= 0) {
    updated[index].quantity += item.quantity;
  } else {
    updated.add(item);
  }
  cartItemsNotifier.value = updated;
}

void removeFromCart(String id) {
  final updated = cartItemsNotifier.value.where((i) => i.id != id).toList();
  cartItemsNotifier.value = updated;
}

void clearCart() {
  cartItemsNotifier.value = [];
}
