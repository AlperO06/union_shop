// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

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

const List<Product> products = [
  Product(
    id: 1,
    name: 'Limited Edition Essential Zip Hoodie',
    oldPrice: 79.99,
    newPrice: 59.99,
    image: 'https://picsum.photos/id/1011/800/600',
    description:
        'A premium limited edition zip hoodie with soft brushed interior, metal zipper, and a tailored fit.',
    images: [
      'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg',
      'https://shop.upsu.net/cdn/shop/files/PortsmouthCityBookmark1_1024x1024@2x.jpg',
    ],
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Black', 'Grey', 'Purple'],
  ),
  Product(
    id: 2,
    name: 'Essential T-Shirt',
    oldPrice: 29.99,
    newPrice: 24.99,
    image: 'https://picsum.photos/id/1015/800/600',
    description: 'A soft, breathable cotton tee with a classic fit—perfect for everyday wear.',
  ),
  Product(
    id: 3,
    name: 'Signature Hoodie',
    oldPrice: 89.99,
    newPrice: 69.99,
    image: 'https://picsum.photos/id/1025/800/600',
    description:
        'Premium heavyweight fleece hoodie featuring embroidered logo and reinforced seams for lasting comfort.',
  ),
  Product(
    id: 4,
    name: 'Signature T-Shirt',
    oldPrice: 34.99,
    newPrice: 29.99,
    image: 'https://picsum.photos/id/1035/800/600',
    description: 'Premium cotton tee with signature print and a tailored cut for a modern look.',
  ),
  // appended Portsmouth items
  Product(
    id: 5,
    name: 'Portsmouth City Postcard',
    oldPrice: 2.00,
    newPrice: 1.00,
    image: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_720x.jpg',
    description: 'A postcard featuring iconic Portsmouth landmarks.',
  ),
  Product(
    id: 6,
    name: 'Portsmouth City Magnet',
    oldPrice: 7.00,
    newPrice: 5.00,
    image: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_720x.jpg',
    description: 'A collectible magnet showcasing Portsmouth.',
  ),
  Product(
    id: 7,
    name: 'Portsmouth City Bookmark',
    oldPrice: 3.00,
    newPrice: 2.00,
    image: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityBookmark1_720x.jpg',
    description: 'A decorative Portsmouth bookmark.',
  ),
  Product(
    id: 8,
    name: 'Portsmouth Notebook',
    oldPrice: 6.00,
    newPrice: 4.50,
    image: 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityNotebook_720x.jpg',
    description: 'A Portsmouth themed notebook for notes and sketches.',
  ),
];
