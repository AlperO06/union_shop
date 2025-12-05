import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/screens/account_dashboard.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/models/user.dart';

class MockAuthService extends ChangeNotifier implements AuthService {
  AppUser? _currentUser;

  @override
  AppUser? get currentUser => _currentUser;

  void setUser(AppUser? user) {
    _currentUser = user;
    notifyListeners();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('AccountDashboard', () {
    Widget createDashboard(AppUser? user) {
      final authService = MockAuthService();
      authService.setUser(user);
      
      return ChangeNotifierProvider<AuthService>.value(
        value: authService,
        child: MaterialApp(
          home: const AccountDashboard(),
          routes: {
            '/login': (context) => const Scaffold(body: Text('Login')),
            '/order-history': (context) => const Scaffold(body: Text('Orders')),
            '/profile-settings': (context) => const Scaffold(body: Text('Settings')),
          },
        ),
      );
    }

    testWidgets('should display scaffold', (WidgetTester tester) async {
      await tester.pumpWidget(createDashboard(null));
      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should have app bar', (WidgetTester tester) async {
      await tester.pumpWidget(createDashboard(null));
      await tester.pumpAndSettle();

      expect(find.byType(AppBar), findsWidgets);
    });

    testWidgets('should display My Account text', (WidgetTester tester) async {
      final user = AppUser(
        uid: 'test123',
        email: 'test@test.com',
        displayName: 'Test User',
      );
      
      await tester.pumpWidget(createDashboard(user));
      await tester.pumpAndSettle();

      expect(find.text('My Account'), findsWidgets);
    });

    testWidgets('should build without errors', (WidgetTester tester) async {
      await tester.pumpWidget(createDashboard(null));
      await tester.pumpAndSettle();

      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
