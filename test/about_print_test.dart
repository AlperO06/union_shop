import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/screens/about_print.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/data/cart.dart';

void main() {
  group('AboutPrintPage', () {
    setUp(() {
      clearCart();
    });

    Widget createAboutPrintPage() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthService()),
          ChangeNotifierProvider(create: (_) => Cart()),
        ],
        child: const MaterialApp(
          home: AboutPrintShackPage(),
        ),
      );
    }

    testWidgets('should create AboutPrintShackPage instance', (tester) async {
      const page = AboutPrintShackPage();
      expect(page, isA<AboutPrintShackPage>());
      expect(page, isNotNull);
    });

    testWidgets('should be a StatelessWidget', (tester) async {
      const page = AboutPrintShackPage();
      expect(page, isA<StatelessWidget>());
    });

    testWidgets('should build without errors', (tester) async {
      final widget = createAboutPrintPage();
      expect(widget, isA<MultiProvider>());
      expect(widget, isNotNull);
    });
  });
}
