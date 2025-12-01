import 'package:flutter/material.dart';
import 'widgets/union_page_scaffold.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String _selectedSize = 'Medium';
  final List<String> _sizes = ['Small', 'Medium', 'Large'];

  // image + thumbnails state
  String _mainImageUrl =
      'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282';
  final List<String> _thumbnails = [
    'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
    'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet2_1024x1024@2x.jpg?v=1752230282',
    'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet3_1024x1024@2x.jpg?v=1752230282',
    'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
  ];
  int _selectedThumbnail = 0;

  // Quantity state (default 1)
  int _selectedQuantity = 1;
  final List<int> _quantities = [1, 2, 3, 4, 5];

  // Colour state
  String _selectedColor = 'Black';
  final List<String> _colors = ['Black', 'White', 'Grey'];

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void placeholderCallbackForButtons() {
    // placeholder for non-implemented actions
  }

  // Main image + thumbnails
  Widget _buildMainImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 4 / 3,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                _mainImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image_not_supported, size: 64, color: Colors.grey),
                          SizedBox(height: 8),
                          Text('Image unavailable', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(_thumbnails.length, (index) {
              final thumb = _thumbnails[index];
              final isActive = index == _selectedThumbnail;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedThumbnail = index;
                    _mainImageUrl = thumb;
                  });
                },
                child: Container(
                  width: 64,
                  height: 64,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: isActive ? const Color(0xFF4d2963) : Colors.grey.shade300,
                      width: isActive ? 2 : 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      thumb,
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[300]),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  // Product info: title, prices, selectors, add to cart, description
  Widget _buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Placeholder Product Name',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 16),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '£20.00',
              style: TextStyle(fontSize: 18, color: Colors.grey, decoration: TextDecoration.lineThrough),
            ),
            SizedBox(width: 12),
            Text(
              '£15.00',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF4d2963)),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const Text('Colour:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
              ),
              child: DropdownButton<String>(
                value: _selectedColor,
                underline: const SizedBox(),
                items: _colors
                    .map((c) => DropdownMenuItem<String>(value: c, child: Text(c)))
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedColor = val);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Text('Size:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
              ),
              child: DropdownButton<String>(
                value: _selectedSize,
                underline: const SizedBox(),
                items: _sizes.map((s) => DropdownMenuItem<String>(value: s, child: Text(s))).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedSize = val);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Text('Quantity:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
              ),
              child: DropdownButton<int>(
                value: _selectedQuantity,
                underline: const SizedBox(),
                items: _quantities
                    .map((q) => DropdownMenuItem<int>(value: q, child: Text(q.toString())))
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedQuantity = val);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: placeholderCallbackForButtons,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4d2963),
              foregroundColor: Colors.white,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
            child: const Text('Add to cart'),
          ),
        ),
        const SizedBox(height: 20),
        Divider(color: Colors.grey.shade200, thickness: 1),
        const SizedBox(height: 20),
        const Text(
          'Description',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'This is a placeholder description for the product. Students should replace this with real product information and implement proper data management.',
          style: TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
        ),
      ],
    );
  }

  // Narrow stacked layout content
  Widget _buildProductDetailsColumn() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMainImage(),
          const SizedBox(height: 24),
          _buildProductInfo(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return UnionPageScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final bool isWideScreen = constraints.maxWidth >= 800;
                if (isWideScreen) {
                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1100),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                              child: _buildMainImage(),
                            ),
                          ),
                          const SizedBox(width: 40),
                          Expanded(
                            flex: 3,
                            child: Container(
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                              child: _buildProductInfo(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return _buildProductDetailsColumn();
              },
            ),
          ],
        ),
      ),
    );
  }
}
          ),
        ),
        // subtle divider for visual separation
        const SizedBox(height: 20),
        Divider(color: Colors.grey.shade200, thickness: 1),
        const SizedBox(height: 20),
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'This is a placeholder description for the product. Students should replace this with real product information and implement proper data management.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // Product details for narrow screens: image first, then product info
  Widget _buildProductDetailsColumn() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image (narrow layout uses the same helper)
          _buildMainImage(),

          const SizedBox(height: 24),
          // Product info (title/price/size/description)
          _buildProductInfo(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                // detect screen width for future responsive layout
                final bool isWideScreen = constraints.maxWidth > 800;

                if (isWideScreen) {
                  // wide layout: constrained & centered content (keeps the existing two-column Row)
                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1100),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              color: Colors.white,
                              // slightly more horizontal padding for breathing room
                              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                              child: _buildMainImage(),
                            ),
                          ),
                          // increased gap between columns for clearer separation
                          const SizedBox(width: 40),
                          Expanded(
                            flex: 3,
                            child: Container(
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                              child: _buildProductInfo(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return Column(
                  children: [
                    // --- REPLACED: legacy header (PLACEHOLDER HEADER TEXT) ---
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // thin top purple SALE banner
                        Container(
                          height: 28,
                          width: double.infinity,
                          color: const Color(0xFF4d2963), // dark purple
                          alignment: Alignment.center,
                          child: const Text(
                            'BIG SALE! OVER 20% OFF ESSENTIALS',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ),

                        // AppBar-like row (logo, nav buttons, action icons)
                        Material(
                          color: Colors.white,
                          elevation: 0,
                          child: SizedBox(
                            height: kToolbarHeight,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: GestureDetector(
                                    onTap: () => Navigator.popUntil(context, (route) => route.isFirst),
                                    child: Image.network(
                                      'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                                      height: 28,
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey[300],
                                          width: 28,
                                          height: 28,
                                          child: const Center(
                                            child: Icon(Icons.image_not_supported, color: Colors.grey),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // navigation buttons
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextButton(
                                        onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.black,
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          textStyle: const TextStyle(fontSize: 16),
                                        ),
                                        child: const Text('Home'),
                                      ),
                                      const SizedBox(width: 8),
                                      TextButton(
                                        onPressed: () => Navigator.pushNamed(context, '/collections'),
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.black,
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          textStyle: const TextStyle(fontSize: 16),
                                        ),
                                        child: const Text('Shop'),
                                      ),
                                      const SizedBox(width: 8),
                                      TextButton(
                                        onPressed: () => Navigator.pushNamed(context, '/sale'),
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.black,
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                        ),
                                        child: const Text('SALE'),
                                      ),
                                      const SizedBox(width: 8),
                                      TextButton(
                                        onPressed: () => Navigator.pushNamed(context, '/about'),
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.black,
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          textStyle: const TextStyle(fontSize: 16),
                                        ),
                                        child: const Text('About'),
                                      ),
                                    ],
                                  ),
                                ),
                                // action icons
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.search, size: 18, color: Colors.grey),
                                      padding: const EdgeInsets.all(8),
                                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                      onPressed: placeholderCallbackForButtons,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.person_outline, size: 18, color: Colors.grey),
                                      padding: const EdgeInsets.all(8),
                                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                      onPressed: placeholderCallbackForButtons,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.shopping_bag_outlined, size: 18, color: Colors.grey),
                                      padding: const EdgeInsets.all(8),
                                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                      onPressed: placeholderCallbackForButtons,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.menu, size: 18, color: Colors.grey),
                                      padding: const EdgeInsets.all(8),
                                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                      onPressed: placeholderCallbackForButtons,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        // FREE UK DELIVERY / promotions banner (uses same layout as HomeScreen promotions)
                        Container(
                          width: double.infinity,
                          color: const Color(0xFFF6F0FB),
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
                                        'FREE UK DELIVERY on orders over £30',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Available for standard UK shipping — exclusions may apply.',
                                        style: TextStyle(fontSize: 13, color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                ElevatedButton(
                                  onPressed: () => Navigator.pushNamed(context, '/collections'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF4d2963),
                                    foregroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                  ),
                                  child: const Text('SHOP NOW'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // --- END REPLACED HEADER ---

                    // Product details (narrow: column layout — image first, then details)
                    _buildProductDetailsColumn(),

                    // Footer: same layout as HomeScreen (branding + Help / Company / Legal columns)
                    Container(
                      width: double.infinity,
                      color: Colors.grey[50],
                      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1100),
                        child: LayoutBuilder(builder: (context, inner) {
                          final isNarrow = inner.maxWidth < 800;
                          const headingStyle = TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          );
                          const linkStyle = TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                            height: 1.3,
                          );

                          const branding = Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Union Shop',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Official merchandise, campus essentials and local gifts — supporting local makers and student ventures.',
                                style: TextStyle(fontSize: 13, color: Colors.black54),
                              ),
                            ],
                          );

                          Widget linkColumn(String title, List<String> links) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(title, style: headingStyle),
                                const SizedBox(height: 8),
                                for (var i = 0; i < links.length; i++) ...[
                                  TextButton(
                                    onPressed: () async {
                                      if (links[i] == 'Shipping') {
                                        final uri = Uri.parse('https://shop.upsu.net');
                                        if (await canLaunchUrl(uri)) {
                                          await launchUrl(uri, mode: LaunchMode.externalApplication);
                                        } else {
                                          debugPrint('Could not launch $uri');
                                        }
                                      } else {
                                        // preserve existing behavior for other links
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      alignment: Alignment.centerLeft,
                                    ),
                                    child: Text(links[i], style: linkStyle),
                                  ),
                                  if (i != links.length - 1) const SizedBox(height: 6),
                                ],
                              ],
                            );
                          }

                          if (isNarrow) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                branding,
                                const SizedBox(height: 16),
                                const Divider(),
                                const SizedBox(height: 12),
                                Wrap(
                                  runSpacing: 12,
                                  children: [
                                    SizedBox(width: inner.maxWidth, child: linkColumn('Help', ['Shipping', 'Returns', 'Contact Us'])),
                                    SizedBox(width: inner.maxWidth, child: linkColumn('Company', ['About Us', 'Careers', 'Press'])),
                                    SizedBox(width: inner.maxWidth, child: linkColumn('Legal', ['Terms & Conditions', 'Privacy Policy', 'Cookies'])),
                                  ],
                                ),
                                const SizedBox(height: 18),
                                Center(
                                  child: Text(
                                    '© 2025 Union Shop — All rights reserved',
                                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                                  ),
                                ),
                              ],
                            );
                          }

                          // Wide layout
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Expanded(flex: 2, child: branding),
                                  const SizedBox(width: 32),
                                  Expanded(
                                    flex: 4,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(child: linkColumn('Help', ['Shipping', 'Returns', 'Contact Us'])),
                                        const SizedBox(width: 24),
                                        Expanded(child: linkColumn('Company', ['About Us', 'Careers', 'Press'])),
                                        const SizedBox(width: 24),
                                        Expanded(child: linkColumn('Legal', ['Terms & Conditions', 'Privacy Policy', 'Cookies'])),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              const Divider(),
                              const SizedBox(height: 12),
                              Center(
                                child: Text(
                                  '© 2025 Union Shop — All rights reserved',
                                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
