import 'package:flutter/material.dart';
import '../widgets/union_page_scaffold.dart';

class AboutPrintShackPage extends StatelessWidget {
  const AboutPrintShackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return UnionPageScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            
            // Title
            const Text(
              'The Union Print Shack',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4d2963),
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 40),
            
            // Hero Images
            LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 900;
                
                if (isMobile) {
                  return Column(
                    children: [
                      _buildImage('https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=600'),
                      const SizedBox(height: 16),
                      _buildImage('https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=600'),
                      const SizedBox(height: 16),
                      _buildImage('https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=600'),
                    ],
                  );
                }
                
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: _buildImage('https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=400'),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: _buildImage('https://images.unsplash.com/photo-1523381210434-271e8be1f52b?w=400'),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: _buildImage('https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?w=400'),
                    ),
                  ],
                );
              },
            ),
            
            const SizedBox(height: 40),
            
            // Content sections
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                    'Make it Yours at The Union Print Shack',
                    'Want to add a personal touch? We\'ve got you covered with heat-pressed customisation on all our clothing. Swing by the shop - our team\'s always happy to help you pick the right gear and answer any questions.',
                  ),
                  
                  const SizedBox(height: 24),
                  
                  _buildSection(
                    'Uni Gear or Your Gear – We\'ll Personalise It',
                    'Whether you\'re repping your university or putting your own spin on a hoodie you already own, we\'ve got you covered. We can personalise official uni-branded clothing and your own items - just bring them in and let\'s get creative!',
                  ),
                  
                  const SizedBox(height: 24),
                  
                  _buildSection(
                    'Simple Pricing, No Surprises',
                    'Customising your gear won\'t break the bank - just £3 for one line of text or a small chest logo, and £5 for two lines or a large back logo. Turnaround time is up to three working days, and we\'ll let you know as soon as it\'s ready to collect.',
                  ),
                  
                  const SizedBox(height: 24),
                  
                  _buildSection(
                    'Personalisation Terms & Conditions',
                    'We will print your clothing exactly as you have provided it to us, whether online or in person. We are not responsible for any spelling errors. Please ensure your chosen text is clearly displayed in either capitals or lowercase. Refunds are not provided for any personalised items.',
                  ),
                  
                  const SizedBox(height: 24),
                  
                  _buildSection(
                    'Ready to Make It Yours?',
                    'Pop in or get in touch today - let\'s create something uniquely you with our personalisation service - The Union Print Shack!',
                  ),
                  
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildImage(String url) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 350),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 250,
              color: Colors.grey[300],
              child: const Icon(Icons.image, size: 50, color: Colors.grey),
            );
          },
        ),
      ),
    );
  }
  
  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4d2963),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 16,
            height: 1.5,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
