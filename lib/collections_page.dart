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

// add placeholder detail page
class CollectionDetailPage extends StatelessWidget {
  final String title;
  final String subtitle;

  const CollectionDetailPage({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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

          // Dummy products for this collection
          final products = List.generate(8, (i) {
            return {
              'name': '$title Product ${i + 1}',
              'price': '£${(i + 1) * 5}.00',
            };
          });

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(subtitle, style: const TextStyle(fontSize: 16, color: Colors.black54)),
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
