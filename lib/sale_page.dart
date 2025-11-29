import 'package:flutter/material.dart';

// Model for a sale product and a hardcoded list
class SaleProduct {
  final String name;
  final double oldPrice;
  final double newPrice;
  const SaleProduct({
    required this.name,
    required this.oldPrice,
    required this.newPrice,
  });
}

const List<SaleProduct> saleProducts = [
  SaleProduct(name: 'Leather Jacket', oldPrice: 199.99, newPrice: 129.99),
  SaleProduct(name: 'Sneakers', oldPrice: 89.99, newPrice: 59.99),
  SaleProduct(name: 'Jeans', oldPrice: 79.99, newPrice: 49.99),
  SaleProduct(name: 'Wool Scarf', oldPrice: 39.99, newPrice: 19.99),
];

class SalePage extends StatelessWidget {
  const SalePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sale'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SafeArea(
            top: true,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.deepOrangeAccent],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(Icons.local_offer, color: Colors.white),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'BIG SALE – LIMITED TIME',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text('Sale page'),
            ),
          ),
        ],
      ),
    );
  }
}
