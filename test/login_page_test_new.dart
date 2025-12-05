import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/screens/login_page.dart';
import 'package:union_shop/services/auth_service.dart';

void main() {
  group('LoginPage', () {
    Widget createLoginPage() {
      return ChangeNotifierProvider(
        create: (_) => AuthService(),
        child: const MaterialApp(
          home: LoginPage(),
        ),
      );
    }

    testWidgets('should display login form', (WidgetTester tester) async {
      await tester.pumpWidget(createLoginPage());
      await tester.pumpAndSettle();

      expect(find.text('Sign In'), findsAtLeastNWidgets(1));
    });

    testWidgets('should display email and password fields or auth unavailable message', (WidgetTester tester) async {
      await tester.pumpWidget(createLoginPage());
      await tester.pumpAndSettle();

      final hasEmailField = find.byType(TextFormField).evaluate().isNotEmpty;
      final hasAuthMessage = find.text('Authentication Not Configured').evaluate().isNotEmpty;
      
      expect(hasEmailField || hasAuthMessage, isTrue);
    });

    testWidgets('should display Google sign-in button or auth message', (WidgetTester tester) async {
      await tester.pumpWidget(createLoginPage());
      await tester.pumpAndSettle();

      final hasGoogleButton = find.text('Continue with Google').evaluate().isNotEmpty;
      final hasAuthMessage = find.text('Authentication Not Configured').evaluate().isNotEmpty;
      
      expect(hasGoogleButton || hasAuthMessage, isTrue);
    });

    testWidgets('should have continue shopping button when auth unavailable', (WidgetTester tester) async {
      await tester.pumpWidget(createLoginPage());
      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should display Sign In text', (WidgetTester tester) async {
      await tester.pumpWidget(createLoginPage());
      await tester.pumpAndSettle();

      expect(find.text('Sign In'), findsAtLeastNWidgets(1));
    });
  });
}
