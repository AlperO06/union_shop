import 'package:flutter/material.dart';

/// A simple About page scaffold.
///
/// Created so it can be imported and used from other parts of the app.
class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Our Mission',
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Union Shop is a community-focused marketplace offering handmade goods, vintage finds, and locally sourced products. We connect small makers with customers, supporting sustainable shopping and neighborhood entrepreneurship.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Student Union Involvement',
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'We partner with the Student Union to host student vendor markets, provide resources and workshops for student entrepreneurs, and create opportunities for students to showcase their work on campus.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
