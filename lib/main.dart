import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'screens/home_screen.dart';
import 'about_page.dart';
import 'collections_page.dart';
import 'sale_page.dart';
import 'screens/signup_page.dart';
import 'screens/login_page.dart';
import 'screens/cart.dart';
import 'data/cart.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Wait for the cart notifier's single async initialization to finish.
  await cartItemsNotifier.ready;

  if (kIsWeb) {
    debugPrint('Web build: cart persistence enabled — saved cart loaded before app start.');
  }

  runApp(const UnionShopApp());
}

class UnionShopApp extends StatefulWidget {
  const UnionShopApp({super.key});

  @override
  State<UnionShopApp> createState() => _UnionShopAppState();
}

class _UnionShopAppState extends State<UnionShopApp> {
  @override
  Widget build(BuildContext context) {
    // Cart is guaranteed to be initialized (main awaited cartItemsNotifier.ready).
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/about': (context) => const AboutPage(),
        '/collections': (context) => const CollectionsPage(),
        '/sale': (context) => const SalePage(),
        '/cart': (context) => const CartPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
      },
    );
  }
}

void placeholderCallbackForButtons() {
  debugPrint('placeholder button pressed');
}

void navigateToAbout(BuildContext context) {
  Navigator.pushNamed(context, '/about');
}

void navigateToHome(BuildContext context) {
  Navigator.popUntil(context, (route) => route.isFirst);
}

