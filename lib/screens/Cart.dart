import 'package:flutter/material.dart';
import 'package:union_shop/screens/print_shack_product_page.dart';
import '../widgets/union_page_scaffold.dart';
import '../data/cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // helper to increment quantity for item at index
  Future<void> _incrementQuantity(int index) async {
    final current = cartItems; // snapshot
    if (index < 0 || index >= current.length) return;

    final updated = List<CartItem>.from(current);
    final existing = updated[index];
    updated[index] = existing.copyWith(quantity: existing.quantity + 1);

    // replace the notifier value with a new list and persist immediately
    cartItemsNotifier.value = updated;
    await saveCartToPrefs();

    setState(() {});
  }

  // helper to decrement quantity; remove item if quantity reaches zero
  Future<void> _decrementQuantity(int index) async {
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
    await saveCartToPrefs();

    setState(() {});
  }

  // helper to remove item completely
  Future<void> _removeItem(int index) async {
    final current = cartItems;
    if (index < 0 || index >= current.length) return;

    final updated = List<CartItem>.from(current)..removeAt(index);
    cartItemsNotifier.value = updated;
    await saveCartToPrefs();

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
              // Title row with "Continue shopping" button aligned to the right
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Your Cart',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // return to the root route (home)
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(44, 32)),
                    child: const Text('Continue shopping', style: TextStyle(fontSize: 14)),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // When cart is empty show a centered message; otherwise show items + summary
              if (items.isEmpty) ...[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Your cart is empty',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey[900]),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Start shopping to add items',
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else ...[
                // Header row for the table layout
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          'Product',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Price',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Quantity',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Total',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),

                // Items as rows
                Column(
                  children: items.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    // Null-safe image URL: consider empty or whitespace-only strings as "no image".
                    final String? imageUrl = item.image.trim().isEmpty ? null : item.image;

                    // --- Changed: detect mobile and handle very narrow phones to avoid overflow ---
                    final double width = MediaQuery.of(context).size.width;
                    final bool isMobile = width < 700;
                    final bool isNarrow = width < 360; // very small phones

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: isMobile
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Top row: image + name/personalisation/remove (same as desktop left column)
                                  Row(
                                    children: [
                                      Container(
                                        width: 84,
                                        height: 64,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: imageUrl != null
                                            ? ClipRRect(
                                                borderRadius: BorderRadius.circular(6),
                                                child: Image.network(
                                                  imageUrl,
                                                  width: 84,
                                                  height: 64,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) =>
                                                      const Icon(Icons.broken_image, color: Colors.grey, size: 32),
                                                ),
                                              )
                                            : const Icon(Icons.image, color: Colors.grey, size: 32),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.name,
                                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                              softWrap: true,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 6),
                                            if ((item.personalisationLines ?? <String>[]).isNotEmpty) ...[
                                              for (var i = 0; i < (item.personalisationLines ?? <String>[]).length; i++)
                                                Text(
                                                  'Personalisation Line ${i + 1}: ${item.personalisationLines![i]}',
                                                  style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                                                  softWrap: true,
                                                ),
                                              const SizedBox(height: 6),
                                            ],
                                            Text(
                                              '${item.colour} • Size: ${item.size}',
                                              style: TextStyle(color: Colors.grey[700], fontSize: 13),
                                            ),
                                            const SizedBox(height: 6),
                                            TextButton(
                                              onPressed: () async => await _removeItem(index),
                                              style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(48, 24)),
                                              child: const Text('Remove', style: TextStyle(color: Colors.redAccent)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 12),

                                  // Bottom section: adapt layout for very narrow screens
                                  if (isNarrow) ...[
                                    // Stack price/total and put quantity control on its own line (centered)
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text('£${item.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 14)),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              '£${(item.price * item.quantity).toStringAsFixed(2)}',
                                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Center(
                                      child: ConstrainedBox(
                                        constraints: const BoxConstraints(maxWidth: 140),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Container(
                                            height: 34,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(color: Colors.grey.shade300),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  width: 34,
                                                  height: 34,
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      borderRadius: const BorderRadius.only(
                                                          topLeft: Radius.circular(6), bottomLeft: Radius.circular(6)),
                                                      onTap: () async => await _decrementQuantity(index),
                                                      child: const Center(
                                                        child: Icon(Icons.remove, size: 16, color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 44,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    '${item.quantity}',
                                                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 34,
                                                  height: 34,
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      borderRadius: const BorderRadius.only(
                                                          topRight: Radius.circular(6), bottomRight: Radius.circular(6)),
                                                      onTap: () async => await _incrementQuantity(index),
                                                      child: const Center(
                                                        child: Icon(Icons.add, size: 16, color: Colors.black54),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ] else ...[
                                    // Regular mobile bottom row but make quantity control constrained + scale down if needed
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text('£${item.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 14)),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: ConstrainedBox(
                                              constraints: const BoxConstraints(maxWidth: 140),
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Container(
                                                  height: 34,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(color: Colors.grey.shade300),
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      SizedBox(
                                                        width: 34,
                                                        height: 34,
                                                        child: Material(
                                                          color: Colors.transparent,
                                                          child: InkWell(
                                                            borderRadius: const BorderRadius.only(
                                                                topLeft: Radius.circular(6), bottomLeft: Radius.circular(6)),
                                                            onTap: () async => await _decrementQuantity(index),
                                                            child: const Center(
                                                              child: Icon(Icons.remove, size: 16, color: Colors.black54),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 44,
                                                        alignment: Alignment.center,
                                                        child: Text(
                                                          '${item.quantity}',
                                                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                                                        ),
                                                      ),
                                                     
                                        Expanded(
                                          flex: 2,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              '£${(item.price * item.quantity).toStringAsFixed(2)}',
                                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Product column: image + name + colour/size + remove link
                                  Expanded(
                                    flex: 4,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 84,
                                          height: 64,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: imageUrl != null
                                              ? ClipRRect(
                                                  borderRadius: BorderRadius.circular(6),
                                                  child: Image.network(
                                                    imageUrl,
                                                    width: 84,
                                                    height: 64,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context, error, stackTrace) =>
                                                        const Icon(Icons.broken_image, color: Colors.grey, size: 32),
                                                  ),
                                                )
                                              : const Icon(Icons.image, color: Colors.grey, size: 32),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.name,
                                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                                softWrap: true,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 6),
                                              if ((item.personalisationLines ?? <String>[]).isNotEmpty) ...[
                                                for (var i = 0; i < (item.personalisationLines ?? <String>[]).length; i++)
                                                  Text(
                                                    'Personalisation Line ${i + 1}: ${item.personalisationLines![i]}',
                                                    style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                                                    softWrap: true,
                                                  ),
                                                const SizedBox(height: 6),
                                              ],
                                              Text(
                                                '${item.colour} • Size: ${item.size}',
                                                style: TextStyle(color: Colors.grey[700], fontSize: 13),
                                              ),
                                              const SizedBox(height: 6),
                                              TextButton(
                                                onPressed: () async => await _removeItem(index),
                                                style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(48, 24)),
                                                child: const Text('Remove', style: TextStyle(color: Colors.redAccent)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Price column (unit)
                                  Expanded(
                                    flex: 2,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text('£${item.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 14)),
                                    ),
                                  ),

                                  // Quantity column (controls)
                                  Expanded(
                                    flex: 2,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        height: 34,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(color: Colors.grey.shade300),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // minus button
                                            SizedBox(
                                              width: 34,
                                              height: 34,
                                              child: Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  borderRadius: const BorderRadius.only(
                                                      topLeft: Radius.circular(6), bottomLeft: Radius.circular(6)),
                                                  onTap: () async => await _decrementQuantity(index),
                                                  child: const Center(
                                                    child: Icon(Icons.remove, size: 16, color: Colors.black54),
                                                  ),
                                                ),
                                              ),
                                            ),

                                            // quantity display
                                            Container(
                                              width: 44,
                                              alignment: Alignment.center,
                                              child: Text(
                                                '${item.quantity}',
                                                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                                              ),
                                            ),

                                            // plus button
                                            SizedBox(
                                              width: 34,
                                              height: 34,
                                              child: Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  borderRadius: const BorderRadius.only(
                                                      topRight: Radius.circular(6), bottomRight: Radius.circular(6)),
                                                  onTap: () async => await _incrementQuantity(index),
                                                  child: const Center(
                                                    child: Icon(Icons.add, size: 16, color: Colors.black54),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Total column (line total)
                                  Expanded(
                                    flex: 2,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '£${(item.price * item.quantity).toStringAsFixed(2)}',
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                      ),
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

class PrintShackCartItem {
}