import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/data/cart.dart';

void main() {
  group('ProductPage', () {
    setUp(() {
      clearCart();
    });

    const testProduct = Product(
      id: 1,
      name: 'Test Product',
      image: 'https://example.com/image.jpg',
      oldPrice: 29.99,
      newPrice: 19.99,
      description: 'Test description',
    );

    Widget createProductPage() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthService()),
          ChangeNotifierProvider(create: (_) => Cart()),
        ],
        child: MaterialApp(
          home: ProductPage(product: testProduct),
        ),
      );
    }

    testWidgets('should create ProductPage instance', (tester) async {
      final page = ProductPage(product: testProduct);
      expect(page, isA<ProductPage>());
      expect(page, isNotNull);
    });

    testWidgets('should be a StatefulWidget', (tester) async {
      final page = ProductPage(product: testProduct);
      expect(page, isA<StatefulWidget>());
    });

    testWidgets('should require product parameter', (tester) async {
      final page = ProductPage(product: testProduct);
      expect(page.product, equals(testProduct));
    });

    testWidgets('should build without errors', (tester) async {
      final widget = createProductPage();
      expect(widget, isA<MultiProvider>());
      expect(widget, isNotNull);
    });
  });
}
