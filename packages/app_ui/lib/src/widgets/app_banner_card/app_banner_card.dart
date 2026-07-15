import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../theme/app_theme.dart';

/// A reusable banner card widget with gradient background.
///
/// This widget is commonly used for promotional banners, offers, or featured content.
class AppBannerCard extends StatelessWidget {
  const AppBannerCard({
    this.title,
    this.subtitle,
    this.description,
    this.action,
    this.trailing,
    this.trailingIcon,
    this.trailingIconColor,
    this.gradientColors,
    this.gradientBegin = Alignment.topLeft,
    this.gradientEnd = Alignment.bottomRight,
    this.borderRadius,
    this.padding,
    this.boxShadow,
    this.titleStyle,
    this.subtitleStyle,
    this.descriptionStyle,
    super.key,
  });

  /// The main title text
  final String? title;

  /// The subtitle text (displayed above title)
  final String? subtitle;

  /// The description text (displayed below title)
  final String? description;

  /// Action widget (typically a button)
  final Widget? action;

  /// Custom trailing widget
  final Widget? trailing;

  /// Trailing icon (used if trailing widget is not provided)
  final IconData? trailingIcon;

  /// Color of the trailing icon
  final Color? trailingIconColor;

  /// Gradient colors for the background
  final List<Color>? gradientColors;

  /// Gradient begin alignment
  final AlignmentGeometry gradientBegin;

  /// Gradient end alignment
  final AlignmentGeometry gradientEnd;

  /// Border radius
  final double? borderRadius;

  /// Padding inside the card
  final EdgeInsetsGeometry? padding;

  /// Box shadow for the card
  final List<BoxShadow>? boxShadow;

  /// Text style for the title
  final TextStyle? titleStyle;

  /// Text style for the subtitle
  final TextStyle? subtitleStyle;

  /// Text style for the description
  final TextStyle? descriptionStyle;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? Dimens.md;
    final colors = gradientColors ??
        [
          AppColors.primary.withAlpha(200),
          AppColors.primary.withAlpha(100),
        ];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          colors: colors,
          begin: gradientBegin,
          end: gradientEnd,
        ),
        boxShadow: boxShadow ??
            [
              BoxShadow(
                color: AppColors.primary.withAlpha(50),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
      ),
      padding: padding ?? const EdgeInsets.all(Dimens.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: subtitleStyle ??
                            const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                      ),
                    if (subtitle != null) const Gap(Dimens.xs),
                    if (title != null)
                      Text(
                        title!,
                        style: titleStyle ??
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                      ),
                    if (title != null && description != null)
                      const Gap(Dimens.sm),
                    if (description != null)
                      Text(
                        description!,
                        style: descriptionStyle ??
                            const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                      ),
                  ],
                ),
              ),
              if (trailing != null)
                trailing!
              else if (trailingIcon != null)
                _buildTrailingIcon(),
            ],
          ),
          if (action != null) ...[
            const Gap(Dimens.md),
            action!,
          ],
        ],
      ),
    );
  }

  Widget _buildTrailingIcon() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(200),
        borderRadius: BorderRadius.circular(Dimens.md),
      ),
      child: Icon(
        trailingIcon,
        color: trailingIconColor ?? AppColors.primary,
        size: 32,
      ),
    );
  }
}

