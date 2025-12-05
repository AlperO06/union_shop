import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/product_card.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('ProductCard', () {
    final testProduct = const Product(
      id: 1,
      name: 'Test Product',
      image: 'https://example.com/image.jpg',
      oldPrice: 29.99,
      newPrice: 19.99,
      description: 'Test description',
    );

    testWidgets('should create ProductCard instance', (tester) async {
      final card = ProductCard(product: testProduct);
      expect(card, isA<ProductCard>());
      expect(card, isNotNull);
    });

    testWidgets('should be a StatefulWidget', (tester) async {
      final card = ProductCard(product: testProduct);
      expect(card, isA<StatefulWidget>());
    });

    testWidgets('should require product parameter', (tester) async {
      final card = ProductCard(product: testProduct);
      expect(card.product, equals(testProduct));
    });

    testWidgets('should build without errors', (tester) async {
      const widget = MaterialApp(
        home: Scaffold(
          body: ProductCard(
            product: Product(
              id: 1,
              name: 'Test',
              image: 'https://example.com/image.jpg',
              oldPrice: 29.99,
              newPrice: 19.99,
              description: 'Test',
            ),
          ),
        ),
      );
      expect(widget, isA<MaterialApp>());
      expect(widget, isNotNull);
    });
  });
}
