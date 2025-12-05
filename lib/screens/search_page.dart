import 'package:flutter/material.dart';
import '../widgets/union_page_scaffold.dart';
import '../models/product.dart';
import '../data/products.dart';
import '../product_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _searchResults = [];
  bool _hasSearched = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    setState(() {
      _hasSearched = true;
      if (query.isEmpty) {
        _searchResults = [];
      } else {
        _searchResults = products.where((product) {
          final searchLower = query.toLowerCase();
          return product.name.toLowerCase().contains(searchLower) ||
              product.description.toLowerCase().contains(searchLower);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return UnionPageScaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final isMobile = width < 600;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search Header
                      Text(
                        'Search',
                        style: TextStyle(
                          fontSize: isMobile ? 28 : 36,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(height: isMobile ? 16 : 24),

                      // Search Bar
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: TextField(
                          controller: _searchController,
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: 'Search for products...',
                            prefixIcon: const Icon(Icons.search, color: Colors.grey),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear, color: Colors.grey),
                                    onPressed: () {
                                      _searchController.clear();
                                      _performSearch('');
                                    },
                                  )
                                : null,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                          onChanged: _performSearch,
                          onSubmitted: _performSearch,
                        ),
                      ),
                      SizedBox(height: isMobile ? 24 : 32),

                      // Search Results
                      if (!_hasSearched)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.search,
                                  size: 64,
                                  color: Colors.grey[300],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Search for products',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else if (_searchResults.isEmpty)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 64,
                                  color: Colors.grey[300],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No results found',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Try different keywords',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else ...[
                        Text(
                          '${_searchResults.length} ${_searchResults.length == 1 ? 'result' : 'results'} found',
                          style: TextStyle(
                            fontSize: isMobile ? 14 : 16,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: isMobile ? 16 : 24),
                        GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isMobile ? 2 : (width < 900 ? 3 : 4),
                            crossAxisSpacing: isMobile ? 12 : 16,
                            mainAxisSpacing: isMobile ? 20 : 24,
                            childAspectRatio: isMobile ? 0.75 : 0.72,
                          ),
                          itemCount: _searchResults.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final product = _searchResults[index];
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
                                  // Product Image
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
                                      child: Container(
                                        width: double.infinity,
                                        color: Colors.grey[200],
                                        child: Image.network(
                                          product.image,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.grey[300],
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
                                  ),
                                  SizedBox(height: isMobile ? 6 : 8),
                                  // Product Name
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
                                  // Product Price
                                  Text(
                                    '£${product.newPrice.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: isMobile ? 13 : 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
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
