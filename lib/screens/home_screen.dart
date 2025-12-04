import 'package:flutter/material.dart';
import 'package:union_shop/widgets/hero_slider.dart';
import '../widgets/union_page_scaffold.dart';
import '../data/products.dart';
import '../product_page.dart';

void placeholderCallbackForButtons() {
  debugPrint('placeholder button pressed');
}

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

        // helper to map common button labels to routes
        VoidCallback makeSlideCallback(String label) {
          final lower = label.toLowerCase();
          if (lower.contains('shop')) {
            return () => Navigator.pushNamed(context, '/collections');
          }
          if (lower.contains('learn')) {
            return () => Navigator.pushNamed(context, '/about');
          }
          return placeholderCallbackForButtons;
        }

        // Build the main children list once and reuse for both mobile (ListView) and desktop (Column).
        final mainChildren = <Widget>[
          // Replace the previous static hero banner with the shared HeroSlider widget
          HeroSlider(
            height: heroHeight,
            isMobile: isMobile,
            heroTitleSize: heroTitleSize,
            heroSubtitleSize: heroSubtitleSize,
            heroTop: heroTop,
            slides: [
              HeroSlide(
                imageUrl:
                    'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?auto=format&fit=crop&w=1200&q=80',
                title: 'Union Essentials Sale',
                subtitle:
                    'Everything you need – up to 50% off selected essentials',
                primaryLabel: 'SHOP ESSENTIALS',
                onPrimary: makeSlideCallback('SHOP ESSENTIALS'),
              ),

              // NEW SLIDE: The Print Shack
              const HeroSlide(
                imageUrl:
                    'https://images.unsplash.com/photo-1580711749644-0a9f4d9e0f8e?auto=format&fit=crop&w=1200&q=80',
                title: 'The Print Shack',
                subtitle:
                    'Let’s create something uniquely you with our personalisation service — From £3 for one line of text!',
                primaryLabel: 'LEARN MORE',
                // no onPrimary provided — leave callback nil or hook as needed
              ),

              // 2) Essential hoodie — navigate to the hoodie product page
              HeroSlide(
                imageUrl: 'https://picsum.photos/id/1003/1200/800',
                title: 'Essential Hoodie',
                subtitle: 'Limited Edition Essential Zip Hoodie',
                primaryLabel: 'VIEW HOODIE',
                onPrimary: () {
                  final product = products.firstWhere(
                    (p) => p.name.toLowerCase().contains('hoodie') || p.name.toLowerCase().contains('zip hoodie'),
                    orElse: () => products.first,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ProductPage(product: product)),
                  );
                },
              ),
              HeroSlide(
                imageUrl:
                    'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=1200&q=80',
                title: 'Student Discounts',
                subtitle:
                    'Verified students get exclusive savings across the store',
                primaryLabel: 'VERIFY & SAVE',
                onPrimary: makeSlideCallback('VERIFY & SAVE'),
              ),
              HeroSlide(
                imageUrl:
                    'https://images.unsplash.com/photo-1520975912602-0efb0f4e0f4f?auto=format&fit=crop&w=1200&q=80',
                title: 'New Merchandise Drop',
                subtitle: 'Limited-run designs — shop the latest arrivals',
                primaryLabel: 'SEE NEW MERCH',
                onPrimary: makeSlideCallback('SEE NEW MERCH'),
              ),
            ],
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
                            'title': 'Limited Edition Essential Zip Hoodie',
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
                                final product = products.firstWhere(
                                  (prod) => prod.name == p['title'],
                                  orElse: () => products.first,
                                );

                                return ProductCard(product: product);
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
                                final product = products.firstWhere(
                                  (prod) => prod.name == p['title'],
                                  orElse: () => products.first,
                                );

                                return ProductCard(product: product);
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
                                final product = products.firstWhere(
                                  (prod) => prod.name == p['title'],
                                  orElse: () => products.first,
                                );

                                return ProductCard(product: product);
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

// Inserted ProductCard widget copied from main.dart below HomeScreen class
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductPage(product: product),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image area
            AspectRatio(
              aspectRatio: 4 / 3,
              child: product.image.startsWith('http')
                  ? Image.network(
                      product.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[200],
                        child: const Center(child: Icon(Icons.broken_image)),
                      ),
                    )
                  : Image.asset(
                      product.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[200],
                        child: const Center(child: Icon(Icons.broken_image)),
                      ),
                    ),
            ),
            // Textual info
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name, // changed from product.title
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      // OLD PRICE (strike-through)
                      Text(
                        '£${product.oldPrice}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 6),

                      // NEW PRICE (highlighted)
                      Text(
                        '£${product.newPrice}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF4d2963),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

