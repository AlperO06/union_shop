// Auto-generated products list

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

class Product {
  final int id;
  final String name;
  final String image;
  final double oldPrice;
  final double newPrice;
  final String description;

  const Product({
    required this.id,
    required this.name,
    required this.image,
    required this.oldPrice,
    required this.newPrice,
    required this.description,
  });

  get images => null;
}

const List<Product> products = [
  Product(
    id: 1,
    name: 'Limited Edition Essential Zip Hoodie',
    oldPrice: 79.99,
    newPrice: 59.99,
    image: 'assets/images/limited_hoodie.png',
    description:
        'A premium limited edition zip hoodie with soft brushed interior, metal zipper, and a tailored fit.',
  ),
  Product(
    id: 2,
    name: 'Essential T-Shirt',
    oldPrice: 29.99,
    newPrice: 24.99,
    image: 'assets/images/essential_tshirt.png',
    description: 'A soft, breathable cotton tee with a classic fit—perfect for everyday wear.',
  ),
  Product(
    id: 3,
    name: 'Signature Hoodie',
    oldPrice: 89.99,
    newPrice: 69.99,
    image: 'assets/images/signature_hoodie.png',
    description:
        'Premium heavyweight fleece hoodie featuring embroidered logo and reinforced seams for lasting comfort.',
  ),
  Product(
    id: 4,
    name: 'Signature T-Shirt',
    oldPrice: 34.99,
    newPrice: 29.99,
    image: 'assets/images/signature_tshirt.png',
    description: 'Premium cotton tee with signature print and a tailored cut for a modern look.',
  ),
];
