import 'package:flutter/material.dart';
import 'widgets/union_page_scaffold.dart';

/// A simple About page scaffold.
///
/// Created so it can be imported and used from other parts of the app.
class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    // Stronger heading styles for clear separation of sections
    final TextStyle headingLarge = textTheme.titleLarge?.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w800,
        ) ??
        const TextStyle(fontSize: 24, fontWeight: FontWeight.w800);
    final TextStyle headingMedium = textTheme.titleMedium?.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ) ??
        const TextStyle(fontSize: 20, fontWeight: FontWeight.w700);
    const double horizontalPadding = 20.0;
    // Slightly more vertical padding for better overall breathing room
    const double verticalPadding = 28.0;
    // Slightly narrower max width improves readability on large screens.
    const double maxContentWidth = 640.0;
    // Increased spacing for clearer separation between sections/cards
    const double sectionSpacing = 24.0;
    const double smallSpacing = 12.0;

    return UnionPageScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: maxContentWidth),
              // Use a start-aligned Column so paragraph text is left-aligned within
              // the constrained block, while the block itself remains centered on screen.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Page header below the AppBar with light background and centered title
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.grey[100]),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Center(
                      child: Text(
                        'About Us',
                        style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ) ??
                            const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Intro welcome card
                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'Welcome to Union Shop — your destination for official merchandise, campus essentials, and local gifts. Browse our curated collections and support local makers.',
                        style: textTheme.bodyMedium,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Mission card
                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'Our Mission',
                              style: headingLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: smallSpacing),
                          Text(
                            'Union Shop is a community-focused marketplace offering handmade goods, vintage finds, and locally sourced products. We connect small makers with customers, supporting sustainable shopping and neighborhood entrepreneurship.',
                            style: textTheme.bodyMedium,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: sectionSpacing),

                  // Student Union card
                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'Student Union Involvement',
                              style: headingMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: smallSpacing),
                          Text(
                            'We partner with the Student Union to host student vendor markets, provide resources and workshops for student entrepreneurs, and create opportunities for students to showcase their work on campus.',
                            style: textTheme.bodyMedium,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: sectionSpacing),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

