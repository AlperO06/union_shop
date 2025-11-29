import 'package:flutter/material.dart';

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
    const double verticalPadding = 24.0;
    // Slightly narrower max width improves readability on large screens.
    const double maxContentWidth = 640.0;
    const double sectionSpacing = 16.0;
    const double smallSpacing = 8.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
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
                  // Mission card
                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
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
                          SizedBox(height: smallSpacing),
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
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
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
                          SizedBox(height: smallSpacing),
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
