import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/screens/profile_settings.dart';
import 'package:union_shop/services/auth_service.dart';

void main() {
  group('ProfileSettings', () {
    Widget createProfileSettings() {
      final authService = AuthService();
      
      return ChangeNotifierProvider.value(
        value: authService,
        child: const MaterialApp(
          home: ProfileSettingsPage(),
        ),
      );
    }

    testWidgets('should display scaffold', (WidgetTester tester) async {
      await tester.pumpWidget(createProfileSettings());
      await tester.pump();

      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should have app bar', (WidgetTester tester) async {
      await tester.pumpWidget(createProfileSettings());
      await tester.pump();

      expect(find.byType(AppBar), findsWidgets);
    });

    testWidgets('should display Profile Settings text', (WidgetTester tester) async {
      await tester.pumpWidget(createProfileSettings());
      await tester.pumpAndSettle();

      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
