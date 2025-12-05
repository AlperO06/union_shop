import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/data/products.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('ProductsData', () {
    test('should have products list', () {
      expect(products, isA<List<Product>>());
      expect(products, isNotNull);
    });

    test('should not be empty', () {
      expect(products.isNotEmpty, true);
    });

    test('should contain valid Product objects', () {
      for (final product in products) {
        expect(product, isA<Product>());
        expect(product.id, isNotNull);
        expect(product.name, isNotNull);
        expect(product.image, isNotNull);
        expect(product.oldPrice, isNotNull);
        expect(product.newPrice, isNotNull);
        expect(product.description, isNotNull);
      }
    });

    test('should have unique product IDs', () {
      final ids = products.map((p) => p.id).toSet();
      expect(ids.length, products.length);
    });

    test('should have valid prices', () {
      for (final product in products) {
        expect(product.oldPrice >= 0, true);
        expect(product.newPrice >= 0, true);
        expect(product.newPrice <= product.oldPrice, true);
      }
    });
  });
}
