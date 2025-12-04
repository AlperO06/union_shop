import 'package:flutter/material.dart';
import '../widgets/union_page_scaffold.dart'; // added import
import '../models/product.dart';
import '../data/products.dart';
import '../product_page.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CollectionDetailPage(
      title: 'Clothing',
      subtitle: '',
    );
  }
}

// convert CollectionDetailPage to a StatefulWidget to track dropdown selection
class CollectionDetailPage extends StatefulWidget {
  final String title;
  final String subtitle;

  const CollectionDetailPage({super.key, required this.title, required this.subtitle});

  @override
  State<CollectionDetailPage> createState() => _CollectionDetailPageState();
}

class _CollectionDetailPageState extends State<CollectionDetailPage> {
  final List<String> _categories = ['All', 'Tops', 'Accessories', 'Home', 'Gifts'];
  String _selectedCategory = 'All';
  final List<String> _sortOptions = [
    'Name (A-Z)',
    'Name (Z-A)',
    'Price (Low-High)',
    'Price (High-Low)'
  ];
  String _selectedSort = 'Name (A-Z)';
  // pagination state
  int _currentPage = 1;
  final int _itemsPerPage = 6;
  // avoid null access by providing an empty list default; initState will populate it
  List<Product> _allProducts = [];
  // total pages based on current filtered/sorted products
  int get totalPages {
    final totalItems = _applyFilterAndSort().length;
    if (totalItems == 0) return 1;
    return (totalItems / _itemsPerPage).ceil();
  }

  @override
  void initState() {
    super.initState();
    // Use actual Product objects from products.dart (IDs 9-17 are the collection items)
    _allProducts = products.where((p) => p.id >= 9 && p.id <= 17).toList();
  }

  // Helper to determine category based on product ID ranges or name
  String _getCategory(Product product) {
    // IDs 9-14 are Tops, 15-17 are Accessories
    if (product.id >= 9 && product.id <= 14) return 'Tops';
    if (product.id >= 15 && product.id <= 17) return 'Accessories';
    return 'All';
  }

  double _priceValue(Product product) {
    return product.newPrice;
  }

  List<Product> _applyFilterAndSort() {
    final filtered = _selectedCategory == 'All'
        ? _allProducts.toList()
        : _allProducts.where((p) => _getCategory(p) == _selectedCategory).toList();

    final sorted = filtered.toList();
    switch (_selectedSort) {
      case 'Name (A-Z)':
        sorted.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Name (Z-A)':
        sorted.sort((a, b) => b.name.compareTo(a.name));
        break;
      case 'Price (Low-High)':
        sorted.sort((a, b) => _priceValue(a).compareTo(_priceValue(b)));
        break;
      case 'Price (High-Low)':
        sorted.sort((a, b) => _priceValue(b).compareTo(_priceValue(a)));
        break;
      default:
        break;
    }
    return sorted;
  }

  // return only the products for the current page based on _itemsPerPage
  List<Product> _paginatedProducts() {
    final all = _applyFilterAndSort();
    final int start = (_currentPage - 1) * _itemsPerPage;
    if (start >= all.length) return <Product>[];
    int end = start + _itemsPerPage;
    if (end > all.length) end = all.length;
    return all.sublist(start, end);
  }

  @override
  Widget build(BuildContext context) {
    return UnionPageScaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: LayoutBuilder(builder: (context, constraints) {
          final width = constraints.maxWidth;
          // responsive columns: wide screens use 3 columns, medium 2, small 1
          int columns = 1;
          if (width >= 900) {
            columns = 3;
          } else if (width >= 600) {
            columns = 2;
          }

          // center content and constrain to a max width to match reference layout
          const double maxContentWidth = 1100.0;
          final double contentWidth = width > maxContentWidth ? maxContentWidth : width;

          // get filtered & sorted products
          final sortedProducts = _applyFilterAndSort();
          // only display the items for the current page
          final pageProducts = _paginatedProducts();
          final int totalPages = ((sortedProducts.length + _itemsPerPage - 1) ~/ _itemsPerPage);
          final int displayTotalPages = totalPages > 0 ? totalPages : 1;

          return Center(
            child: SizedBox(
              width: contentWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Big centered category heading for the products grid
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Horizontal filter bar: Category + Sort, neatly spaced and padded
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        // FILTER BY (label above dropdown)
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'FILTER BY',
                                // made label slightly smaller to be a "small label"
                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black54),
                              ),
                              const SizedBox(height: 8),
                              DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedCategory,
                                items: _categories
                                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                                    .toList(),
                                onChanged: (v) {
                                  if (v == null) return;
                                  setState(() {
                                    _selectedCategory = v;
                                    // reset to first page when filter changes
                                    _currentPage = 1;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 16),

                        // SORT BY (label above dropdown)
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'SORT BY',
                                // made label slightly smaller to be a "small label"
                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black54),
                              ),
                              const SizedBox(height: 8),
                              DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedSort,
                                items: _sortOptions
                                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                                    .toList(),
                                onChanged: (v) {
                                  if (v == null) return;
                                  setState(() {
                                    _selectedSort = v;
                                    // reset to first page when sort changes
                                    _currentPage = 1;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 16),

                        // move item count to the right side, vertically centered
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text('${sortedProducts.length} products', style: const TextStyle(color: Colors.black54)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      childAspectRatio: 0.72,
                    ),
                    itemCount: pageProducts.length,
                    // allow embedding in outer scroll view
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final p = pageProducts[index];
                      return Card(
                        // flatter card style, edge-to-edge inside grid cell
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        color: Colors.white,
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        child: InkWell(
                          onTap: () {
                            // Navigate to the product page with the actual Product object
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductPage(product: p),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // replaced static icon container with network image using the new 'image' field
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.network(
                                      p.image,
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey[200],
                                          child: const Center(
                                            child: Icon(Icons.image, size: 48, color: Colors.grey),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  p.name,
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '£${p.newPrice.toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // show pagination only when more than one page exists
                  if (displayTotalPages > 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: _currentPage > 1
                                  ? () {
                                      setState(() {
                                        // decrease but never go below 1
                                        final nextPage = _currentPage - 1;
                                        _currentPage = nextPage < 1 ? 1 : nextPage;
                                      });
                                    }
                                  : null,
                            ),
                            const SizedBox(width: 8),
                            Text('Page $_currentPage of $displayTotalPages', style: const TextStyle(color: Colors.black54)),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.arrow_forward),
                              onPressed: _currentPage < displayTotalPages
                                  ? () {
                                      setState(() {
                                        // increase but never exceed total pages
                                        final nextPage = _currentPage + 1;
                                        _currentPage = nextPage > displayTotalPages ? displayTotalPages : nextPage;
                                      });
                                    }
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

