import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../theme/app_theme.dart';

/// An activity card displaying icon, title, subtitle, time, and status indicator.
///
/// This widget is commonly used for activity feeds, notifications, and history items.
class AppActivityCard extends StatelessWidget {
  const AppActivityCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.time,
    this.color,
    this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.iconSize = 24.0,
    this.iconContainerSize = 48.0,
    this.showStatusIndicator = true,
    this.titleStyle,
    this.subtitleStyle,
    this.timeStyle,
    super.key,
  });

  /// The icon to display
  final IconData icon;

  /// The title text
  final String title;

  /// The subtitle text
  final String subtitle;

  /// The time text (e.g., "2 hours ago")
  final String? time;

  /// Accent color for icon and status indicator
  final Color? color;

  /// Callback when card is tapped
  final VoidCallback? onTap;

  /// Background color of the card
  final Color? backgroundColor;

  /// Border color of the card
  final Color? borderColor;

  /// Border radius of the card
  final double? borderRadius;

  /// Padding inside the card
  final EdgeInsetsGeometry? padding;

  /// Size of the icon
  final double iconSize;

  /// Size of the icon container
  final double iconContainerSize;

  /// Whether to show status indicator dot
  final bool showStatusIndicator;

  /// Text style for the title
  final TextStyle? titleStyle;

  /// Text style for the subtitle
  final TextStyle? subtitleStyle;

  /// Text style for the time
  final TextStyle? timeStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColor = color ?? AppColors.primary;
    final radius = borderRadius ?? Dimens.radiusMd;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? const Color(0xFF161A21),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: borderColor ?? const Color(0xFF22262F),
              width: 1,
            ),
          ),
          padding: padding ?? const EdgeInsets.all(Dimens.md),
          child: Row(
            children: [
              _buildIconContainer(accentColor),
              const Gap(Dimens.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: titleStyle ??
                          theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                    ),
                    const Gap(Dimens.xxs),
                    Text(
                      subtitle,
                      style: subtitleStyle ??
                          theme.textTheme.labelMedium?.copyWith(
                            color: const Color(0xFFA9ABB3),
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (time != null || showStatusIndicator) ...[
                const Gap(Dimens.sm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (time != null)
                      Text(
                        time!,
                        style: timeStyle ??
                            theme.textTheme.labelMedium?.copyWith(
                              color: const Color(0xFF6B7280),
                              fontSize: 11,
                            ),
                      ),
                    if (showStatusIndicator) ...[
                      const Gap(Dimens.xs),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: accentColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconContainer(Color accentColor) {
    return Container(
      width: iconContainerSize,
      height: iconContainerSize,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            accentColor.withAlpha(51),
            accentColor.withAlpha(25),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(Dimens.radiusSm),
        border: Border.all(
          color: accentColor.withAlpha(76),
          width: 1,
        ),
      ),
      child: Icon(
        icon,
        color: accentColor,
        size: iconSize,
      ),
    );
  }
}

