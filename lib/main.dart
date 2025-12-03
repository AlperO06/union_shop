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

void main() {
  WidgetsFlutterBinding.ensureInitialized();


  enableCartPersistence();

  if (kIsWeb) {
    debugPrint('Web build: cart persistence enabled — saved cart will be loaded on app init.');
  }

  runApp(const UnionShopApp());
}

class UnionShopApp extends StatefulWidget {
  const UnionShopApp({super.key});

  @override
  State<UnionShopApp> createState() => _UnionShopAppState();
}

class _UnionShopAppState extends State<UnionShopApp> {
  late final Future<void> _cartLoadFuture;

  @override
  void initState() {
    super.initState();
    // start loading prefs; loadCartFromPrefs() attaches persistence listener in its finally block.
    _cartLoadFuture = loadCartFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _cartLoadFuture,
      builder: (context, snapshot) {
        // While loading, show a minimal app + loading screen so the app is responsive immediately.
        if (snapshot.connectionState != ConnectionState.done) {
          return MaterialApp(
            title: 'Union Shop',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
            ),
            home: const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        // Once loaded, show the full app with routes.
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

