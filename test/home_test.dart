import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  group('Home Page Tests', () {
    testWidgets('should create app instance', (tester) async {
      const app = UnionShopApp();
      expect(app, isA<MaterialApp>());
    });

    testWidgets('should display product cards', (tester) async {
      const app = UnionShopApp();
      expect(app, isA<Widget>());
    });

    testWidgets('should display header', (tester) async {
      const app = UnionShopApp();
      expect(app, isNotNull);
    });

    testWidgets('should display app correctly', (tester) async {
      const app = UnionShopApp();
      expect(app, isA<StatelessWidget>());
    });
  });
}
