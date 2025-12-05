import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('Product', () {
    test('should create Product instance', () {
      const product = Product(
        id: 1,
        name: 'Test Product',
        image: 'https://example.com/image.jpg',
        oldPrice: 29.99,
        newPrice: 19.99,
        description: 'Test description',
      );
      
      expect(product, isA<Product>());
      expect(product, isNotNull);
    });

    test('should have required fields', () {
      const product = Product(
        id: 1,
        name: 'Test Product',
        image: 'https://example.com/image.jpg',
        oldPrice: 29.99,
        newPrice: 19.99,
        description: 'Test description',
      );

      expect(product.id, 1);
      expect(product.name, 'Test Product');
      expect(product.image, 'https://example.com/image.jpg');
      expect(product.oldPrice, 29.99);
      expect(product.newPrice, 19.99);
      expect(product.description, 'Test description');
    });

    test('should accept optional fields', () {
      const product = Product(
        id: 1,
        name: 'Test Product',
        image: 'https://example.com/image.jpg',
        oldPrice: 29.99,
        newPrice: 19.99,
        description: 'Test description',
        images: ['image1.jpg', 'image2.jpg'],
        sizes: ['S', 'M', 'L'],
        colors: ['Red', 'Blue'],
      );

      expect(product.images, ['image1.jpg', 'image2.jpg']);
      expect(product.sizes, ['S', 'M', 'L']);
      expect(product.colors, ['Red', 'Blue']);
    });

    test('should have null optional fields by default', () {
      const product = Product(
        id: 1,
        name: 'Test Product',
        image: 'https://example.com/image.jpg',
        oldPrice: 29.99,
        newPrice: 19.99,
        description: 'Test description',
      );

      expect(product.images, isNull);
      expect(product.sizes, isNull);
      expect(product.colors, isNull);
    });
  });
}
