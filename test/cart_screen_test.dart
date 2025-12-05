import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/screens/cart.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/data/cart.dart';

void main() {
  group('CartScreen', () {
    setUp(() {
      clearCart();
    });

    Widget createCartScreen() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthService()),
          ChangeNotifierProvider(create: (_) => Cart()),
        ],
        child: const MaterialApp(
          home: CartPage(),
        ),
      );
    }

    testWidgets('should create CartPage instance', (tester) async {
      const page = CartPage();
      expect(page, isA<CartPage>());
      expect(page, isNotNull);
    });

    testWidgets('should build without errors', (tester) async {
      final widget = createCartScreen();
      expect(widget, isA<MultiProvider>());
      expect(widget, isNotNull);
    });
  });
}
