import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../theme/app_theme.dart';

/// A reusable list tile widget with icon, title, subtitle, and trailing arrow.
///
/// This widget is commonly used to display list items with action capability.
class AppListTile extends StatelessWidget {
  const AppListTile({
    required this.title,
    this.subtitle,
    this.leading,
    this.leadingIcon,
    this.leadingIconColor,
    this.leadingIconBackgroundColor,
    this.leadingIconSize = 28.0,
    this.leadingContainerSize = 56.0,
    this.trailing,
    this.showTrailingArrow = true,
    this.trailingArrowColor,
    this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.titleStyle,
    this.subtitleStyle,
    super.key,
  });

  /// The title text
  final String title;

  /// The subtitle text
  final String? subtitle;

  /// Custom leading widget (overrides leadingIcon if provided)
  final Widget? leading;

  /// The leading icon to display
  final IconData? leadingIcon;

  /// Color of the leading icon
  final Color? leadingIconColor;

  /// Background color of the leading icon container
  final Color? leadingIconBackgroundColor;

  /// Size of the leading icon
  final double leadingIconSize;

  /// Size of the leading icon container
  final double leadingContainerSize;

  /// Custom trailing widget
  final Widget? trailing;

  /// Whether to show trailing arrow
  final bool showTrailingArrow;

  /// Color of the trailing arrow
  final Color? trailingArrowColor;

  /// Callback when tile is tapped
  final VoidCallback? onTap;

  /// Background color of the tile
  final Color? backgroundColor;

  /// Border color of the tile
  final Color? borderColor;

  /// Border radius of the tile
  final double? borderRadius;

  /// Padding inside the tile
  final EdgeInsetsGeometry? padding;

  /// Text style for the title
  final TextStyle? titleStyle;

  /// Text style for the subtitle
  final TextStyle? subtitleStyle;

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
        padding: padding ?? const EdgeInsets.all(Dimens.md),
        child: Row(
          children: [
            if (leading != null)
              leading!
            else if (leadingIcon != null)
              _buildLeadingIcon(),
            if (leading != null || leadingIcon != null) const Gap(Dimens.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: titleStyle ??
                        theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimaryBlack,
                        ),
                  ),
                  if (subtitle != null) ...[
                    const Gap(Dimens.xs),
                    Text(
                      subtitle!,
                      style: subtitleStyle ??
                          theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.textTertiaryBlack,
                          ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null)
              trailing!
            else if (showTrailingArrow)
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: trailingArrowColor ?? AppColors.textTertiaryBlack,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeadingIcon() {
    final color = leadingIconColor ?? AppColors.primary;
    return Container(
      width: leadingContainerSize,
      height: leadingContainerSize,
      decoration: BoxDecoration(
        color: leadingIconBackgroundColor ?? color.withAlpha(30),
        borderRadius: BorderRadius.circular(Dimens.md),
      ),
      child: Icon(
        leadingIcon,
        color: color,
        size: leadingIconSize,
      ),
    );
  }
}

