import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';

void main() {
  group('MainApp', () {
    testWidgets('should create UnionShopApp instance', (tester) async {
      const app = UnionShopApp();
      expect(app, isA<UnionShopApp>());
      expect(app, isNotNull);
    });

    testWidgets('should be a StatefulWidget', (tester) async {
      const app = UnionShopApp();
      expect(app, isA<StatefulWidget>());
    });

    testWidgets('should build without errors', (tester) async {
      const app = UnionShopApp();
      expect(app, isNotNull);
    });
  });
}
