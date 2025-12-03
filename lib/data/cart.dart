class CartItem {
  final int id;
  final String name;
  final double price;
  final String size;
  final String colour;
  int quantity;
  final String image;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    this.size = '',
    this.colour = '',
    this.quantity = 1,
    this.image = '',
  });

  @override
  String toString() {
    return 'CartItem(id: $id, name: $name, size: $size, colour: $colour, qty: $quantity)';
  }
}

final List<CartItem> cartItems = [];

void addToCart(CartItem item) {
  final index = cartItems.indexWhere((c) =>
      c.id == item.id && c.size == item.size && c.colour == item.colour);

  if (index >= 0) {
    cartItems[index].quantity += item.quantity;
  } else {
    cartItems.add(CartItem(
      id: item.id,
      name: item.name,
      price: item.price,
      size: item.size,
      colour: item.colour,
      quantity: item.quantity,
      image: item.image,
    ));
  }
}

void removeFromCart(CartItem item) {
  cartItems.remove(item);
}
