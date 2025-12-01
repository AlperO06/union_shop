import 'package:flutter/material.dart';
import 'product_page.dart';
import 'about_page.dart';
import 'collections_page.dart';
import 'sale_page.dart';
import 'widgets/union_page_scaffold.dart';

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
    return UnionPageScaffold(
      body: Column(
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
                    onPressed: () => Navigator.pushNamed(context, '/sale'),
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
                    // replace the LayoutBuilder block with two separate groups
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide = constraints.maxWidth > 600;
                        // split into two groups
                        final essentialProducts = [
                          {
                            'title': 'Limited Edition Essential Zip Hoodies',
                            'price': '£45.00',
                            'image': 'https://picsum.photos/id/1005/800/600'
                          },
                          {
                            'title': 'Essential T-Shirt',
                            'price': '£15.00',
                            'image': 'https://picsum.photos/id/1001/800/600'
                          },
                        ];

                        final signatureProducts = [
                          {
                            'title': 'Signature Hoodie',
                            'price': '£60.00',
                            'image': 'https://picsum.photos/id/1003/800/600'
                          },
                          {
                            'title': 'Signature T-Shirt',
                            'price': '£25.00',
                            'image': 'https://picsum.photos/id/1002/800/600'
                          },
                        ];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ESSENTIAL RANGE header — increased top spacing and larger gap to grid
                            const SizedBox(height: 16),
                            const Center(
                              child: Text(
                                'ESSENTIAL RANGE - OVER 20% OFF!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: isWide ? 2 : 1,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                                childAspectRatio: 1.1,
                              ),
                              itemCount: essentialProducts.length,
                              itemBuilder: (context, index) {
                                final p = essentialProducts[index];
                                return ProductCard(
                                  title: p['title']!,
                                  price: p['price']!,
                                  imageUrl: p['image']!,
                                );
                              },
                            ),
                            // spacing and subtle divider between sections
                            const SizedBox(height: 24),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Divider(color: Colors.grey, thickness: 0.5),
                            ),
                            const SizedBox(height: 12),
                            // SIGNATURE RANGE header — centered, uppercase, larger, spaced
                            const Center(
                              child: Text(
                                'SIGNATURE RANGE',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: isWide ? 2 : 1,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                                childAspectRatio: 1.1,
                              ),
                              itemCount: signatureProducts.length,
                              itemBuilder: (context, index) {
                                final p = signatureProducts[index];
                                return ProductCard(
                                  title: p['title']!,
                                  price: p['price']!,
                                  imageUrl: p['image']!,
                                );
                              },
                            ),
                            // final spacing to make the section readable and separated from following content
                            const SizedBox(height: 32),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pushNamed(context, '/product');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // fixed-height image area so all product images share the same height,
          // center-cropped using BoxFit.cover to preserve aspect ratio
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 180, // consistent height for all product images
              width: double.infinity,
              color: Colors.grey[200],
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                alignment: Alignment.center,
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



