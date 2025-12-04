import 'package:flutter/material.dart';
import '../widgets/union_page_scaffold.dart';

class CollectionsLandingPage extends StatelessWidget {
  const CollectionsLandingPage({Key? key}) : super(key: key);

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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Title
                      Text(
                        'Collections',
                        style: TextStyle(
                          fontSize: isMobile ? 28 : 36,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(height: isMobile ? 32 : 48),

                      // Collections Grid
                      GridView.count(
                        crossAxisCount: isMobile ? 1 : (width < 900 ? 2 : 3),
                        crossAxisSpacing: isMobile ? 16 : 20,
                        mainAxisSpacing: isMobile ? 16 : 20,
                        childAspectRatio: isMobile ? 1.4 : 1.3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _buildCollectionCard(
                            context,
                            title: 'Autumn Favourites',
                            route: '/collections/clothing',
                            imageUrl: 'https://shop.upsu.net/cdn/shop/collections/crewnecks.jpg?v=1731079265&width=480',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Black Friday',
                            route: '/sale',
                            imageUrl: 'https://shop.upsu.net/cdn/shop/collections/black_friday_2_1.jpg?v=1700487733&width=480',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Clothing',
                            route: '/collections/clothing',
                            imageUrl: 'https://shop.upsu.net/cdn/shop/collections/hoodies_35c6a90c-27fa-45df-a50f-b4833029fc6f.jpg?v=1731078851&width=480',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Clothing - Original',
                            route: '/collections/clothing',
                            imageUrl: 'https://shop.upsu.net/cdn/shop/collections/hoodies_f9ca7e5f-cbf5-46c6-8ce2-f914ef24ee93.jpg?v=1731078873&width=480',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Elections Discounts',
                            route: '/collections/clothing',
                            imageUrl: 'https://shop.upsu.net/cdn/shop/collections/hoodies.jpg?v=1731078792&width=480',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Essential Range',
                            route: '/collections/clothing',
                            imageUrl: 'https://shop.upsu.net/cdn/shop/collections/essentials.jpg?v=1731079286&width=480',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Graduation',
                            route: '/collections/clothing',
                            imageUrl: 'https://shop.upsu.net/cdn/shop/collections/graduation.jpg?v=1731079305&width=480',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Limited Edition Essential Zip Hoodies',
                            route: '/collections/clothing',
                            imageUrl: 'https://shop.upsu.net/cdn/shop/collections/zip_hoodie.jpg?v=1731079318&width=480',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Merchandise',
                            route: '/collections/clothing',
                            imageUrl: 'https://shop.upsu.net/cdn/shop/collections/merchandise.jpg?v=1731079329&width=480',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Nike Final Chance',
                            route: '/sale',
                            imageUrl: 'https://shop.upsu.net/cdn/shop/collections/nike.jpg?v=1731079341&width=480',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Personalisation',
                            route: '/print-shack',
                            imageUrl: 'https://shop.upsu.net/cdn/shop/collections/personalisation_1.jpg?v=1704203808&width=480',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Popular',
                            route: '/collections/clothing',
                            imageUrl: 'https://shop.upsu.net/cdn/shop/collections/popular.jpg?v=1731079353&width=480',
                          ),
                        ],
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

  Widget _buildCollectionCard(
    BuildContext context, {
    required String title,
    required String route,
    required String imageUrl,
  }) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.image_not_supported, color: Colors.grey),
                    ),
                  );
                },
              ),
              // Dark Overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.5),
                    ],
                  ),
                ),
              ),
              // Text Overlay
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 3,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
