import 'package:flutter/material.dart';
import '../widgets/union_page_scaffold.dart';
import '../data/cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // helper to increment quantity for item at index
  void _incrementQuantity(int index) {
    final current = cartItems; // snapshot
    if (index < 0 || index >= current.length) return;

    final updated = List<CartItem>.from(current);
    final existing = updated[index];
    updated[index] = existing.copyWith(quantity: existing.quantity + 1);

    // replace the notifier value with a new list and rebuild
    cartItemsNotifier.value = updated;
    setState(() {});
  }

  // helper to decrement quantity; remove item if quantity reaches zero
  void _decrementQuantity(int index) {
    final current = cartItems;
    if (index < 0 || index >= current.length) return;

    final updated = List<CartItem>.from(current);
    final existing = updated[index];
    if (existing.quantity > 1) {
      updated[index] = existing.copyWith(quantity: existing.quantity - 1);
    } else {
      updated.removeAt(index);
    }

    cartItemsNotifier.value = updated;
    setState(() {});
  }

  // helper to remove item completely
  void _removeItem(int index) {
    final current = cartItems;
    if (index < 0 || index >= current.length) return;

    final updated = List<CartItem>.from(current)..removeAt(index);
    cartItemsNotifier.value = updated;
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Item removed from cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Use the app's cart system
    final List<CartItem> items = cartItems;

    final subtotal = items.fold<double>(
      0,
      (prev, item) => prev + item.price * item.quantity,
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

              // When cart is empty show a centered message; otherwise show items + summary
              if (items.isEmpty) ...[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,

                                  Text(
                                    item.name,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6),
                                  // Replace static size/qty text with interactive controls
                                  Wrap(
                                    spacing: 12,
                                    runSpacing: 8,
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [
                                      Text('Size: ${item.size}', style: TextStyle(color: Colors.grey[700])),
                                      // quantity controls
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey.shade300),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              padding: const EdgeInsets.symmetric(horizontal: 6),
                                              constraints: const BoxConstraints(),
                                              icon: const Icon(Icons.remove, size: 18),
                                              onPressed: () => _decrementQuantity(index),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.w600)),
                                            ),
                                            IconButton(
                                              padding: const EdgeInsets.symmetric(horizontal: 6),
                                              constraints: const BoxConstraints(),
                                              icon: const Icon(Icons.add, size: 18),
                                              onPressed: () => _incrementQuantity(index),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // remove button
                                      IconButton(
                                        icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                                        onPressed: () => _removeItem(index),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  // Move price below the name/controls so it doesn't overflow on small screens
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '£${(item.price * item.quantity).toStringAsFixed(2)}',
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),

                // Summary box (shown only when items exist)
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Subtotal',
                              style: TextStyle(fontSize: 16, color: Colors.black87),
                            ),
                            const Spacer(),
                            Text(
                              '£${subtotal.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Checkout pressed (UI demo only)')),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4d2963),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text('Proceed to checkout', style: TextStyle(fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ],
          ),
        ),
      ),
    );
  }
}