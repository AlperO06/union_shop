import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/screens/print_shack_product_page.dart';
import 'services/auth_service.dart';
import 'screens/home_screen.dart';
import 'about_page.dart';
import 'screens/about_print.dart';
import 'screens/collections_page.dart';
import 'screens/collections_landing_page.dart';
import 'screens/sale_page.dart';
import 'screens/search_page.dart';
import 'screens/signup_page.dart';
import 'screens/login_page.dart';
import 'screens/cart.dart';
import 'screens/account_dashboard.dart';
import 'screens/profile_settings.dart';
import 'screens/order_history.dart';
import 'data/cart.dart';
import 'data/print_shack.dart' show samplePersonalisedHoodie;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Skip Firebase initialization for now - uncomment when ready to use authentication
  // To enable authentication, follow the guide in AUTHENTICATION_SETUP.md
  
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDZ-NF7ivJIg7DxI7bsfik98o4-OwB7fC0",
      authDomain: "programming-cw.firebaseapp.com",
      projectId: "programming-cw",
      storageBucket: "programming-cw.firebasestorage.app",
      messagingSenderId: "136654089300",
      appId: "1:136654089300:web:ee1928e1fd56564ee411c1",
      measurementId: "G-9DE6DYCP69",
    ),
  );
  
  if (kDebugMode) {
    debugPrint('Firebase initialized successfully');
  }
  
  if (kDebugMode) {
    debugPrint('Firebase initialized successfully');
  }
  
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
    return ChangeNotifierProvider(
      create: (_) => AuthService(),
      child: MaterialApp(
        title: 'Union Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
        ),
        initialRoute: '/',
        routes: {
        '/': (context) => const HomeScreen(),
        '/print-shack': (context) => const PrintShackProductPage(product: samplePersonalisedHoodie),
        '/about': (context) => const AboutPage(),
        '/about-print-shack': (context) => const AboutPrintShackPage(),
        '/collections': (context) => const CollectionsLandingPage(),
        '/collections/clothing': (context) => const CollectionsPage(),
        '/sale': (context) => const SalePage(),
        '/search': (context) => const SearchPage(),
        '/cart': (context) => const CartPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/account': (context) => const AccountDashboard(),
        '/profile-settings': (context) => const ProfileSettingsPage(),
        '/order-history': (context) => const OrderHistoryPage(),
      },
      ),
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

