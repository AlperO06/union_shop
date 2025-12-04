import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:union_shop/screens/print_shack_product_page.dart';
import 'screens/home_screen.dart';
import 'about_page.dart';
import 'collections_page.dart';
import 'sale_page.dart';
import 'screens/signup_page.dart';
import 'screens/login_page.dart';
import 'screens/cart.dart';
import 'data/cart.dart';
import 'data/print_shack.dart'; // <-- provide samplePersonalisedHoodie


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Perform a one-time load from SharedPreferences before starting the app.
  // loadCartFromPrefs() will attach the persistence listener in its finally block.
  await loadCartFromPrefs();

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
        '/print-shack': (context) => PrintShackProductPage(product: samplePersonalisedHoodie),
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

