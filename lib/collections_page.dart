import 'package:flutter/material.dart';

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
      body: Padding(
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
  late final List<Map<String, String>> _allProducts;

  @override
  void initState() {
    super.initState();
    // generate dummy products with assigned categories (cycle through categories excluding 'All')
    final assignCats = _categories.where((c) => c != 'All').toList();
    _allProducts = List.generate(8, (i) {
      return {
        'name': '${widget.title} Product ${i + 1}',
        'price': '£${(i + 1) * 5}.00',
        'category': assignCats[i % assignCats.length],
      };
    });
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

          // apply category filter
          final products = _selectedCategory == 'All'
              ? _allProducts
              : _allProducts.where((p) => p['category'] == _selectedCategory).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.subtitle, style: const TextStyle(fontSize: 16, color: Colors.black54)),
              const SizedBox(height: 12),

              // Dropdown to filter by category
              Row(
                children: [
                  const Text('Category: ', style: TextStyle(fontSize: 14)),
                  const SizedBox(width: 8),
                  DropdownButton<String>(
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
                  const Spacer(),
                  Text('${products.length} item(s)', style: const TextStyle(color: Colors.black54)),
                ],
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
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final p = products[index];
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
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
