import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _hovering = false;

  void _onEnter(PointerEvent _) => setState(() => _hovering = true);
  void _onExit(PointerEvent _) => setState(() => _hovering = false);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: _onEnter,
      onExit: _onExit,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.pushNamed(context, '/product'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // REPLACED: responsive image area (AspectRatio on mobile, fixed height on desktop)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Builder(builder: (context) {
                final screenW = MediaQuery.of(context).size.width;
                final isMobile = screenW < 700;
                if (isMobile) {
                  // constrain mobile image to a square area (width determines height)
                  return AspectRatio(
                    aspectRatio: 1.0,
                    child: Container(
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: Image.network(
                        widget.product.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.center,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(Icons.image_not_supported,
                                  color: Colors.grey),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }

                // Desktop: keep previous fixed-height image
                return Container(
                  height: 353.32,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: Image.network(
                    widget.product.image,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.image_not_supported,
                              color: Colors.grey),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  widget.product.name,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    decoration:
                        _hovering ? TextDecoration.underline : TextDecoration.none,
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.product.newPrice.toString(),
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
