
class Product {
  final int id;
  final String name;
  final String image;
  final double oldPrice;
  final double newPrice;
  final String description;
  final List<String>? images;
  final List<String>? sizes;
  final List<String>? colors;

  const Product({
    required this.id,
    required this.name,
    required this.image,
    required this.oldPrice,
    required this.newPrice,
    required this.description,
    this.images,
    this.sizes,
    this.colors,
  });
}