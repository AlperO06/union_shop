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

