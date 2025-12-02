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
      body: LayoutBuilder(builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;
        final heroHeight = isMobile ? 300.0 : 420.0;
        // responsive hero typography to avoid overflow on small screens
        final heroTitleSize = isMobile ? 28.0 : 38.0;
        final heroSubtitleSize = isMobile ? 16.0 : 18.0;
        final heroTop = isMobile ? 40.0 : 72.0;

        // Build the main children list once and reuse for both mobile (ListView) and desktop (Column).
        final mainChildren = <Widget>[
          // Hero Section (height switches based on isMobile)
          SizedBox(
            height: heroHeight,
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
                  // place inner content slightly higher on mobile to avoid pushing past the bottom
                  top: heroTop,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Union Shop',
                        style: TextStyle(
                          fontSize: heroTitleSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                      SizedBox(height: isMobile ? 8 : 12),
                      Text(
                        "Official merchandise, campus essentials and local gifts — delivered to your door.",
                        style: TextStyle(
                          fontSize: heroSubtitleSize,
                          color: Colors.white70,
                          height: 1.35,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: isMobile ? 3 : 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: isMobile ? 18 : 28),
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

          // Promotions banner (unchanged)
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

          // Featured Products Section (unchanged)
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
                        // compute columns and a safer childAspectRatio
                        final crossAxisCount = isWide ? 2 : 1;
                        // on mobile reduce tile height so image + title fit without overflow
                        final childAspectRatioGrid = isWide ? 1.1 : 0.8;
                        // split into two groups
                        final essentialProducts = [
                          {
                            'title': 'Limited Edition Essential Zip Hoodies',
                            'price': '£14.99',
                            'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAVv3UIwHiQv6gWuE2l9800PQbPjISoUfKJA&s'
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

                        // Portsmouth City Collection products
                        final portsmouthProducts = [
                          {
                            'title': 'Portsmouth City Postcard',
                            'price': '£1.00',
                            'image': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_720x.jpg?v=1752232561'
                          },
                          {
                            'title': 'Portsmouth City Magnet',
                            'price': '£5.00',
                            'image': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_720x.jpg?v=1752230282'
                          },
                          {
                            'title': 'Portsmouth City Bookmark',
                            'price': '£2.00',
                            'image': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityBookmark1_720x.jpg?v=1752230004'
                          },
                          {
                            'title': 'Portsmouth Notebook',
                            'price': '£4.50',
                            'image': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityNotebook_720x.jpg?v=1757419215'
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
                              padding: EdgeInsets.zero,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                                childAspectRatio: childAspectRatioGrid,
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
                              padding: EdgeInsets.zero,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                                childAspectRatio: childAspectRatioGrid,
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
                            const SizedBox(height: 20),
                            // PORTSMOUTH CITY COLLECTION header
                            const Center(
                              child: Text(
                                'PORTSMOUTH CITY COLLECTION',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            // grid for Portsmouth City Collection (single item for now)
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                                childAspectRatio: childAspectRatioGrid,
                              ),
                              itemCount: portsmouthProducts.length,
                              itemBuilder: (context, index) {
                                final p = portsmouthProducts[index];
                                return ProductCard(
                                  title: p['title']!,
                                  price: p['price']!,
                                  imageUrl: p['image']!,
                                );
                              },
                            ),
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
        ];

        final mainColumn = Column(children: mainChildren);

        if (isMobile) {
          // mobile: use SingleChildScrollView + Column (more compatible with the page scaffold)
          final bottomPad = MediaQuery.of(context).padding.bottom + 20.0;
          return SingleChildScrollView(
            padding: EdgeInsets.only(bottom: bottomPad),
            physics: const BouncingScrollPhysics(),
            child: Column(children: mainChildren),
          );
        }

        // desktop: original behavior (no scrolling wrapper)
        return mainColumn;
      }),
    );
  }
}

// ProductCard: make image responsive so mobile uses AspectRatio (no fixed height)
class ProductCard extends StatefulWidget {
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
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _hovering = false;

  void _onEnter(PointerEvent _) => setState(() => _hovering = true);
  void _onExit(PointerEvent _) => setState(() => _hovering = false);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: _onEnter,
      onExit: _onExit,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.pushNamed(context, '/product'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // REPLACED: responsive image area (AspectRatio on mobile, fixed height on desktop)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Builder(builder: (context) {
                final screenW = MediaQuery.of(context).size.width;
                final isMobile = screenW < 700;
                if (isMobile) {
                  // constrain mobile image to a square area (width determines height)
                  return AspectRatio(
                    aspectRatio: 1.0,
                    child: Container(
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: Image.network(
                        widget.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.center,
                        errorBuilder: (context, error, stackTrace) {
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
                  );
                }

                // Desktop: keep previous fixed-height image
                return Container(
                  height: 353.32,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.image_not_supported,
                              color: Colors.grey),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    decoration:
                        _hovering ? TextDecoration.underline : TextDecoration.none,
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.price,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



