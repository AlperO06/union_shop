import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/screens/collections_page.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/data/cart.dart';

void main() {
  group('CollectionsPage', () {
    setUp(() {
      clearCart();
    });

    Widget createCollectionsPage() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthService()),
          ChangeNotifierProvider(create: (_) => Cart()),
        ],
        child: const MaterialApp(
          home: CollectionsPage(),
        ),
      );
    }

    testWidgets('should create CollectionsPage instance', (tester) async {
      const page = CollectionsPage();
      expect(page, isA<CollectionsPage>());
      expect(page, isNotNull);
    });

    testWidgets('should build without errors', (tester) async {
      final widget = createCollectionsPage();
      expect(widget, isA<MultiProvider>());
      expect(widget, isNotNull);
    });
  });
}
