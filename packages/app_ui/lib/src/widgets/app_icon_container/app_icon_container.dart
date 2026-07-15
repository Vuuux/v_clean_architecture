import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// A reusable container for icons with a colored background.
///
/// This widget wraps an icon with a container that has a background color
/// derived from the icon color with reduced opacity.
class AppIconContainer extends StatelessWidget {
  const AppIconContainer({
    required this.icon,
    this.iconColor,
    this.backgroundColor,
    this.backgroundOpacity = 0.12,
    this.size = 44.0,
    this.iconSize = 24.0,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
    super.key,
  });

  /// The icon to display
  final IconData icon;

  /// Color of the icon
  final Color? iconColor;

  /// Background color of the container
  /// If not provided, uses iconColor with backgroundOpacity
  final Color? backgroundColor;

  /// Opacity of the background when using iconColor
  final double backgroundOpacity;

  /// Size of the container (both width and height)
  final double size;

  /// Size of the icon
  final double iconSize;

  /// Border radius of the container (only for rectangle shape)
  final double? borderRadius;

  /// Shape of the container
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    final color = iconColor ?? AppColors.primary;
    final bgColor = backgroundColor ??
        color.withAlpha((backgroundOpacity * 255).round());
    final radius = borderRadius ?? Dimens.sm;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor,
        shape: shape,
        borderRadius: shape == BoxShape.circle
            ? null
            : BorderRadius.circular(radius),
      ),
      child: Icon(
        icon,
        color: color,
        size: iconSize,
      ),
    );
  }
}

