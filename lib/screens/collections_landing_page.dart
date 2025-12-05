import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
                            imageUrl: 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=600&h=400&fit=crop',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Black Friday',
                            route: '/sale',
                            imageUrl: 'https://images.unsplash.com/photo-1607083206968-13611e3d76db?w=600&h=400&fit=crop',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Clothing',
                            route: '/collections/clothing',
                            imageUrl: 'https://images.unsplash.com/photo-1489987707025-afc232f7ea0f?w=600&h=400&fit=crop',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Clothing - Original',
                            route: '/collections/clothing',
                            imageUrl: 'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=600&h=400&fit=crop',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Elections Discounts',
                            route: '/collections/clothing',
                            imageUrl: 'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=600&h=400&fit=crop',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Essential Range',
                            route: '/collections/clothing',
                            imageUrl: 'https://images.unsplash.com/photo-1620799140188-3b2a02fd9a77?w=600&h=400&fit=crop',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Graduation',
                            route: '/collections/clothing',
                            imageUrl: 'https://images.unsplash.com/photo-1607237138185-eedd9c632b0b?w=600&h=400&fit=crop',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Limited Edition Essential Zip Hoodies',
                            route: '/collections/clothing',
                            imageUrl: 'https://images.unsplash.com/photo-1620799139834-6b8f844fbe61?w=600&h=400&fit=crop',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Merchandise',
                            route: '/collections/clothing',
                            imageUrl: 'https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?w=600&h=400&fit=crop',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Nike Final Chance',
                            route: '/sale',
                            imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600&h=400&fit=crop',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Personalisation',
                            route: '/print-shack',
                            imageUrl: 'https://images.unsplash.com/photo-1618354691373-d851c5c3a990?w=600&h=400&fit=crop',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Popular',
                            route: '/collections/clothing',
                            imageUrl: 'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=600&h=400&fit=crop',
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
              CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[200],
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) {
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
