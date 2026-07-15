import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// An icon container with gradient background and optional border.
///
/// This widget wraps an icon with a container that has a gradient background
/// derived from the icon color.
class AppGradientIconContainer extends StatelessWidget {
  const AppGradientIconContainer({
    required this.icon,
    this.color,
    this.gradientColors,
    this.size = 44.0,
    this.iconSize = 24.0,
    this.borderRadius,
    this.showBorder = false,
    this.borderOpacity = 0.3,
    this.gradientStartOpacity = 0.2,
    this.gradientEndOpacity = 0.1,
    super.key,
  });

  /// The icon to display
  final IconData icon;

  /// Base color for the gradient and icon
  final Color? color;

  /// Custom gradient colors (overrides color-based gradient)
  final List<Color>? gradientColors;

  /// Size of the container (both width and height)
  final double size;

  /// Size of the icon
  final double iconSize;

  /// Border radius of the container
  final double? borderRadius;

  /// Whether to show border
  final bool showBorder;

  /// Border opacity (only used when showBorder is true)
  final double borderOpacity;

  /// Start opacity for gradient
  final double gradientStartOpacity;

  /// End opacity for gradient
  final double gradientEndOpacity;

  @override
  Widget build(BuildContext context) {
    final baseColor = color ?? AppColors.primary;
    final radius = borderRadius ?? Dimens.radiusSm;

    final colors = gradientColors ??
        [
          baseColor.withAlpha((gradientStartOpacity * 255).round()),
          baseColor.withAlpha((gradientEndOpacity * 255).round()),
        ];

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radius),
        border: showBorder
            ? Border.all(
                color: baseColor.withAlpha((borderOpacity * 255).round()),
                width: 1,
              )
            : null,
      ),
      child: Icon(
        icon,
        color: baseColor,
        size: iconSize,
      ),
    );
  }
}

