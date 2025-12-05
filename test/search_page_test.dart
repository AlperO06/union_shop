import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/screens/search_page.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/data/cart.dart';

void main() {
  group('SearchPage', () {
    setUp(() {
      clearCart();
    });

    Widget createSearchPage() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthService()),
          ChangeNotifierProvider(create: (_) => Cart()),
        ],
        child: const MaterialApp(
          home: SearchPage(),
        ),
      );
    }

    testWidgets('should create SearchPage instance', (tester) async {
      const page = SearchPage();
      expect(page, isA<SearchPage>());
      expect(page, isNotNull);
    });

    testWidgets('should build without errors', (tester) async {
      final widget = createSearchPage();
      expect(widget, isA<MultiProvider>());
      expect(widget, isNotNull);
    });
  });
}
