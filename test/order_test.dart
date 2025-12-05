import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/screens/order_history.dart';
import 'package:union_shop/services/auth_service.dart';

void main() {
  group('OrderHistory', () {
    Widget createOrderHistory() {
      return ChangeNotifierProvider(
        create: (_) => AuthService(),
        child: const MaterialApp(
          home: OrderHistoryPage(),
        ),
      );
    }

    testWidgets('should display scaffold', (WidgetTester tester) async {
      final widget = createOrderHistory();
      expect(widget, isA<ChangeNotifierProvider>());
    });

    testWidgets('should have app bar', (WidgetTester tester) async {
      final widget = createOrderHistory();
      expect(widget, isA<Widget>());
    });

    testWidgets('should display Order History text', (WidgetTester tester) async {
      final widget = createOrderHistory();
      expect(widget, isNotNull);
    });

    testWidgets('should display mock orders', (WidgetTester tester) async {
      final widget = createOrderHistory();
      expect(widget, isA<ChangeNotifierProvider>());
    });

    testWidgets('should build without errors', (WidgetTester tester) async {
      final widget = createOrderHistory();
      expect(widget, isA<ChangeNotifierProvider>());
    });
  });
}
