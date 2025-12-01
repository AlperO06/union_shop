import 'package:flutter/material.dart';
import 'package:union_shop/product_page.dart';
import 'about_page.dart';
import 'collections_page.dart';
import 'sale_page.dart';
import 'widgets/union_page_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';
import 'bottom_union_footer.dart';

void main() {
  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/product': (context) => const ProductPage(),
        '/about': (context) => const AboutPage(),
        '/collections': (context) => const CollectionsPage(),
        '/sale': (context) => const SalePage(),
      },
    );
  }
}

// helper navigation / placeholder functions
void placeholderCallbackForButtons() {
  debugPrint('placeholder button pressed');
}

void navigateToAbout(BuildContext context) {
  Navigator.pushNamed(context, '/about');
}

void navigateToHome(BuildContext context) {
  Navigator.popUntil(context, (route) => route.isFirst);
}

// HomeScreen extracted from the original inline Scaffold
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Footer link handler reused inside linkColumn below
    Future<void> _handleLinkPress(String label) async {
      if (label == 'Shipping') {
        final uri = Uri.parse('https://shop.upsu.net');
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          debugPrint('Could not launch $uri');
        }
      } else {
        placeholderCallbackForButtons();
      }
    }

    return UnionPageScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section (updated)
            SizedBox(
              height: 420,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        // fixed overlay: use withOpacity
                        decoration: BoxDecoration(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.58),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 24,
                    right: 24,
                    top: 72,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Union Shop',
                          style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Official merchandise, campus essentials and local gifts — delivered to your door.",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 28),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: placeholderCallbackForButtons,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4d2963),
                                foregroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 14),
                              ),
                              child: const Text(
                                'SHOP NOW',
                                style:
                                    TextStyle(fontSize: 14, letterSpacing: 1),
                              ),
                            ),
                            const SizedBox(width: 12),
                            OutlinedButton(
                              onPressed: placeholderCallbackForButtons,
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.white70),
                                  foregroundColor: Colors.white),
                              child: const Text('LEARN MORE'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Promotions banner (new)
            Container(
              width: double.infinity,
              color: const Color(0xFFF6F0FB),
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Special Promotion — 20% off selected items',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Limited time only. Use code: UNION20 at checkout.',
                            style: TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: placeholderCallbackForButtons,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4d2963),
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Text('VIEW OFFERS'),
                    ),
                  ],
                ),
              ),
            ),

            // Featured Products Section (updated and responsive)
            Container(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Featured Products',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 18),
                      LayoutBuilder(builder: (context, constraints) {
                        final isWide = constraints.maxWidth > 600;
                        final products = [
                          {
                            'title': 'Portsmouth Magnet',
                            'price': '£6.00',
                            'image':
                                'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282'
                          },
                          {
                            'title': 'Union Hoodie',
                            'price': '£30.00',
                            'image':
                                'https://shop.upsu.net/cdn/shop/files/upsu_hoodie.jpg?v=1752230000'
                          },
                          {
                            'title': 'Campus Mug',
                            'price': '£8.50',
                            'image':
                                'https://shop.upsu.net/cdn/shop/files/campus_mug.jpg?v=1752230001'
                          },
                          {
                            'title': 'Sticker Pack',
                            'price': '£3.00',
                            'image':
                                'https://shop.upsu.net/cdn/shop/files/sticker_pack.jpg?v=1752230002'
                          },
                        ];
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isWide ? 2 : 1,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio: 1.1,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final p = products[index];
                            return Card(
                              elevation: 1,
                              clipBehavior: Clip.hardEdge,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              child: InkWell(
                                onTap: () => Navigator.pushNamed(context, '/product'),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 1.6,
                                      child: Image.network(
                                        p['image']!,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.grey[300],
                                            child: const Center(
                                              child: Icon(Icons.image_not_supported,
                                                  color: Colors.grey),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            p['title']!,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            p['price']!,
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }),
                      const SizedBox(height: 12),
                      const Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: placeholderCallbackForButtons,
                          child: Text('View all products'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Footer
            const UnionFooter(),
          ],
        ),
      ),
    );
  }
}

// ProductCard (cleaned, kept single)
class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.6,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.black),
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              Text(
                price,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


