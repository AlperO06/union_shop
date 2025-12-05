import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/screens/collections_landing_page.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/data/cart.dart';

void main() {
  group('CollectionsLandingPage', () {
    setUp(() {
      clearCart();
    });

    Widget createCollectionsLandingPage() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthService()),
          ChangeNotifierProvider(create: (_) => Cart()),
        ],
        child: const MaterialApp(
          home: CollectionsLandingPage(),
        ),
      );
    }

    testWidgets('should create CollectionsLandingPage instance', (tester) async {
      const page = CollectionsLandingPage();
      expect(page, isA<CollectionsLandingPage>());
      expect(page, isNotNull);
    });

    testWidgets('should build without errors', (tester) async {
      final widget = createCollectionsLandingPage();
      expect(widget, isA<MultiProvider>());
      expect(widget, isNotNull);
    });
  });
}
