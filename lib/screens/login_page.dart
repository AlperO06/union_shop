import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscure = true;
  bool _loading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    // placeholder for real auth logic
    Future.delayed(const Duration(seconds: 1), () {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login pressed (placeholder)')),
      );
    });
  }

  void _onCreateAccount() {
    // placeholder for navigation to sign-up
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Create account pressed (placeholder)')),
    );
  }

