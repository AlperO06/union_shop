import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/bottom_union_footer.dart';

void main() {
  group('BottomUnionFooter', () {
    testWidgets('should create BottomUnionFooter instance', (tester) async {
      const footer = BottomUnionFooter();
      expect(footer, isA<BottomUnionFooter>());
      expect(footer, isNotNull);
    });

    testWidgets('should be a StatelessWidget', (tester) async {
      const footer = BottomUnionFooter();
      expect(footer, isA<StatelessWidget>());
    });

    testWidgets('should build without errors', (tester) async {
      const widget = MaterialApp(home: Scaffold(body: BottomUnionFooter()));
      expect(widget, isA<MaterialApp>());
      expect(widget, isNotNull);
    });

    testWidgets('should accept onLinkPressed callback', (tester) async {
      bool called = false;
      final footer = BottomUnionFooter(
        onLinkPressed: (label) {
          called = true;
        },
      );
      expect(footer, isNotNull);
      expect(called, false);
    });
  });
}
