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
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check that basic UI elements are present
      expect(
        find.text('Limited Edition Essential Zip Hoodie'),
        findsOneWidget,
      );
      expect(find.text('Description'), findsOneWidget);
      // Check for price - using substring match
      expect(find.textContaining('£'), findsWidgets);
    });

    testWidgets('should display product name and description', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check that product name and description label exist
      expect(
        find.text('Limited Edition Essential Zip Hoodie'),
        findsOneWidget,
      );
      expect(find.text('Description'), findsOneWidget);
    });

    testWidgets('should display app structure', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check that basic app structure is present
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('should display product with widget tree', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check that product page renders
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
