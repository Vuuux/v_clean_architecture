import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../theme/app_theme.dart';

/// A trending card with gradient background.
///
/// This widget is commonly used for displaying trending items in horizontal lists.
class AppTrendingCard extends StatelessWidget {
  const AppTrendingCard({
    required this.title,
    this.subtitle,
    this.icon,
    this.color,
    this.width = 140.0,
    this.height,
    this.borderRadius,
    this.padding,
    this.onTap,
    this.gradientStartOpacity = 0.3,
    this.gradientEndOpacity = 0.1,
    this.showGlow = false,
    this.glowIntensity = 0.2,
    this.titleStyle,
    this.subtitleStyle,
    super.key,
  });

  /// The title text
  final String title;

  /// The subtitle text
  final String? subtitle;

  /// Optional icon
  final IconData? icon;

  /// Accent color for gradient
  final Color? color;

  /// Width of the card
  final double width;

  /// Height of the card (optional)
  final double? height;

  /// Border radius
  final double? borderRadius;

  /// Padding inside the card
  final EdgeInsetsGeometry? padding;

  /// Callback when tapped
  final VoidCallback? onTap;

  /// Start opacity for gradient
  final double gradientStartOpacity;

  /// End opacity for gradient
  final double gradientEndOpacity;

  /// Whether to show glow effect
  final bool showGlow;

  /// Glow intensity
  final double glowIntensity;

  /// Text style for the title
  final TextStyle? titleStyle;

  /// Text style for the subtitle
  final TextStyle? subtitleStyle;

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
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                accentColor.withAlpha((gradientStartOpacity * 255).round()),
                accentColor.withAlpha((gradientEndOpacity * 255).round()),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: accentColor.withAlpha(76),
              width: 1,
            ),
            boxShadow: showGlow
                ? [
                    BoxShadow(
                      color: accentColor.withAlpha((glowIntensity * 255).round()),
                      blurRadius: 16,
                      spreadRadius: 0,
                    ),
                  ]
                : null,
          ),
          padding: padding ?? const EdgeInsets.all(Dimens.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (icon != null)
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(38),
                    borderRadius: BorderRadius.circular(Dimens.radiusSm),
                  ),
                  child: Icon(
                    icon,
                    color: accentColor,
                    size: 22,
                  ),
                ),
              if (icon != null) const Spacer(),
              Text(
                title,
                style: titleStyle ??
                    theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              if (subtitle != null) ...[
                const Gap(Dimens.xxs),
                Text(
                  subtitle!,
                  style: subtitleStyle ??
                      theme.textTheme.labelMedium?.copyWith(
                        color: Colors.white70,
                      ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

