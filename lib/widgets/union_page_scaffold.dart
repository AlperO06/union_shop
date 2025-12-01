import 'package:flutter/material.dart';
import 'union_header.dart';
import '../bottom_union_footer.dart';


class UnionPageScaffold extends StatelessWidget {
  final Widget body;

  const UnionPageScaffold({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const UnionHeader(),
          Expanded(child: body),
          const UnionFooter(), // mounted globally after the page body
        ],
      ),
    );
  }
}
