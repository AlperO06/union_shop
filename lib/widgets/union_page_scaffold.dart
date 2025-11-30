import 'package:flutter/material.dart';
import 'union_header.dart';

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
        ],
      ),
    );
  }
}
