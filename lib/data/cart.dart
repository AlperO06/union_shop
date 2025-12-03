import 'package:flutter/foundation.dart';

// Simple cart item model (expand as needed)
class CartItem {
  final String id;
  final String name;
  int quantity;

  // Added proper final fields for price, size, colour and image
  final double price;
  final String size;
  final String colour;
  final String image;

  // Updated constructor to initialize the new final fields
  CartItem({
    required this.id,
    required this.name,
    this.quantity = 1,
    required this.price,
    required this.size,
    required this.colour,
    required this.image,
  });
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
