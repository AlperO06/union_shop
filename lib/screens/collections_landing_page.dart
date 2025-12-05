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
                            imageUrl: 'https://i.scdn.co/image/ab67616d0000b273ea6c631a7b6c00917f7bce6c',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Black Friday',
                            route: '/sale',
                            imageUrl: 'https://www.cavendishschool.com/wp-content/uploads/black-friday-2894130_960_720.png',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Clothing',
                            route: '/collections/clothing',
                            imageUrl: 'https://data2.nssmag.com/images/galleries/30635/cover-corteiz.jpg',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Clothing - Original',
                            route: '/collections/clothing',
                            imageUrl: 'https://i.ebayimg.com/images/g/cA4AAOSw~eVlasvq/s-l1200.jpg',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Elections Discounts',
                            route: '/collections/clothing',
                            imageUrl: 'https://images.opumo.com/wordpress/wp-content/uploads/2025/02/Layer-1-16-989x1200.png',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Essential Range',
                            route: '/collections/clothing',
                            imageUrl: 'https://www.thetimes.com/imageserver/image/%2Fmethode%2Fsundaytimes%2Fprod%2Fweb%2Fbin%2F82e89334-6f32-11ed-b4c7-e77de57f61fe.jpg?crop=2608%2C3912%2C1704%2C49,
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Graduation',
                            route: '/collections/clothing',
                            imageUrl: 'https://upload.wikimedia.org/wikipedia/en/7/70/Graduation_%28album%29.jpg',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Limited Edition Essential Zip Hoodies',
                            route: '/collections/clothing',
                            imageUrl: 'https://upload.wikimedia.org/wikipedia/en/thumb/a/ac/Dropout_Bear_Grad.png/250px-Dropout_Bear_Grad.png',
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Merchandise',
                            route: '/collections/clothing',
                            imageUrl: 'https://static01.nyt.com/images/2016/08/21/fashion/21KANYE-POP-UP-slide-E14L/21KANYE-POP-UP-slide-E14L-articleLarge.jpg?quality=75&auto=webp&disable=upscale',
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
