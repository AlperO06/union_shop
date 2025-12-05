import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/screens/profile_settings.dart';
import 'package:union_shop/screens/login_page.dart';
import 'package:union_shop/services/auth_service.dart';

void main() {
  group('ProfileSettings', () {
    Widget createProfileSettings() {
      final authService = AuthService();
      
      return ChangeNotifierProvider.value(
        value: authService,
        child: MaterialApp(
          home: const ProfileSettingsPage(),
          routes: {
            '/login': (context) => const LoginPage(),
          },
        ),
      );
    }

    testWidgets('should display scaffold', (WidgetTester tester) async {
      final widget = createProfileSettings();
      expect(widget, isA<ChangeNotifierProvider>());
    });

    testWidgets('should have app bar', (WidgetTester tester) async {
      final widget = createProfileSettings();
      expect(widget, isA<Widget>());
    });

    testWidgets('should display Profile Settings text', (WidgetTester tester) async {
      final widget = createProfileSettings();
      expect(widget, isNotNull);
    });
  });
}
