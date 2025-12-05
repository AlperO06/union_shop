import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/data/print_shack.dart';

void main() {
  group('PrintShackData', () {
    test('should create PrintShackProduct instance', () {
      const product = PrintShackProduct(
        name: 'Test Product',
        pricePerLine: 5.0,
        maxCharsPerLine: 15,
      );

      expect(product, isA<PrintShackProduct>());
      expect(product, isNotNull);
    });

    test('should have required fields', () {
      const product = PrintShackProduct(
        name: 'Test Product',
        pricePerLine: 5.0,
        maxCharsPerLine: 15,
      );

      expect(product.name, 'Test Product');
      expect(product.pricePerLine, 5.0);
      expect(product.maxCharsPerLine, 15);
      expect(product.imageUrls, isEmpty);
    });

    test('should accept optional imageUrls', () {
      const product = PrintShackProduct(
        name: 'Test Product',
        pricePerLine: 5.0,
        maxCharsPerLine: 15,
        imageUrls: ['url1.jpg', 'url2.jpg'],
      );

      expect(product.imageUrls, ['url1.jpg', 'url2.jpg']);
    });

    test('should have samplePersonalisedHoodie', () {
      expect(samplePersonalisedHoodie, isA<PrintShackProduct>());
      expect(samplePersonalisedHoodie.name, 'Personalised Hoodie');
      expect(samplePersonalisedHoodie.pricePerLine, 3.0);
      expect(samplePersonalisedHoodie.maxCharsPerLine, 10);
    });

    test('should create copyWith', () {
      const product = PrintShackProduct(
        name: 'Original',
        pricePerLine: 5.0,
        maxCharsPerLine: 15,
      );

      final copy = product.copyWith(name: 'Modified');
      expect(copy.name, 'Modified');
      expect(copy.pricePerLine, 5.0);
      expect(copy.maxCharsPerLine, 15);
    });

    test('should serialize to JSON', () {
      const product = PrintShackProduct(
        name: 'Test',
        pricePerLine: 5.0,
        maxCharsPerLine: 15,
      );

      final json = product.toJson();
      expect(json['name'], 'Test');
      expect(json['pricePerLine'], 5.0);
      expect(json['maxCharsPerLine'], 15);
    });

    test('should deserialize from JSON', () {
      final json = {
        'name': 'Test',
        'pricePerLine': 5.0,
        'maxCharsPerLine': 15,
        'imageUrls': ['url1.jpg'],
      };

      final product = PrintShackProduct.fromJson(json);
      expect(product.name, 'Test');
      expect(product.pricePerLine, 5.0);
      expect(product.maxCharsPerLine, 15);
      expect(product.imageUrls, ['url1.jpg']);
    });
  });
}
