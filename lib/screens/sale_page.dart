import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../widgets/union_page_scaffold.dart';
import '../models/product.dart';
import '../data/products.dart';
import '../product_page.dart';

class SalePage extends StatefulWidget {
  const SalePage({Key? key}) : super(key: key);

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  List<Product> _saleProducts = [];
  String _filterBy = 'All products';
  String _sortBy = 'Best selling';

  final List<String> _filterOptions = ['All products'];
  final List<String> _sortOptions = [
    'Best selling',
    'Name (A-Z)',
    'Name (Z-A)',
    'Price (Low-High)',
    'Price (High-Low)',
  ];

  @override
  void initState() {
    super.initState();
    // Load sale products (IDs 18-26)
    _saleProducts = products.where((p) => p.id >= 18 && p.id <= 26).toList();
  }

  List<Product> _getSortedProducts() {
    final sorted = _saleProducts.toList();
    switch (_sortBy) {
      case 'Name (A-Z)':
        sorted.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Name (Z-A)':
        sorted.sort((a, b) => b.name.compareTo(a.name));
        break;
      case 'Price (Low-High)':
        sorted.sort((a, b) => a.newPrice.compareTo(b.newPrice));
        break;
      case 'Price (High-Low)':
        sorted.sort((a, b) => b.newPrice.compareTo(a.newPrice));
        break;
      default:
        // Best selling - keep original order
        break;
    }
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    final sortedProducts = _getSortedProducts();

    return UnionPageScaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final isMobile = width < 600;
          
          int columns = 2;
          if (width >= 900) {
            columns = 4;
          } else if (width >= 600) {
            columns = 3;
          }

          const double maxContentWidth = 1200.0;
          final double contentWidth = width > maxContentWidth ? maxContentWidth : width;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(isMobile ? 12.0 : 16.0),
              child: Center(
                child: SizedBox(
                  width: contentWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Center(
                        child: Text(
                          'SALE',
                          style: TextStyle(
                            fontSize: isMobile ? 24 : 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Subtitle
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: isMobile ? 16.0 : 0),
                          child: Text(
                            'Don\'t miss out! Get yours before they\'re all gone!',
                            style: TextStyle(
                              fontSize: isMobile ? 13 : 14,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: isMobile ? 12 : 16),
                      // Discount notice
                      Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 8 : 12,
                            vertical: isMobile ? 4 : 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.percent, size: isMobile ? 14 : 16, color: Colors.black54),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  'All prices shown are inclusive of the discount',
                                  style: TextStyle(fontSize: isMobile ? 11 : 12, color: Colors.black54),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: isMobile ? 16 : 24),

                      // Filter and Sort bar - responsive layout
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 8 : 12,
                          vertical: isMobile ? 6 : 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: isMobile
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // FILTER BY
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'FILTER BY',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      DropdownButtonFormField<String>(
                                        isExpanded: true,
                                        initialValue: _filterBy,
                                        decoration: const InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                          border: OutlineInputBorder(),
                                        ),
                                        items: _filterOptions
                                            .map((f) => DropdownMenuItem(
                                                  value: f,
                                                  child: Text(f, style: const TextStyle(fontSize: 13)),
                                                ))
                                            .toList(),
                                        onChanged: (v) {
                                          if (v != null) {
                                            setState(() {
                                              _filterBy = v;
                                            });
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  // SORT BY
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'SORT BY',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      DropdownButtonFormField<String>(
                                        isExpanded: true,
                                        initialValue: _sortBy,
                                        decoration: const InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                          border: OutlineInputBorder(),
                                        ),
                                        items: _sortOptions
                                            .map((s) => DropdownMenuItem(
                                                  value: s,
                                                  child: Text(s, style: const TextStyle(fontSize: 13)),
                                                ))
                                            .toList(),
                                        onChanged: (v) {
                                          if (v != null) {
                                            setState(() {
                                              _sortBy = v;
                                            });
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  // Product count
                                  Center(
                                    child: Text(
                                      '${sortedProducts.length} products',
                                      style: const TextStyle(color: Colors.black54, fontSize: 12),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  // FILTER BY
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'FILTER BY',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        DropdownButton<String>(
                                          isExpanded: true,
                                          value: _filterBy,
                                          items: _filterOptions
                                              .map((f) => DropdownMenuItem(
                                                    value: f,
                                                    child: Text(f),
                                                  ))
                                              .toList(),
                                          onChanged: (v) {
                                            if (v != null) {
                                              setState(() {
                                                _filterBy = v;
                                              });
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),

                                  // SORT BY
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'SORT BY',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        DropdownButton<String>(
                                          isExpanded: true,
                                          value: _sortBy,
                                          items: _sortOptions
                                              .map((s) => DropdownMenuItem(
                                                    value: s,
                                                    child: Text(s),
                                                  ))
                                              .toList(),
                                          onChanged: (v) {
                                            if (v != null) {
                                              setState(() {
                                                _sortBy = v;
                                              });
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),

                                  // Product count
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${sortedProducts.length} products',
                                        style: const TextStyle(color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      SizedBox(height: isMobile ? 16 : 24),

                      // Products Grid
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          crossAxisSpacing: isMobile ? 12 : 16,
                          mainAxisSpacing: isMobile ? 20 : 24,
                          childAspectRatio: isMobile ? 0.75 : 0.72,
                        ),
                        itemCount: sortedProducts.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final product = sortedProducts[index];
                          final discount = ((product.oldPrice - product.newPrice) / product.oldPrice * 100).round();
                          final isSoldOut = product.id == 18 || product.id == 26; // A5 Notepad and Men's Nike pants

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductPage(product: product),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image with badge
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
                                      child: AspectRatio(
                                        aspectRatio: 1.0,
                                        child: CachedNetworkImage(
                                          imageUrl: product.image,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Container(
                                            color: Colors.grey[200],
                                            child: const Center(child: CircularProgressIndicator()),
                                          ),
                                          errorWidget: (context, url, error) {
                                            return Container(
                                              color: Colors.grey[200],
                                              child: const Center(
                                                child: Icon(
                                                  Icons.image_not_supported,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    // Sale badge or Sold out
                                    if (isSoldOut)
                                      Positioned(
                                        top: isMobile ? 6 : 8,
                                        left: isMobile ? 6 : 8,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: isMobile ? 6 : 8,
                                            vertical: isMobile ? 3 : 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[800],
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            'Sold out',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: isMobile ? 10 : 11,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      )
                                    else if (discount > 0)
                                      Positioned(
                                        top: isMobile ? 6 : 8,
                                        left: isMobile ? 6 : 8,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: isMobile ? 6 : 8,
                                            vertical: isMobile ? 3 : 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            'SALE!',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: isMobile ? 10 : 11,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(height: isMobile ? 6 : 8),
                                // Product name
                                Text(
                                  product.name,
                                  style: TextStyle(
                                    fontSize: isMobile ? 13 : 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                // Prices
                                Wrap(
                                  spacing: 6,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text(
                                      '£${product.oldPrice.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: isMobile ? 12 : 13,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    Text(
                                      '£${product.newPrice.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: isMobile ? 13 : 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}