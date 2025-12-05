import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    
    // Show message if Firebase isn't configured
    if (!authService.firebaseAvailable) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.cloud_off, size: 80, color: Colors.grey[400]),
                const SizedBox(height: 24),
                const Text(
                  'Authentication Not Configured',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Firebase authentication is not set up yet. You can still browse and shop without creating an account.',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pushNamed(context, '/'),
                  icon: const Icon(Icons.shopping_bag),
                  label: const Text('Continue Shopping'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4d2963),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Setup Instructions'),
                        content: const SingleChildScrollView(
                          child: Text(
                            'To enable authentication:\n\n'
                            '1. Create a Firebase project\n'
                            '2. Enable authentication methods\n'
                            '3. Update Firebase config in lib/main.dart\n'
                            '4. See AUTHENTICATION_SETUP.md for details',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('How to enable authentication?'),
                ),
              ],
            ),
          ),
        ),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      backgroundColor: const Color(0xFFF3F4F6), // subtle gray background (slightly adjusted)
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Create Account',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Create an account to access the Union Shop',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _nameCtrl,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Full name',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return 'Please enter your name';
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'you@example.com',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return 'Please enter your email';
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim())) return 'Enter a valid email';
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _passwordCtrl,
                          obscureText: _obscurePassword,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                            ),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Please enter a password';
                            if (v.length < 6) return 'Password must be at least 6 characters';
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _confirmCtrl,
                          obscureText: _obscurePassword,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            labelText: 'Confirm password',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Please confirm your password';
                            if (v != _passwordCtrl.text) return 'Passwords do not match';
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: authService.isLoading
                                ? null
                                : () async {
                                    if (!_formKey.currentState!.validate()) return;
                                    
                                    final success = await authService.signUpWithEmail(
                                      _emailCtrl.text.trim(),
                                      _passwordCtrl.text,
                                      _nameCtrl.text.trim(),
                                    );
                                    
                                    if (success && context.mounted) {
                                      Navigator.pushReplacementNamed(context, '/');
                                    } else if (authService.errorMessage != null && context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(authService.errorMessage!),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4d2963),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              elevation: 2,
                            ),
                            child: authService.isLoading
                                ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5)
                                : const Text('Sign Up', style: TextStyle(fontSize: 16)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(child: Divider(color: Colors.grey[400])),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text('OR', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                            ),
                            Expanded(child: Divider(color: Colors.grey[400])),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 48,
                          child: OutlinedButton.icon(
                            onPressed: authService.isLoading
                                ? null
                                : () async {
                                    final success = await authService.signInWithGoogle();
                                    if (success && context.mounted) {
                                      Navigator.pushReplacementNamed(context, '/');
                                    } else if (authService.errorMessage != null && context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(authService.errorMessage!),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                            icon: Image.network(
                              'https://www.google.com/favicon.ico',
                              height: 20,
                              errorBuilder: (_, __, ___) => const Icon(Icons.g_mobiledata, size: 24),
                            ),
                            label: const Text('Continue with Google'),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey[400]!),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 48,
                          child: OutlinedButton.icon(
                            onPressed: authService.isLoading
                                ? null
                                : () async {
                                    final success = await authService.signInWithFacebook();
                                    if (success && context.mounted) {
                                      Navigator.pushReplacementNamed(context, '/');
                                    } else if (authService.errorMessage != null && context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(authService.errorMessage!),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                            icon: const Icon(Icons.facebook, color: Color(0xFF1877F2), size: 24),
                            label: const Text('Continue with Facebook'),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey[400]!),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account?'),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Sign in'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
