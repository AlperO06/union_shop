import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/screens/order_history.dart';

void main() {
  group('OrderHistory', () {
    Widget createOrderHistory() {
      return const MaterialApp(
        home: OrderHistoryPage(),
      );
    }

    testWidgets('should display scaffold', (WidgetTester tester) async {
      await tester.pumpWidget(createOrderHistory());
      await tester.pump();

      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should have app bar', (WidgetTester tester) async {
      await tester.pumpWidget(createOrderHistory());
      await tester.pump();

      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('should display Order History text', (WidgetTester tester) async {
      await tester.pumpWidget(createOrderHistory());
      await tester.pump();

      expect(find.text('Order History'), findsOneWidget);
    });

    testWidgets('should display mock orders', (WidgetTester tester) async {
      await tester.pumpWidget(createOrderHistory());
      await tester.pumpAndSettle();

      expect(find.byType(Card), findsWidgets);
    });

    testWidgets('should build without errors', (WidgetTester tester) async {
      await tester.pumpWidget(createOrderHistory());
      await tester.pumpAndSettle();

      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
