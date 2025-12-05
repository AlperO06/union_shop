import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/user.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  
  AppUser? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  AppUser? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;

  AuthService() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  void _onAuthStateChanged(User? firebaseUser) {
    if (firebaseUser != null) {
      _currentUser = AppUser.fromFirebaseUser(firebaseUser);
    } else {
      _currentUser = null;
    }
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  // Email/Password Sign Up
  Future<bool> signUpWithEmail(String email, String password, String displayName) async {
    try {
      _setLoading(true);
      _setError(null);

      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(displayName);
        await userCredential.user!.reload();
        _currentUser = AppUser.fromFirebaseUser(_auth.currentUser!);
        notifyListeners();
      }

      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      _setError(_getErrorMessage(e.code));
      return false;
    } catch (e) {
      _setLoading(false);
      _setError('An unexpected error occurred');
      return false;
    }
  }

  // Email/Password Sign In
  Future<bool> signInWithEmail(String email, String password) async {
    try {
      _setLoading(true);
      _setError(null);

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      _setError(_getErrorMessage(e.code));
      return false;
    } catch (e) {
      _setLoading(false);
      _setError('An unexpected error occurred');
      return false;
    }
  }

  // Google Sign In
  Future<bool> signInWithGoogle() async {
    try {
      _setLoading(true);
      _setError(null);

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        _setLoading(false);
        return false; // User canceled
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);

      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      _setError(_getErrorMessage(e.code));
      return false;
    } catch (e) {
      _setLoading(false);
      _setError('Google sign-in failed');
      return false;
    }
  }

  // Facebook Sign In
  Future<bool> signInWithFacebook() async {
    try {
      _setLoading(true);
      _setError(null);

      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final credential = FacebookAuthProvider.credential(accessToken.tokenString);

        await _auth.signInWithCredential(credential);
        
        _setLoading(false);
        return true;
      } else if (result.status == LoginStatus.cancelled) {
        _setLoading(false);
        return false; // User canceled
      } else {
        _setLoading(false);
        _setError('Facebook sign-in failed');
        return false;
      }
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      _setError(_getErrorMessage(e.code));
      return false;
    } catch (e) {
      _setLoading(false);
      _setError('Facebook sign-in failed');
      return false;
    }
  }

  // Password Reset
  Future<bool> resetPassword(String email) async {
    try {
      _setLoading(true);
      _setError(null);

      await _auth.sendPasswordResetEmail(email: email);

      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      _setError(_getErrorMessage(e.code));
      return false;
    } catch (e) {
      _setLoading(false);
      _setError('Failed to send password reset email');
      return false;
    }
  }

  // Update Profile
  Future<bool> updateProfile({String? displayName, String? photoUrl}) async {
    try {
      _setLoading(true);
      _setError(null);

      final user = _auth.currentUser;
      if (user == null) {
        _setError('No user logged in');
        _setLoading(false);
        return false;
      }

      if (displayName != null) {
        await user.updateDisplayName(displayName);
      }
      if (photoUrl != null) {
        await user.updatePhotoURL(photoUrl);
      }

      await user.reload();
      _currentUser = AppUser.fromFirebaseUser(_auth.currentUser!);
      
      _setLoading(false);
      notifyListeners();
      return true;
    } catch (e) {
      _setLoading(false);
      _setError('Failed to update profile');
      return false;
    }
  }

  // Update Email
  Future<bool> updateEmail(String newEmail) async {
    try {
      _setLoading(true);
      _setError(null);

      final user = _auth.currentUser;
      if (user == null) {
        _setError('No user logged in');
        _setLoading(false);
        return false;
      }

      await user.verifyBeforeUpdateEmail(newEmail);

      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      _setError(_getErrorMessage(e.code));
      return false;
    } catch (e) {
      _setLoading(false);
      _setError('Failed to update email');
      return false;
    }
  }

  // Update Password
  Future<bool> updatePassword(String newPassword) async {
    try {
      _setLoading(true);
      _setError(null);

      final user = _auth.currentUser;
      if (user == null) {
        _setError('No user logged in');
        _setLoading(false);
        return false;
      }

      await user.updatePassword(newPassword);

      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      _setError(_getErrorMessage(e.code));
      return false;
    } catch (e) {
      _setLoading(false);
      _setError('Failed to update password');
      return false;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await FacebookAuth.instance.logOut();
      await _auth.signOut();
      _currentUser = null;
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _setError('Failed to sign out');
    }
  }

  // Delete Account
  Future<bool> deleteAccount() async {
    try {
      _setLoading(true);
      _setError(null);

      final user = _auth.currentUser;
      if (user == null) {
        _setError('No user logged in');
        _setLoading(false);
        return false;
      }

      await user.delete();
      _currentUser = null;

      _setLoading(false);
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      _setError(_getErrorMessage(e.code));
      return false;
    } catch (e) {
      _setLoading(false);
      _setError('Failed to delete account');
      return false;
    }
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'weak-password':
        return 'The password is too weak';
      case 'email-already-in-use':
        return 'An account already exists with this email';
      case 'invalid-email':
        return 'Invalid email address';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'user-not-found':
        return 'No account found with this email';
      case 'wrong-password':
        return 'Incorrect password';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later';
      case 'requires-recent-login':
        return 'Please sign in again to continue';
      default:
        return 'Authentication failed. Please try again';
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
