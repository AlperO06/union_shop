import 'package:flutter/material.dart';
import 'widgets/union_page_scaffold.dart'; // use scaffold that provides header/footer
import 'models/product.dart';
import 'data/cart.dart';

class ProductPage extends StatefulWidget {
  final Product product; // added product property

  const ProductPage({Key? key, required this.product}) : super(key: key); // updated ctor

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late String _selectedSize;
  List<String> _sizes = [];

  // image + thumbnails state
  String _mainImageUrl = '';
  List<String> _thumbnails = [];
  int _selectedThumbnail = 0;

  // Quantity state (default 1)
  int _selectedQuantity = 1;
  final List<int> _quantities = [1, 2, 3, 4, 5];

  // Colour state
  late String _selectedColor;
  List<String> _colors = [];

  @override
  void initState() {
    super.initState();
    // initialize images/thumbnails from product (fallback to a single placeholder image)
    _thumbnails = (widget.product.images ?? []).isNotEmpty
        ? widget.product.images!
        : [
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282'
          ];
    _mainImageUrl = _thumbnails[_selectedThumbnail];

    // sizes & colors from product (fallbacks)
    _sizes = (widget.product.sizes ?? []).isNotEmpty ? widget.product.sizes! : ['Medium'];
    _selectedSize = _sizes.isNotEmpty ? _sizes[0] : 'Medium';

    _colors = (widget.product.colors ?? []).isNotEmpty ? widget.product.colors! : ['Black'];
    _selectedColor = _colors.isNotEmpty ? _colors[0] : 'Black';
  }

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  // add helper to choose between network and asset images
  Widget _buildResponsiveImage(
    String src, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    if (src.startsWith('http')) {
      return Image.network(
        src,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) =>
            Container(color: Colors.grey[300]),
      );
    }
    return Image.asset(
      src,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) =>
          Container(color: Colors.grey[300]),
    );
  }

  // Reusable main image widget so it can be placed in wide/narrow layouts
  Widget _buildMainImage() {
    // Use AspectRatio (4/3) so the image scales responsively and fills the left column.
    // Thumbnails are small squares underneath; selected thumbnail shows a purple border.
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
              child: _buildResponsiveImage(
                _mainImageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),
        // Thumbnails row (selectable)
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
                    child: _buildResponsiveImage(
                      thumb,
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
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

  // Product info column (title, price, size selector, description)
  Widget _buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.product.name,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        // increased gap for better separation from controls
        const SizedBox(height: 16),
        // old price + current price (same line)
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '£${widget.product.oldPrice}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '£${widget.product.newPrice}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4d2963),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Colour selector (new) — placed above Size
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Colour:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
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
                    .map((c) => DropdownMenuItem<String>(
                          value: c,
                          child: Text(c),
                        ))
                    .toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _selectedColor = val;
                    });
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Size:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
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
                items: _sizes
                    .map((s) => DropdownMenuItem<String>(
                          value: s,
                          child: Text(s),
                        ))
                    .toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _selectedSize = val;
                    });
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Quantity selector (new, default 1)
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Quantity:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
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
                    .map((q) => DropdownMenuItem<int>(
                          value: q,
                          child: Text(q.toString()),
                        ))
                    .toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _selectedQuantity = val;
                    });
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Add to cart — full width, branded
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              final image = _mainImageUrl.isNotEmpty
                  ? _mainImageUrl
                  : (widget.product.images != null && widget.product.images!.isNotEmpty
                      ? widget.product.images!.first
                      : '');

              final item = CartItem(
                id: widget.product.id.toString(),
                name: widget.product.name,
                price: widget.product.newPrice,
                size: _selectedSize,
                colour: _selectedColor,
                quantity: _selectedQuantity,
                image: image,
              );

              addToCart(item);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${item.name} added to cart')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4d2963),
              foregroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: const Text('Add to cart'),
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
        Text(
          widget.product.description,
          style: const TextStyle(
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
    return UnionPageScaffold(
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // detect screen width for responsive layout
            final bool isWideScreen = constraints.maxWidth > 800;

            Widget productContent;
            if (isWideScreen) {
              // wide layout: constrained & centered content (keeps the existing two-column Row)
              productContent = Center(
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
            } else {
              // Narrow layout: only include product details (header/footer provided by UnionPageScaffold)
              productContent = _buildProductDetailsColumn();
            }

            // SingleChildScrollView is the outer scroll; return non-flex container here.
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                productContent,
              ],
            );
          },
        ),
      ),
    );
  }
}