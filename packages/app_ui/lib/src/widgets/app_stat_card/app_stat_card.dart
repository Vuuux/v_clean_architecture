import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../theme/app_theme.dart';

/// A reusable stat card widget that displays an icon, value, and title.
///
/// This widget is commonly used to display statistics or metrics
/// in a compact card format.
class AppStatCard extends StatelessWidget {
  const AppStatCard({
    required this.icon,
    required this.title,
    required this.value,
    this.iconColor,
    this.iconSize = 24.0,
    this.iconContainerSize = 44.0,
    this.backgroundColor,
    this.borderColor,
    this.padding,
    this.borderRadius,
    this.valueStyle,
    this.titleStyle,
    this.onTap,
    super.key,
  });

  /// The icon to display
  final IconData icon;

  /// The title/label text
  final String title;

  /// The value to display
  final String value;

  /// Color of the icon and its background
  final Color? iconColor;

  /// Size of the icon
  final double iconSize;

  /// Size of the icon container
  final double iconContainerSize;

  /// Background color of the card
  final Color? backgroundColor;

  /// Border color of the card
  final Color? borderColor;

  /// Padding inside the card
  final EdgeInsetsGeometry? padding;

  /// Border radius of the card
  final double? borderRadius;

  /// Text style for the value
  final TextStyle? valueStyle;

  /// Text style for the title
  final TextStyle? titleStyle;

  /// Callback when card is tapped
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = iconColor ?? AppColors.primary;
    final radius = borderRadius ?? Dimens.radiusMd;

    final card = Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.bgLayerDark,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: borderColor ?? AppColors.divider,
          width: 1,
        ),
      ),
      padding: padding ?? const EdgeInsets.all(Dimens.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIconContainer(color),
          const Gap(Dimens.md),
          Text(
            value,
            style: valueStyle ??
                theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const Gap(Dimens.xs),
          Text(
            title,
            style: titleStyle ??
                theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.textTertiaryBlack,
                ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: card,
      );
    }

    return card;
  }

  Widget _buildIconContainer(Color color) {
    return Container(
      width: iconContainerSize,
      height: iconContainerSize,
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(Dimens.sm),
      ),
      child: Icon(
        icon,
        color: color,
        size: iconSize,
      ),
    );
  }
}

