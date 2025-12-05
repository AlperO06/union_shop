import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/cart.dart';
import '../services/auth_service.dart';

// Small model used for menu items (label + optional route name)
class ShopMenuItem {
  final String label;
  final String? routeName;

  const ShopMenuItem({required this.label, this.routeName});
}

// New: canonical list of menu items used across the app
const List<ShopMenuItem> shopMenuItems = [
  ShopMenuItem(label: 'Clothing', routeName: '/collections/clothing'),
  ShopMenuItem(label: 'Merchandise', routeName: '/collections/clothing'),
  ShopMenuItem(label: 'Halloween', routeName: '/collections/clothing'),
  ShopMenuItem(label: 'Signature & Essential Range', routeName: '/collections/clothing'),
  ShopMenuItem(label: 'Portsmouth City Collection', routeName: '/collections/clothing'),
  ShopMenuItem(label: 'Pride Collection', routeName: '/collections/clothing'),
  ShopMenuItem(label: 'Graduation', routeName: '/collections/clothing'),
];

// Print Shack menu items
const List<ShopMenuItem> printShackMenuItems = [
  ShopMenuItem(label: 'About', routeName: '/about-print-shack'),
  ShopMenuItem(label: 'Personalisation', routeName: '/print-shack'),
];

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

  // builds the cart icon with a red circular badge showing the item count
  Widget _buildCartButton(BuildContext context) {
    // Listen to cartItemsNotifier so the badge updates instantly when items change
    return ValueListenableBuilder<List<CartItem>>(
      valueListenable: cartItemsNotifier,
      builder: (context, items, _) {
        // derive total quantity from the shared cart state every build
        final totalQuantity = items.fold<int>(0, (sum, item) => sum + item.quantity);

        // show badge only when there is at least one item (sum of quantities > 0)
        final showBadge = totalQuantity > 0;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_bag_outlined, size: 20, color: Colors.grey),
              padding: const EdgeInsets.all(12),
              constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
              onPressed: () => Navigator.pushNamed(context, '/cart'),
              tooltip: 'Open cart',
            ),

            if (showBadge)
              Positioned(
                right: -4,
                top: -4,
                child: Semantics(
                  label: 'Cart, $totalQuantity items',
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 2, offset: const Offset(0, 1))
                      ],
                    ),
                    constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                    child: Center(
                      child: Text(
                        // display the real totalQuantity, capped at 99+
                        totalQuantity > 99 ? '99+' : '$totalQuantity',
                        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  // Build profile button - shows avatar if logged in, login button otherwise
  Widget _buildProfileButton(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

    if (user != null) {
      // User is logged in - show avatar with dropdown menu
      return PopupMenuButton<String>(
        offset: const Offset(0, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 14,
            backgroundColor: const Color(0xFF4d2963),
            backgroundImage: user.photoUrl != null ? NetworkImage(user.photoUrl!) : null,
            child: user.photoUrl == null
                ? Text(
                    user.initials,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                : null,
          ),
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            enabled: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.displayName ?? 'User',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  user.email,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'account',
            child: Row(
              children: [
                Icon(Icons.person, size: 18),
                SizedBox(width: 12),
                Text('My Account'),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'orders',
            child: Row(
              children: [
                Icon(Icons.shopping_bag, size: 18),
                SizedBox(width: 12),
                Text('My Orders'),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'settings',
            child: Row(
              children: [
                Icon(Icons.settings, size: 18),
                SizedBox(width: 12),
                Text('Settings'),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'signout',
            child: Row(
              children: [
                Icon(Icons.logout, size: 18, color: Colors.red),
                SizedBox(width: 12),
                Text('Sign Out', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        ],
        onSelected: (value) async {
          switch (value) {
            case 'account':
              Navigator.pushNamed(context, '/account');
              break;
            case 'orders':
              Navigator.pushNamed(context, '/order-history');
              break;
            case 'settings':
              Navigator.pushNamed(context, '/profile-settings');
              break;
            case 'signout':
              await authService.signOut();
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              }
              break;
          }
        },
      );
    } else {
      // User not logged in - show login button
      return IconButton(
        icon: const Icon(Icons.person_outline, size: 18, color: Colors.grey),
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        onPressed: () => Navigator.pushNamed(context, '/login'),
      );
    }
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
          return shopMenuItems.map((item) {
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
      onPressed: () => Navigator.pushNamed(context, '/collections/clothing'),
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        textStyle: const TextStyle(fontSize: 16),
      ),
      child: const Text('Shop'),
    );
  }

  // Print Shack dropdown button
  Widget buildPrintShackButton(BuildContext context, bool isWideScreen) {
    if (isWideScreen) {
      return PopupMenuButton<ShopMenuItem>(
        offset: const Offset(0, kToolbarHeight),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'The Print Shack',
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
            debugPrint('Print Shack menu selected: ${item.label}');
          }
        },
        itemBuilder: (context) {
          return printShackMenuItems.map((item) {
            return PopupMenuItem<ShopMenuItem>(
              value: item,
              child: Text(item.label),
            );
          }).toList();
        },
      );
    }

    // Narrow screens: simple button
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, '/print-shack'),
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        textStyle: const TextStyle(fontSize: 16),
      ),
      child: const Text('The Print Shack'),
    );
  }

  // New: show a temporary mobile menu with navigation items
  void _openMobileMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(ctx);
                navigateToHome(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.storefront),
              title: const Text('Shop'),
              onTap: () {
                Navigator.pop(ctx);
                Navigator.pushNamed(context, '/collections/clothing');
              },
            ),
            ListTile(
              leading: const Icon(Icons.print),
              title: const Text('The Print Shack'),
              onTap: () {
                Navigator.pop(ctx);
                Navigator.pushNamed(context, '/print-shack');
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_offer),
              title: const Text('SALE'),
              onTap: () {
                Navigator.pop(ctx);
                Navigator.pushNamed(context, '/sale');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(ctx);
                navigateToAbout(context);
              },
            ),
          ],
        ),
      ),
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
                                buildPrintShackButton(context, isWide),
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
                              IconButton(
                                icon: const Icon(Icons.search, size: 18, color: Colors.grey),
                                padding: const EdgeInsets.all(8),
                                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                onPressed: () => Navigator.pushNamed(context, '/search'),
                              ),
                              _buildProfileButton(context),
                              _buildCartButton(context),
                              // removed desktop-only hamburger menu so it only appears on narrow screens
                            ]
                          : [
                              _buildCartButton(context),
                              IconButton(
                                icon: const Icon(Icons.menu, size: 18, color: Colors.grey),
                                padding: EdgeInsets.all(8),
                                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                onPressed: () => _openMobileMenu(context),
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
