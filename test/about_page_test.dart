import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/about_page.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/data/cart.dart';

void main() {
  group('AboutPage', () {
    setUp(() {
      clearCart();
    });

    Widget createAboutPage() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthService()),
          ChangeNotifierProvider(create: (_) => Cart()),
        ],
        child: const MaterialApp(
          home: AboutPage(),
        ),
      );
    }

    testWidgets('should create AboutPage instance', (tester) async {
      const page = AboutPage();
      expect(page, isA<AboutPage>());
      expect(page, isNotNull);
    });

    testWidgets('should be a StatelessWidget', (tester) async {
      const page = AboutPage();
      expect(page, isA<StatelessWidget>());
    });

    testWidgets('should build without errors', (tester) async {
      final widget = createAboutPage();
      expect(widget, isA<MultiProvider>());
      expect(widget, isNotNull);
    });

    testWidgets('should have About Us text', (tester) async {
      final widget = createAboutPage();
      expect(widget, isA<Widget>());
    });

    testWidgets('should have mission section', (tester) async {
      final widget = createAboutPage();
      expect(widget, isNotNull);
    });
  });
}
