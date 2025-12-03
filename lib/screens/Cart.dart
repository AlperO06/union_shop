import 'package:flutter/material.dart';
import '../widgets/union_page_scaffold.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'name': 'Limited Edition Essential Zip Hoodie',
        'size': 'M',
        'quantity': 1,
        'price': 59.99,
      },
      {
        'name': 'Essential T-Shirt',
        'size': 'L',
        'quantity': 2,
        'price': 24.99,
      },
      {
        'name': 'Portsmouth City Postcard',
        'size': 'One Size',
        'quantity': 3,
        'price': 1.00,
      },
    ];

    final subtotal = items.fold<double>(
      0,
      (prev, item) => prev + (item['price'] as double) * (item['quantity'] as int),
    );

    return UnionPageScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Cart',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 18),

              Column(
                children: items.map((item) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // placeholder thumbnail
                          Container(
                            width: 84,
                            height: 64,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(Icons.image, color: Colors.grey, size: 32),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'] as String,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Size: ${item['size']}  •  Qty: ${item['quantity']}',
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '£${((item['price'] as double) * (item['quantity'] as int)).toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              // Summary box
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
