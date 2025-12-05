import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';

void main() {
  group('Home Page Tests', () {
    testWidgets('should display home page with basic elements', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Check that basic app structure is present
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('should display product cards', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Check that product cards are displayed by looking for actual product names
      expect(find.textContaining('Edition'), findsWidgets);
      // Check price symbols are displayed
      expect(find.textContaining('£'), findsWidgets);
    });

    testWidgets('should display header icons', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Check that header icons are present
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
    testWidgets('should display header', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();
    testWidgets('should display app correctly', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Check that the app renders successfully
      expect(find.byType(MaterialApp), findsOneWidget);
    });
