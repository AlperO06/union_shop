import 'package:flutter/material.dart';
import 'widgets/union_page_scaffold.dart'; // added import

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
  late final List<Map<String, String>> _allProducts;

  @override
  void initState() {
    super.initState();
    // generate dummy products with assigned categories (cycle through categories excluding 'All')
    final assignCats = _categories.where((c) => c != 'All').toList();
    _allProducts = List.generate(9, (i) {
      // use a seeded picsum URL per product so images differ
      final seed = '${widget.title.replaceAll(' ', '')}-$i';
      final imageUrl = 'https://picsum.photos/seed/$seed/400/400';
      return {
        'name': '${widget.title} Product ${i + 1}',
        'price': '£${(i + 1) * 5}.00',
        'category': assignCats[i % assignCats.length],
        'image': imageUrl, // new image field
      };
    });
  }

  double _priceValue(String priceText) {
    final m = RegExp(r'[\d\.]+').firstMatch(priceText);
    return m != null ? double.tryParse(m.group(0)!) ?? 0.0 : 0.0;
  }

  List<Map<String, String>> _applyFilterAndSort() {
    final filtered = _selectedCategory == 'All'
        ? _allProducts.toList()
        : _allProducts.where((p) => p['category'] == _selectedCategory).toList();

    final sorted = filtered.toList();
    switch (_selectedSort) {
      case 'Name (A-Z)':
        sorted.sort((a, b) => a['name']!.compareTo(b['name']!));
        break;
      case 'Name (Z-A)':
        sorted.sort((a, b) => b['name']!.compareTo(a['name']!));
        break;
      case 'Price (Low-High)':
        sorted.sort((a, b) => _priceValue(a['price']!).compareTo(_priceValue(b['price']!)));
        break;
      case 'Price (High-Low)':
        sorted.sort((a, b) => _priceValue(b['price']!).compareTo(_priceValue(a['price']!)));
        break;
      default:
        break;
    }
    return sorted;
  }

  // return only the products for the current page based on _itemsPerPage
  List<Map<String, String>> _paginatedProducts() {
    final all = _applyFilterAndSort();
    final int start = (_currentPage - 1) * _itemsPerPage;
    if (start >= all.length) return <Map<String, String>>[];
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
                            // placeholder: navigate to product detail if needed
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
                                      p['image'] ?? '',
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
                                  p['name']!,
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  p['price']!,
                                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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

