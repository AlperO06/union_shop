import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Reusable bottom footer used across pages.
/// If [onLinkPressed] is provided it will be called with the label of the
/// clicked link. Otherwise the fallback behavior opens the shop site for
/// "Shipping" and logs other link clicks.
class BottomUnionFooter extends StatelessWidget {
  final void Function(String label)? onLinkPressed;

  const BottomUnionFooter({Key? key, this.onLinkPressed}) : super(key: key);

  Future<void> _defaultHandler(String label) async {
    if (label == 'Shipping') {
      final uri = Uri.parse('https://shop.upsu.net');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('Could not launch $uri');
      }
    } else {
      debugPrint('Footer link pressed: $label');
    }
  }

  @override
  Widget build(BuildContext context) {
    const headingStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
    );
    const linkStyle = TextStyle(
      color: Colors.blue,
      fontSize: 14,
      height: 1.3,
    );

    Widget linkColumn(String title, List<String> links) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: headingStyle),
          const SizedBox(height: 8),
          for (var i = 0; i < links.length; i++) ...[
            TextButton(
              onPressed: () async {
                final handler = onLinkPressed ?? _defaultHandler;
                await handler(links[i]);
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                alignment: Alignment.centerLeft,
              ),
              child: Text(links[i], style: linkStyle),
            ),
            if (i != links.length - 1) const SizedBox(height: 6),
          ],
        ],
      );
    }

    return Container(
      width: double.infinity,
      color: Colors.grey[50],
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: LayoutBuilder(builder: (context, inner) {
          final isNarrow = inner.maxWidth < 800;

          const branding = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Union Shop',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Official merchandise, campus essentials and local gifts — supporting local makers and student ventures.',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ],
          );

          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                branding,
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 12),
                Wrap(
                  runSpacing: 12,
                  children: [
                    SizedBox(
                      width: inner.maxWidth,
                      child: linkColumn('Help', ['Shipping', 'Returns', 'Contact Us']),
                    ),
                    SizedBox(
                      width: inner.maxWidth,
                      child: linkColumn('Company', ['About Us', 'Careers', 'Press']),
                    ),
                    SizedBox(
                      width: inner.maxWidth,
                      child: linkColumn('Legal', ['Terms & Conditions', 'Privacy Policy', 'Cookies']),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Center(
                  child: Text(
                    '© 2025 Union Shop — All rights reserved',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                ),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(flex: 2, child: branding),
                  const SizedBox(width: 32),
                  Expanded(
                    flex: 4,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: linkColumn('Help', ['Shipping', 'Returns', 'Contact Us'])),
                        const SizedBox(width: 24),
                        Expanded(child: linkColumn('Company', ['About Us', 'Careers', 'Press'])),
                        const SizedBox(width: 24),
                        Expanded(child: linkColumn('Legal', ['Terms & Conditions', 'Privacy Policy', 'Cookies'])),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  '© 2025 Union Shop — All rights reserved',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
