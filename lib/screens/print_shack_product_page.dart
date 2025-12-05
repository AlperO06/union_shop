import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../data/print_shack.dart';
import '../widgets/union_page_scaffold.dart'; // use the app's shared scaffold (header/footer)
import '../data/cart.dart'; // integrate with the app-wide cart

// simple in-memory cart for Print Shack items
class PrintShackCartItem {
  final String productName;
  final List<String> lines;
  final int quantity;

  PrintShackCartItem({
    required this.productName,
    required this.lines,
    required this.quantity,
  });

  // Compatibility accessor so callers can check `item.personalisationLines`
  // without changing existing code that expects that property (nullable).
  List<String>? get personalisationLines => lines;

  @override
  String toString() => 'PrintShackCartItem(name: $productName, qty: $quantity, lines: $lines)';
}

// global cart list (kept in-memory for now)
final List<PrintShackCartItem> printShackCart = [];

class PrintShackProductPage extends StatefulWidget {
  final PrintShackProduct product;

  // make product optional for route compatibility; default to samplePersonalisedHoodie
  const PrintShackProductPage({Key? key, PrintShackProduct? product})
      : product = product ?? samplePersonalisedHoodie,
        super(key: key);

  @override
  State<PrintShackProductPage> createState() => _PrintShackProductPageState();
}

class _PrintShackProductPageState extends State<PrintShackProductPage> {
  int _selectedImage = 0;
  int _lines = 1;
  int _quantity = 1;
  late List<TextEditingController> _controllers;

  // update UI when controllers change to enable/disable the add button
  void _onControllersChanged() {
    // minimal work — trigger rebuild to update _canAddToCart
    setState(() {});
  }

  // whether all visible lines have non-empty text
  bool get _canAddToCart {
    for (var i = 0; i < _lines; i++) {
      if (_controllers[i].text.trim().isEmpty) return false;
    }
    return true;
  }

  double get _totalPrice => (_lines * widget.product.pricePerLine) * _quantity;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(4, (_) => TextEditingController()); // up to 4 lines by UI
    // attach listeners so button state updates as user types
    for (final c in _controllers) {
      c.addListener(_onControllersChanged);
    }
  }

  @override
  void dispose() {
    // remove listeners then dispose
    for (final c in _controllers) {
      c.removeListener(_onControllersChanged);
      c.dispose();
    }
    super.dispose();
  }

  void _setImage(int index) {
    setState(() {
      _selectedImage = index;
    });
  }

  void _changeLines(int n) {
    setState(() {
      _lines = n;
      // optionally clear controllers for newly visible fields
    });
  }

  void _changeQuantity(int delta) {
    setState(() {
      _quantity = (_quantity + delta).clamp(1, 999);
    });
  }

  void _addToCart() {
    // validate each line length
    for (var i = 0; i < _lines; i++) {
      final text = _controllers[i].text;
      if (text.length > widget.product.maxCharsPerLine) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Line ${i + 1} exceeds ${widget.product.maxCharsPerLine} characters')),
        );
        return;
      }
    }

    // Build payload (use app cart)
    final lines = List.generate(_lines, (i) => _controllers[i].text);

    // keep local print-shack cart for debugging/history
    final localItem = PrintShackCartItem(
      productName: widget.product.name,
      lines: lines,
      quantity: _quantity,
    );
    printShackCart.add(localItem);

    // Determine an image for the cart item (best-effort)
    final images = widget.product.imageUrls;
    final image = images.isNotEmpty ? images[_selectedImage.clamp(0, images.length - 1)] : '';

    // Create a stable-ish id for this printable item (ensures non-empty id)
    final idParts = [widget.product.name, ...lines.where((l) => l.isNotEmpty)];
    final idBase = idParts.join('-').replaceAll(RegExp(r"\s+"), '_');
    final id = '$idBase-${DateTime.now().millisecondsSinceEpoch}';

    // Create CartItem from the app cart model and add it to the central cart
    final cartItem = CartItem(
      id: id,
      name: widget.product.name,
      quantity: _quantity,
      price: _totalPrice,
      size: '',
      colour: '',
      image: image,
      personalisationLines: lines, // <- store the personalisation lines
    );

    try {
      addToCart(cartItem);
      debugPrint('Added to app cart: $cartItem');
    } catch (e, st) {
      debugPrint('Failed to add to app cart: $e\n$st');
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.product.imageUrls;
    final mainImage = images.isNotEmpty
        ? images[_selectedImage.clamp(0, images.length - 1)]
        : 'https://picsum.photos/seed/placeholder/1200/800';

    return UnionPageScaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 800;

          Widget leftColumn = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: mainImage,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[200],
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (c, url, e) => Container(
                      color: Colors.grey[200],
                      child: const Center(child: Icon(Icons.broken_image)),
                    ),
                  ),
                ),
              ),
              // increased spacing between image and thumbnails
              const SizedBox(height: 16),
              if (images.isNotEmpty)
                SizedBox(
                  height: 64,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, i) {
                      final url = images[i];
                      final selected = i == _selectedImage;
                      return GestureDetector(
                        onTap: () => _setImage(i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: selected ? const EdgeInsets.all(2) : const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            // purple border + elevation for selected, light grey border for non-selected
                            border: Border.all(
                              color: selected ? const Color(0xFF4d2963) : Colors.grey.shade300,
                              width: selected ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: selected
                                ? const [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))]
                                : const [],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: CachedNetworkImage(
                              imageUrl: url,
                              width: 96,
                              height: 64,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Colors.grey[200],
                                width: 96,
                                height: 64,
                                child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                              ),
                              errorWidget: (c, url, e) => Container(color: Colors.grey[200], width: 96, height: 64),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          );

          Widget rightColumn = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(widget.product.name, style: TextStyle(fontSize: isDesktop ? 24 : 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text(
                'Price per line: £${widget.product.pricePerLine.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              // helper text (smaller, light grey)
              Text(
                '£3 for one line of text! £5 for two!',
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
              const SizedBox(height: 12),

              // --- Personalisation section header ---
              const Text(
                'Personalisation',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // previous inline row -> now a column with label above the dropdown
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Number of lines:'),
                  const SizedBox(height: 8),
                  // decorated container to look like a form select
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: _lines,
                        items: List.generate(4, (i) => i + 1)
                            .map((n) => DropdownMenuItem(value: n, child: Text('$n')))
                            .toList(),
                        onChanged: (v) {
                          if (v != null) _changeLines(v);
                        },
                        isDense: true,
                        elevation: 2,
                        icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[700]),
                        style: const TextStyle(color: Colors.black, fontSize: 14),
                        dropdownColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Max chars/line: ${widget.product.maxCharsPerLine}'),
                ],
              ),
              const SizedBox(height: 12),
              Column(
                children: List.generate(_lines, (i) {
                  // Add a label above the first input only
                  if (i == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Personalisation Line 1',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _controllers[i],
                            maxLength: 10,
                            inputFormatters: [LengthLimitingTextInputFormatter(10)],
                            decoration: const InputDecoration(
                              // removed labelText / hint so field starts empty
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TextField(
                      controller: _controllers[i],
                      maxLength: 10,
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      decoration: InputDecoration(
                        labelText: 'Line ${i + 1}',
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  // left-aligned label
                  const Text('Quantity:', style: TextStyle(fontSize: 16)),

                  // center the selector by placing it inside an Expanded > Center
                  Expanded(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey[100], // light grey background
                          borderRadius: BorderRadius.circular(8), // rounded border
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 36,
                              height: 36,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                iconSize: 20,
                                onPressed: () => _changeQuantity(-1),
                                icon: const Icon(Icons.remove),
                              ),
                            ),
                            Container(
                              width: 44,
                              alignment: Alignment.center,
                              child: Text('$_quantity', style: const TextStyle(fontSize: 16)),
                            ),
                            SizedBox(
                              width: 36,
                              height: 36,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                iconSize: 20,
                                onPressed: () => _changeQuantity(1),
                                icon: const Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // right-aligned total
                  Text(
                    'Total: £${_totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // full-width rounded add-to-cart button, disabled until required fields filled
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _canAddToCart ? _addToCart : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4d2963),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                  child: const Text('ADD TO CART', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          );

          Widget content;
          if (isDesktop) {
            content = Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // left column: images
                Expanded(flex: 6, child: leftColumn),
                const SizedBox(width: 24),
                // right column: details
                Expanded(flex: 5, child: rightColumn),
              ],
            );
          } else {
            content = Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                leftColumn,
                // increased spacing between thumbnails and price (stacked/mobile)
                const SizedBox(height: 24),
                rightColumn,
              ],
            );
          }

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: content,
              ),
            ),
          );
        },
      ),
    );
  }
}
