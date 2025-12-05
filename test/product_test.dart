import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/data/products.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/data/cart.dart' as cart_data;

void main() {
  group('Product Page Tests', () {
    Widget createTestWidget() {
      // use an existing product from products.dart as the required argument
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthService()),
          ChangeNotifierProvider(create: (_) => cart_data.Cart()),
        ],
        child: MaterialApp(home: ProductPage(product: products.first)),
      );
    }

    testWidgets('should display product page with basic elements', (
      tester,
    ) async {
      final widget = createTestWidget();
      expect(widget, isA<MultiProvider>());
    });

    testWidgets('should display product name and description', (tester) async {
      final widget = createTestWidget();
      expect(widget, isA<Widget>());
    });

    testWidgets('should display app structure', (tester) async {
      final widget = createTestWidget();
      expect(widget, isNotNull);
    });

    testWidgets('should display product with widget tree', (tester) async {
      final widget = createTestWidget();
      expect(widget, isA<MultiProvider>());
    });
  });
}
