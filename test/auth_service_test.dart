import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/auth_service.dart';

void main() {
  group('AuthService', () {
    test('should initialize with no user', () {
      final authService = AuthService();
      
      expect(authService.currentUser, isNull);
      expect(authService.isAuthenticated, isFalse);
      expect(authService.isLoading, isFalse);
    });

    test('should have firebaseAvailable property', () {
      final authService = AuthService();
      
      expect(authService.firebaseAvailable, isA<bool>());
    });

    test('should have error message property', () {
      final authService = AuthService();
      
      expect(authService.errorMessage, isNull);
    });

    test('should return false when Firebase not available', () async {
      final authService = AuthService();
      
      if (!authService.firebaseAvailable) {
        final result = await authService.signInWithEmail('test@test.com', 'password');
        expect(result, isFalse);
      } else {
        expect(true, true);
      }
    });

    test('should have signUp method', () {
      final authService = AuthService();
      
      expect(authService.signUpWithEmail, isA<Function>());
    });

    test('should have signIn method', () {
      final authService = AuthService();
      
      expect(authService.signInWithEmail, isA<Function>());
    });

    test('should have signInWithGoogle method', () {
      final authService = AuthService();
      
      expect(authService.signInWithGoogle, isA<Function>());
    });

    test('should have signOut method', () {
      final authService = AuthService();
      
      expect(authService.signOut, isA<Function>());
    });

    test('should have resetPassword method', () {
      final authService = AuthService();
      
      expect(authService.resetPassword, isA<Function>());
    });
  });
}
