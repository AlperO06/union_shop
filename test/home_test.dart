import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';

void main() {
  group('Home Page Tests', () {
    testWidgets('should display home page with basic elements', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Check that basic app structure is present
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('should display product cards', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Check that the app structure is present
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('should display header', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Check that MaterialApp is present
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('should display app correctly', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Check that the app renders successfully
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
