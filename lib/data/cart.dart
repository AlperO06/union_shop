import 'package:flutter/foundation.dart';

// Simple cart item model (expand as needed)
class CartItem {
  final String id;
  final String name;
  int quantity;

  CartItem({required this.id, required this.name, this.quantity = 1, required double price, required String size, required String colour, required String image});

  get price => null;

  get size => null;

  String? get image => null;
}

// Reactive list of cart items: listen to this to update UI immediately
final ValueNotifier<List<CartItem>> cartItemsNotifier = ValueNotifier<List<CartItem>>([]);

// Backwards-compatible getter used in existing code
List<CartItem> get cartItems => cartItemsNotifier.value;

// Helpers to modify the cart - these update the notifier's value so listeners rebuild
void addToCart(CartItem item) {
  final updated = List<CartItem>.from(cartItemsNotifier.value);
  updated.add(item);
  cartItemsNotifier.value = updated;
}

void removeFromCart(String id) {
  final updated = cartItemsNotifier.value.where((i) => i.id != id).toList();
  cartItemsNotifier.value = updated;
}

void clearCart() {
  cartItemsNotifier.value = [];
}
