import 'package:flutter/material.dart';

class SalePage extends StatelessWidget {
  const SalePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sale'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SafeArea(
            top: true,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.deepOrangeAccent],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(Icons.local_offer, color: Colors.white),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'BIG SALE – LIMITED TIME',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text('Sale page'),
            ),
          ),
        ],
      ),
    );
  }
}
