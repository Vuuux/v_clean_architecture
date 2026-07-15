import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../theme/app_theme.dart';

/// A product card displaying image placeholder, title, price, and rating.
///
/// This widget is commonly used for e-commerce product listings.
class AppProductCard extends StatelessWidget {
  const AppProductCard({
    required this.title,
    required this.price,
    this.rating,
    this.reviews,
    this.icon,
    this.color,
    this.onTap,
    this.onActionTap,
    this.actionIcon = Icons.add_rounded,
    this.showActionButton = true,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.imageSize = 72.0,
    this.actionButtonSize = 40.0,
    this.titleStyle,
    this.priceStyle,
    this.ratingStyle,
    this.reviewsStyle,
    super.key,
  });

  /// The title text
  final String title;

  /// The price text
  final String price;

  /// Rating value (optional)
  final String? rating;

  /// Number of reviews (optional)
  final String? reviews;

  /// Icon to display as placeholder (optional)
  final IconData? icon;

  /// Accent color
  final Color? color;

  /// Callback when card is tapped
  final VoidCallback? onTap;

  /// Callback when action button is tapped
  final VoidCallback? onActionTap;

  /// Action button icon
  final IconData actionIcon;

  /// Whether to show action button
  final bool showActionButton;

  /// Background color
  final Color? backgroundColor;

  /// Border color
  final Color? borderColor;

  /// Border radius
  final double? borderRadius;

  /// Padding inside the card
  final EdgeInsetsGeometry? padding;

  /// Size of the image placeholder
  final double imageSize;

  /// Size of the action button
  final double actionButtonSize;

  /// Text style for the title
  final TextStyle? titleStyle;

  /// Text style for the price
  final TextStyle? priceStyle;

  /// Text style for the rating
  final TextStyle? ratingStyle;

  /// Text style for the reviews
  final TextStyle? reviewsStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColor = color ?? const Color(0xFF00EEFC);
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
              _buildImagePlaceholder(accentColor),
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
                    if (rating != null || reviews != null) ...[
                      const Gap(Dimens.xs),
                      Row(
                        children: [
                          if (rating != null) ...[
                            const Icon(
                              Icons.star_rounded,
                              size: 16,
                              color: Color(0xFFFFC107),
                            ),
                            const Gap(Dimens.xxs),
                            Text(
                              rating!,
                              style: ratingStyle ??
                                  theme.textTheme.labelMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                          if (reviews != null) ...[
                            const Gap(Dimens.xs),
                            Text(
                              '($reviews reviews)',
                              style: reviewsStyle ??
                                  theme.textTheme.labelMedium?.copyWith(
                                    color: const Color(0xFF6B7280),
                                  ),
                            ),
                          ],
                        ],
                      ),
                    ],
                    const Gap(Dimens.xs),
                    Text(
                      price,
                      style: priceStyle ??
                          theme.textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF00EEFC),
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
              if (showActionButton) _buildActionButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder(Color accentColor) {
    return Container(
      width: imageSize,
      height: imageSize,
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
        icon ?? Icons.shopping_bag_rounded,
        color: accentColor,
        size: 32,
      ),
    );
  }

  Widget _buildActionButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onActionTap,
        borderRadius: BorderRadius.circular(Dimens.radiusSm),
        child: Container(
          width: actionButtonSize,
          height: actionButtonSize,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF85ADFF), Color(0xFF00EEFC)],
            ),
            borderRadius: BorderRadius.circular(Dimens.radiusSm),
          ),
          child: Icon(
            actionIcon,
            color: Colors.white,
            size: 22,
          ),
        ),
      ),
    );
  }
}

