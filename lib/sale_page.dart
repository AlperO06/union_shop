import 'package:flutter/material.dart';
import 'widgets/union_page_scaffold.dart'; // added import

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
    return UnionPageScaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Safe area header stays the same
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

            // Grid: use shrinkWrap so it can be placed inside SingleChildScrollView,
            // and disable its own scrolling so outer SingleChildScrollView scrolls.
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.75,
                ),
                itemCount: saleProducts.length,
                itemBuilder: (context, index) {
                  final product = saleProducts[index];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // placeholder image box
                          Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Center(
                              child: Icon(Icons.image, color: Colors.grey, size: 40),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // product name
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Spacer(),
                          // old price with strikethrough
                          Text(
                            '\$${product.oldPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          // discounted price
                          Text(
                            '\$${product.newPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // footer below the sale grid
          ],
        ),
      ),
    );
  }
}

