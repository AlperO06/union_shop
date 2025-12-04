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
