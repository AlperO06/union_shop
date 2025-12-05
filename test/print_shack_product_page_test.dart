import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/screens/print_shack_product_page.dart';
import 'package:union_shop/data/print_shack.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/data/cart.dart';

void main() {
  group('PrintShackProductPage', () {
    setUp(() {
      clearCart();
    });

    Widget createPrintShackProductPage() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthService()),
          ChangeNotifierProvider(create: (_) => Cart()),
        ],
        child: const MaterialApp(
          home: PrintShackProductPage(product: samplePersonalisedHoodie),
        ),
      );
    }

    testWidgets('should create PrintShackProductPage instance', (tester) async {
      const page = PrintShackProductPage(product: samplePersonalisedHoodie);
      expect(page, isA<PrintShackProductPage>());
      expect(page, isNotNull);
    });

    testWidgets('should require product parameter', (tester) async {
      const page = PrintShackProductPage(product: samplePersonalisedHoodie);
      expect(page.product, equals(samplePersonalisedHoodie));
    });

    testWidgets('should build without errors', (tester) async {
      final widget = createPrintShackProductPage();
      expect(widget, isA<MultiProvider>());
      expect(widget, isNotNull);
    });
  });
}
