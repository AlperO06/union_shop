import 'package:flutter/material.dart';
import 'widgets/union_page_scaffold.dart'; // added import
import 'bottom_union_footer.dart'; // NEW: footer import

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final collections = [
      {'title': 'Campus Classics', 'subtitle': 'Hoodies & tees'},
      {'title': 'Gifts & Souvenirs', 'subtitle': 'Mugs, magnets & more'},
      {'title': 'Accessories', 'subtitle': 'Bags, hats & stationery'},
      {'title': 'Tech & Gadgets', 'subtitle': 'Chargers, cases & more'},
      {'title': 'Home & Decor', 'subtitle': 'Posters, cushions'},
      {'title': 'Seasonal Picks', 'subtitle': 'Limited time items'},
    ];

    final width = MediaQuery.of(context).size.width;
    final useGrid = width >= 600;
    // choose columns based on breakpoints: 2 for >=600, 3 for >=900, 4 for >=1200
    int columns = 2;
    if (width >= 1200) {
      columns = 4;
    } else if (width >= 900) {
      columns = 3;
    } else if (width >= 600) {
      columns = 2;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Collections'),
        centerTitle: true,
        elevation: 1,
        backgroundColor: const Color(0xFF4d2963),
      ),
      body: Column(
        children: [
          // make the existing scrolling content take available space
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: useGrid
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: collections.length,
                      itemBuilder: (context, index) {
                        final c = collections[index];
                        return Card(
                          clipBehavior: Clip.hardEdge,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CollectionDetailPage(
                                    title: c['title']!,
                                    subtitle: c['subtitle']!,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Center(
                                        child: Icon(Icons.image, size: 48, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    c['title']!,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    c['subtitle']!,
                                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : ListView.builder(
                      itemCount: collections.length,
                      itemBuilder: (context, index) {
                        final c = collections[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CollectionDetailPage(
                                    title: c['title']!,
                                    subtitle: c['subtitle']!,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Center(
                                      child: Icon(Icons.image, size: 36, color: Colors.grey),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          c['title']!,
                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          c['subtitle']!,
                                          style: const TextStyle(fontSize: 13, color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
          // footer always visible below the scrollable content
          const UnionFooter(),
        ],
      ),
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
  late final List<Map<String, String>> _allProducts;

  @override
  void initState() {
    super.initState();
    // generate dummy products with assigned categories (cycle through categories excluding 'All')
    final assignCats = _categories.where((c) => c != 'All').toList();
    _allProducts = List.generate(8, (i) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xFF4d2963),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: LayoutBuilder(builder: (context, constraints) {
          final width = constraints.maxWidth;
          int columns = 1;
          if (width >= 1200) {
            columns = 4;
          } else if (width >= 900) {
            columns = 3;
          } else if (width >= 600) {
            columns = 2;
          }

          // get filtered & sorted products
          final sortedProducts = _applyFilterAndSort();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.subtitle, style: const TextStyle(fontSize: 16, color: Colors.black54)),
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
                    // Category control (left)
                    Expanded(
                      child: Row(
                        children: [
                          const Text('Category:', style: TextStyle(fontSize: 14)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: DropdownButton<String>(
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
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Sort control (center-left)
                    Expanded(
                      child: Row(
                        children: [
                          const Text('Sort:', style: TextStyle(fontSize: 14)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: DropdownButton<String>(
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
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Item count (right)
                    Text('${sortedProducts.length} item(s)', style: const TextStyle(color: Colors.black54)),
                  ],
                ),
              ),

              const SizedBox(height: 12),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: sortedProducts.length,
                  itemBuilder: (context, index) {
                    final p = sortedProducts[index];
                    return Card(
                      clipBehavior: Clip.hardEdge,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
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
                              const SizedBox(height: 4),
                              Text(
                                p['category']!,
                                style: const TextStyle(fontSize: 12, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

