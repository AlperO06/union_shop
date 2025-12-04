import 'package:flutter/material.dart';
import '../data/print_shack.dart';

class PrintShackProductPage extends StatefulWidget {
  final PrintShackProduct product;

  const PrintShackProductPage({Key? key, required this.product}) : super(key: key);

  @override
  State<PrintShackProductPage> createState() => _PrintShackProductPageState();
}

class _PrintShackProductPageState extends State<PrintShackProductPage> {
  int _selectedImage = 0;
  int _lines = 1;
  int _quantity = 1;
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(4, (_) => TextEditingController()); // up to 4 lines by UI
  }

  @override
  void dispose() {
    for (final c in _controllers) {
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

    // Build payload (replace with real cart logic)
    final lines = List.generate(_lines, (i) => _controllers[i].text);
    debugPrint('Add to cart: ${widget.product.name}, qty=$_quantity, lines=$lines');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to cart')),
    );

    // TODO: integrate with app cart/state management
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.product.imageUrls;
    final mainImage = images.isNotEmpty
        ? images[_selectedImage.clamp(0, images.length - 1)]
        : 'https://picsum.photos/seed/placeholder/1200/800';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        backgroundColor: const Color(0xFF4d2963),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Main image
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  mainImage,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(
                    color: Colors.grey[200],
                    child: const Center(child: Icon(Icons.broken_image)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Thumbnails
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
                        padding: selected ? const EdgeInsets.all(2) : EdgeInsets.zero,
                        decoration: BoxDecoration(
                          border: selected ? Border.all(color: const Color(0xFF4d2963), width: 2) : null,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(url, width: 96, height: 64, fit: BoxFit.cover,
                              errorBuilder: (c, e, s) => Container(color: Colors.grey[200], width: 96, height: 64)),
                        ),
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 16),
