import 'package:flutter/material.dart';

/// A reusable header widget for the Union Shop app.
///
/// Example:
/// ```dart
/// UnionHeader(
///   title: 'Union Shop',
///   subtitle: 'Fresh picks for you',
///   leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
///   actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
/// )
/// ```
class UnionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final List<Widget>? actions;
  final double height;

  const UnionHeader({
    Key? key,
    required this.title,
    this.subtitle,
    this.leading,
    this.actions,
    this.height = 88.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      bottom: false,
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        color: theme.scaffoldBackgroundColor,
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: 12),
            ],

            // Title and optional subtitle
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: theme.textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),

            // Actions
            if (actions != null) ...[
              const SizedBox(width: 8),
              Row(children: actions!),
            ],
          ],
        ),
      ),
    );
  }
}
