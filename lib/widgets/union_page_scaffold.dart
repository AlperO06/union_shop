import 'package:flutter/material.dart';
import 'union_header.dart';
import '../bottom_union_footer.dart';


class UnionPageScaffold extends StatelessWidget {
  final Widget body;

  const UnionPageScaffold({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UnionHeader(
              onProfilePressed: () => Navigator.pushNamed(context, '/login'),
            ),
            body,
            const UnionFooter(), // positioned after the body; scrolls together with body
          ],
        ),
      ),
    );
  }
}
