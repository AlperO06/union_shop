import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/screens/sale_page.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/data/cart.dart' as cart_data;

void main() {
  group('SalePage', () {
    Widget createSalePage() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthService()),
          ChangeNotifierProvider(create: (_) => cart_data.Cart()),
        ],
        child: const MaterialApp(
          home: SalePage(),
        ),
      );
    }

    testWidgets('should display sale page', (WidgetTester tester) async {
      await tester.pumpWidget(createSalePage());
      await tester.pumpAndSettle();

      expect(find.text('SALE'), findsOneWidget);
    });

    testWidgets('should display sale subtitle', (WidgetTester tester) async {
      await tester.pumpWidget(createSalePage());
      await tester.pumpAndSettle();

      expect(find.textContaining('Don\'t miss out'), findsOneWidget);
    });

    testWidgets('should display filter and sort options', (WidgetTester tester) async {
      await tester.pumpWidget(createSalePage());
      await tester.pumpAndSettle();

      expect(find.text('FILTER BY'), findsWidgets);
      expect(find.text('SORT BY'), findsWidgets);
    });

    testWidgets('should display product grid', (WidgetTester tester) async {
      await tester.pumpWidget(createSalePage());
      await tester.pumpAndSettle();

      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('should display product count', (WidgetTester tester) async {
      await tester.pumpWidget(createSalePage());
      await tester.pumpAndSettle();

      expect(find.textContaining('products'), findsWidgets);
    });

    testWidgets('should build without errors', (WidgetTester tester) async {
      await tester.pumpWidget(createSalePage());
      await tester.pumpAndSettle();

      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
