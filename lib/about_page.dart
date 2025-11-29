import 'package:flutter/material.dart';

/// A simple About page scaffold.
///
/// Created so it can be imported and used from other parts of the app.
class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    const double horizontalPadding = 20.0;
    const double verticalPadding = 24.0;
    const double maxContentWidth = 700.0;
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Our Mission',
                    style: textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: smallSpacing),
                  Text(
                    'Union Shop is a community-focused marketplace offering handmade goods, vintage finds, and locally sourced products. We connect small makers with customers, supporting sustainable shopping and neighborhood entrepreneurship.',
                    style: textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: sectionSpacing),
                  Text(
                    'Student Union Involvement',
                    style: textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: smallSpacing),
                  Text(
                    'We partner with the Student Union to host student vendor markets, provide resources and workshops for student entrepreneurs, and create opportunities for students to showcase their work on campus.',
                    style: textTheme.bodyMedium,
                    textAlign: TextAlign.center,
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
