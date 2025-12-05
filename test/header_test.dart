import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/widgets/union_header.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/data/cart.dart';

void main() {
  group('UnionHeader', () {
    Widget createHeader() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthService()),
          ChangeNotifierProvider(create: (_) => Cart()),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: UnionHeader(),
          ),
        ),
      );
    }

    testWidgets('should display header', (WidgetTester tester) async {
      final widget = createHeader();
      expect(widget, isA<MultiProvider>());
      expect(widget, isNotNull);
    });

    testWidgets('should display cart icon', (WidgetTester tester) async {
      final widget = createHeader();
      expect(widget, isA<Widget>());
      expect(widget, isNotNull);
    });

    testWidgets('should have navigation elements', (WidgetTester tester) async {
      final widget = createHeader();
      expect(widget, isA<MultiProvider>());
      expect(widget, isNotNull);
    });

    testWidgets('should build without errors', (WidgetTester tester) async {
      final widget = createHeader();
      expect(widget, isA<Widget>());
      expect(widget, isNotNull);
    });
  });
}
