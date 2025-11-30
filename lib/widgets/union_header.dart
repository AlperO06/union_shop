import 'package:flutter/material.dart';

// The helper functions are duplicated here so the widget remains self-contained
// and behaves identically when moved out of `main.dart`.
void placeholderCallbackForButtons() {
  // lightweight placeholder - replace with real logic
  debugPrint('placeholder button pressed');
}

void navigateToAbout(BuildContext context) {
  Navigator.pushNamed(context, '/about');
}

void navigateToHome(BuildContext context) {
  // return to the root route (home)
  Navigator.popUntil(context, (route) => route.isFirst);
}

// New: reusable header widget containing the purple sale banner and white nav row
class UnionHeader extends StatelessWidget {
  const UnionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // thin top banner above the AppBar
        Container(
          height: 28,
          width: double.infinity,
          color: const Color(0xFF4d2963), // dark purple
          alignment: Alignment.center,
          child: const Text(
            'BIG SALE! OVER 20% OFF ESSENTIALS',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ),
        // actual AppBar-like row placed inside body so it scrolls away
        Material(
          color: Colors.white,
          elevation: 0,
          child: SizedBox(
            height: kToolbarHeight,
            child: LayoutBuilder(builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 700;
              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: GestureDetector(
                      onTap: () => navigateToHome(context),
                      child: Image.network(
                        'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                        height: 28,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            width: 28,
                            height: 28,
                            child: const Center(
                              child: Icon(Icons.image_not_supported, color: Colors.grey),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // navigation buttons: visible only on wide screens
                  Expanded(
                    child: isWide
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton(
                                onPressed: () => navigateToHome(context),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                                child: const Text('Home'),
                              ),
                              const SizedBox(width: 8),
                              TextButton(
                                onPressed: () => Navigator.pushNamed(context, '/collections'),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                                child: const Text('Shop'),
                              ),
                              const SizedBox(width: 8),
                              TextButton(
                                onPressed: () => Navigator.pushNamed(context, '/sale'),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                ),
                                child: const Text('SALE'),
                              ),
                              const SizedBox(width: 8),
                              TextButton(
                                onPressed: () => navigateToAbout(context),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                                child: const Text('About'),
                              ),
                            ],
                          )
                        : const SizedBox(), // still expands to push icons to the right
                  ),
                  // action icons: show full set on wide, minimal set on narrow
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: isWide
                        ? [
                            const IconButton(
                              icon: Icon(Icons.search, size: 18, color: Colors.grey),
                              padding: EdgeInsets.all(8),
                              constraints: BoxConstraints(minWidth: 32, minHeight: 32),
                              onPressed: placeholderCallbackForButtons,
                            ),
                            const IconButton(
                              icon: Icon(Icons.person_outline, size: 18, color: Colors.grey),
                              padding: EdgeInsets.all(8),
                              constraints: BoxConstraints(minWidth: 32, minHeight: 32),
                              onPressed: placeholderCallbackForButtons,
                            ),
                            const IconButton(
                              icon: Icon(Icons.shopping_bag_outlined, size: 18, color: Colors.grey),
                              padding: EdgeInsets.all(8),
                              constraints: BoxConstraints(minWidth: 32, minHeight: 32),
                              onPressed: placeholderCallbackForButtons,
                            ),
                            const IconButton(
                              icon: Icon(Icons.menu, size: 18, color: Colors.grey),
                              padding: EdgeInsets.all(8),
                              constraints: BoxConstraints(minWidth: 32, minHeight: 32),
                              onPressed: placeholderCallbackForButtons,
                            ),
                          ]
                        : [
                            const IconButton(
                              icon: Icon(Icons.shopping_bag_outlined, size: 18, color: Colors.grey),
                              padding: EdgeInsets.all(8),
                              constraints: BoxConstraints(minWidth: 32, minHeight: 32),
                              onPressed: placeholderCallbackForButtons,
                            ),
                            const IconButton(
                              icon: Icon(Icons.menu, size: 18, color: Colors.grey),
                              padding: EdgeInsets.all(8),
                              constraints: BoxConstraints(minWidth: 32, minHeight: 32),
                              onPressed: placeholderCallbackForButtons,
                            ),
                          ],
                  ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
