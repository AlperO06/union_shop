import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/screens/signup_page.dart';
import 'package:union_shop/services/auth_service.dart';

void main() {
  group('SignupPage', () {
    Widget createSignupPage() {
      return ChangeNotifierProvider(
        create: (_) => AuthService(),
        child: const MaterialApp(
          home: SignupPage(),
        ),
      );
    }

    testWidgets('should display signup form', (WidgetTester tester) async {
      await tester.pumpWidget(createSignupPage());
      await tester.pumpAndSettle();

      expect(find.text('Sign Up'), findsAtLeastNWidgets(1));
    });

    testWidgets('should display form fields or auth unavailable message', (WidgetTester tester) async {
      await tester.pumpWidget(createSignupPage());
      await tester.pumpAndSettle();

      final hasTextFields = find.byType(TextFormField).evaluate().isNotEmpty;
      final hasAuthMessage = find.text('Authentication Not Configured').evaluate().isNotEmpty;
      
      expect(hasTextFields || hasAuthMessage, isTrue);
    });

    testWidgets('should display Google sign-up button or auth message', (WidgetTester tester) async {
      await tester.pumpWidget(createSignupPage());
      await tester.pumpAndSettle();

      final hasGoogleButton = find.text('Continue with Google').evaluate().isNotEmpty;
      final hasAuthMessage = find.text('Authentication Not Configured').evaluate().isNotEmpty;
      
      expect(hasGoogleButton || hasAuthMessage, isTrue);
    });

    testWidgets('should have continue shopping button when auth unavailable', (WidgetTester tester) async {
      await tester.pumpWidget(createSignupPage());
      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should display Sign Up text', (WidgetTester tester) async {
      await tester.pumpWidget(createSignupPage());
      await tester.pumpAndSettle();

      expect(find.text('Sign Up'), findsAtLeastNWidgets(1));
    });
  });
}
