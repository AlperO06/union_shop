import 'package:flutter/material.dart';
import 'union_header.dart';
import '../bottom_union_footer.dart';
import '../screens/print_shack_product_page.dart';
import '../data/print_shack.dart';


class UnionPageScaffold extends StatelessWidget {
  final Widget body;

  const UnionPageScaffold({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // compute screen-size boolean using MediaQuery
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UnionHeader(
              onProfilePressed: () => Navigator.pushNamed(context, '/login'),
              onCartPressed: () => Navigator.pushNamed(context, '/cart'),
              // when Print Shack menu is clicked navigate to the PrintShackProductPage
              onPrintShackPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PrintShackProductPage(product: samplePersonalisedHoodie),
                  ),
                );
              },
              // pass screen-size flag
              isMobile: isMobile,
            ),
            body,
            const UnionFooter(), // positioned after the body; scrolls together with body
          ],
        ),
      ),
    );
  }
}
