import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../theme/app_theme.dart';

/// A reusable category tile widget that displays an icon and label.
///
/// This widget is commonly used to display categories in a grid format.
class AppCategoryTile extends StatelessWidget {
  const AppCategoryTile({
    required this.icon,
    required this.label,
    this.onTap,
    this.iconColor,
    this.iconSize = 28.0,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.labelStyle,
    super.key,
  });

  /// The icon to display
  final IconData icon;

  /// The label text
  final String label;

  /// Callback when tile is tapped
  final VoidCallback? onTap;

  /// Color of the icon
  final Color? iconColor;

  /// Size of the icon
  final double iconSize;

  /// Background color of the tile
  final Color? backgroundColor;

  /// Border color of the tile
  final Color? borderColor;

  /// Border radius of the tile
  final double? borderRadius;

  /// Text style for the label
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = borderRadius ?? Dimens.radiusMd;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.bgLayerDark,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: borderColor ?? AppColors.divider,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor ?? AppColors.primary,
              size: iconSize,
            ),
            const Gap(Dimens.sm),
            Text(
              label,
              style: labelStyle ??
                  theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

