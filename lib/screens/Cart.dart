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
