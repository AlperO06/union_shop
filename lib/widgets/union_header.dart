import 'package:flutter/material.dart';
import '../data/cart.dart';

// Small model used for menu items (label + optional route name)
class ShopMenuItem {
  final String label;
  final String? routeName;

  const ShopMenuItem({required this.label, this.routeName});
}

// New: canonical list of menu items used across the app
const List<ShopMenuItem> kShopMenuItems = [
  ShopMenuItem(label: 'Clothing', routeName: '/collections'),
  ShopMenuItem(label: 'Merchandise', routeName: '/collections'),
  ShopMenuItem(label: 'Halloween', routeName: '/collections'),
  ShopMenuItem(label: 'Signature & Essential Range', routeName: '/collections'),
  ShopMenuItem(label: 'Portsmouth City Collection', routeName: '/collections'),
  ShopMenuItem(label: 'Pride Collection', routeName: '/collections'),
  ShopMenuItem(label: 'Graduation', routeName: '/collections'),
];

// New: simple getter exposing current cart item count
int get cartItemCount => cartItems.length;

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
  const UnionHeader({super.key, required Future<Object?> Function() onProfilePressed, required Future<Object?> Function() onCartPressed});

  // builds the cart icon with a red circular badge showing the item count
  Widget _buildCartButton(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_bag_outlined, size: 18, color: Colors.grey),
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        ),
        if (cartItemCount > 0)
          // position badge slightly outside the top-right of the icon
          Positioned(
            right: -6,
            top: -6,
            child: Semantics(
              label: 'Cart, $cartItemCount items',
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: Center(
                  child: Text(
                    cartItemCount > 9 ? '9+' : '$cartItemCount',
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  // Updated: popup trigger now uses the same padding & text style as the other nav buttons
  Widget buildShopButton(BuildContext context, bool isWideScreen) {
    if (isWideScreen) {
      return PopupMenuButton<ShopMenuItem>(
        // ensure the popup opens below and aligned to the left of the button
        offset: const Offset(0, kToolbarHeight),
        // visible label that reads "Shop" with a drop-down arrow
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Shop',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              SizedBox(width: 6),
              Icon(Icons.arrow_drop_down, size: 20, color: Colors.black),
            ],
          ),
        ),
        onSelected: (item) {
          if (item.routeName != null && item.routeName!.isNotEmpty) {
            Navigator.pushNamed(context, item.routeName!);
          } else {
            debugPrint('Shop menu selected: ${item.label}');
          }
        },
        itemBuilder: (context) {
          return kShopMenuItems.map((item) {
            return PopupMenuItem<ShopMenuItem>(
              value: item,
              child: Text(item.label),
            );
          }).toList();
        },
      );
    }

    // Narrow screens: unchanged simple TextButton (already matches style)
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, '/collections'),
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        textStyle: const TextStyle(fontSize: 16),
      ),
      child: const Text('Shop'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // new: indicates wide screens (>= 700)

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
                                // pass the local isWide flag so narrow screens get a TextButton
                                buildShopButton(context, isWide),
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
                              IconButton(
                                icon: const Icon(Icons.person_outline, size: 18, color: Colors.grey),
                                padding: const EdgeInsets.all(8),
                                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                onPressed: () => Navigator.pushNamed(context, '/login'),
                              ),
                              _buildCartButton(context),
                              const IconButton(
                                icon: Icon(Icons.menu, size: 18, color: Colors.grey),
                                padding: EdgeInsets.all(8),
                                constraints: BoxConstraints(minWidth: 32, minHeight: 32),
                                onPressed: placeholderCallbackForButtons,
                              ),
                            ]
                          : [
                              _buildCartButton(context),
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
    });
  }
}
