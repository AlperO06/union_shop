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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Center(
                        child: Text(
                          'Collections',
                          style: TextStyle(
                            fontSize: isMobile ? 28 : 36,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      SizedBox(height: isMobile ? 12 : 16),
                      // Subtitle
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: isMobile ? 16.0 : 0),
                          child: Text(
                            'Browse our curated collections of clothing, merchandise, and accessories',
                            style: TextStyle(
                              fontSize: isMobile ? 14 : 16,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: isMobile ? 32 : 48),

                      // Collections Grid
                      GridView.count(
                        crossAxisCount: isMobile ? 1 : (width < 900 ? 2 : 3),
                        crossAxisSpacing: isMobile ? 16 : 24,
                        mainAxisSpacing: isMobile ? 16 : 24,
                        childAspectRatio: isMobile ? 2.5 : 1.5,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _buildCollectionCard(
                            context,
                            title: 'Clothing',
                            description: 'Explore our full range of apparel',
                            route: '/collections/clothing',
                            icon: Icons.checkroom,
                            color: const Color(0xFF4d2963),
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Merchandise',
                            description: 'Official university merchandise',
                            route: '/collections/clothing',
                            icon: Icons.shopping_bag,
                            color: Colors.deepPurple,
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Accessories',
                            description: 'Complete your look',
                            route: '/collections/clothing',
                            icon: Icons.watch,
                            color: Colors.indigo,
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Halloween',
                            description: 'Spooky season essentials',
                            route: '/collections/clothing',
                            icon: Icons.celebration,
                            color: Colors.orange,
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Signature & Essential Range',
                            description: 'Classic must-haves',
                            route: '/collections/clothing',
                            icon: Icons.star,
                            color: Colors.amber,
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Portsmouth City Collection',
                            description: 'Local pride and landmarks',
                            route: '/collections/clothing',
                            icon: Icons.location_city,
                            color: Colors.blue,
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Pride Collection',
                            description: 'Celebrate diversity and inclusion',
                            route: '/collections/clothing',
                            icon: Icons.favorite,
                            color: Colors.pink,
                          ),
                          _buildCollectionCard(
                            context,
                            title: 'Graduation',
                            description: 'Celebrate your achievement',
                            route: '/collections/clothing',
                            icon: Icons.school,
                            color: Colors.teal,
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
    required String description,
    required String route,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.05),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 40,
                color: color,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
