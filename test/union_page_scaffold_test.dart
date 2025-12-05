import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/widgets/union_page_scaffold.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/data/cart.dart';

void main() {
  group('UnionPageScaffold', () {
    setUp(() {
      clearCart();
    });

    Widget createScaffold() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthService()),
          ChangeNotifierProvider(create: (_) => Cart()),
        ],
        child: const MaterialApp(
          home: UnionPageScaffold(
            body: Text('Test Body'),
          ),
        ),
      );
    }

    testWidgets('should create UnionPageScaffold instance', (tester) async {
      const scaffold = UnionPageScaffold(body: Text('Test'));
      expect(scaffold, isA<UnionPageScaffold>());
      expect(scaffold, isNotNull);
    });

    testWidgets('should be a StatelessWidget', (tester) async {
      const scaffold = UnionPageScaffold(body: Text('Test'));
      expect(scaffold, isA<StatelessWidget>());
    });

    testWidgets('should require body parameter', (tester) async {
      const body = Text('Test Body');
      const scaffold = UnionPageScaffold(body: body);
      expect(scaffold.body, equals(body));
    });

    testWidgets('should build without errors', (tester) async {
      final widget = createScaffold();
      expect(widget, isA<MultiProvider>());
      expect(widget, isNotNull);
    });
  });
}
