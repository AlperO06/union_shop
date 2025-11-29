import 'package:flutter/material.dart';

class SalePage extends StatelessWidget {
  const SalePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sale'),
      ),
      body: const Center(
        child: Text('Sale page'),
      ),
    );
  }
}
