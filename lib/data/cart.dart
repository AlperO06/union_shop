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
