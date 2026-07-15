import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/app_theme.dart';
import '../scale_gesture_detector/scale_gesture_detector.dart';

const _kDefaultButtonSize = 56.0;

/// A reusable social login button widget.
///
/// This widget displays a circular button with an SVG icon inside,
/// commonly used for social login options (Google, Apple, Line, etc.)
class AppSocialButton extends StatelessWidget {
  const AppSocialButton({
    required this.iconPath,
    required this.onPressed,
    this.size = _kDefaultButtonSize,
    this.borderColor,
    this.backgroundColor,
    this.borderWidth = 2.0,
    this.padding,
    super.key,
  });

  /// Path to the SVG icon asset
  final String iconPath;

  /// Callback when button is pressed
  final VoidCallback onPressed;

  /// Size of the button (both width and height)
  final double size;

  /// Border color of the button
  final Color? borderColor;

  /// Background color of the button
  final Color? backgroundColor;

  /// Border width
  final double borderWidth;

  /// Padding inside the button
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ScaleGestureDetector(
      onTap: onPressed,
      child: Container(
        height: size,
        width: size,
        padding: padding ?? const EdgeInsets.all(Dimens.sm),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(size / 2),
          border: Border.all(
            color: borderColor ?? AppColors.enabledBorderColor,
            width: borderWidth,
          ),
        ),
        child: SvgPicture.asset(
          iconPath,
        ),
      ),
    );
  }
}

/// A square variant of the social button
class AppSocialButtonSquare extends StatelessWidget {
  const AppSocialButtonSquare({
    required this.iconPath,
    required this.onPressed,
    this.size = 60.0,
    this.iconSize = 28.0,
    this.borderRadius,
    this.borderColor,
    this.backgroundColor,
    super.key,
  });

  /// Path to the SVG icon asset
  final String iconPath;

  /// Callback when button is pressed
  final VoidCallback onPressed;

  /// Size of the button (both width and height)
  final double size;

  /// Size of the icon inside the button
  final double iconSize;

  /// Border radius of the button
  final double? borderRadius;

  /// Border color of the button
  final Color? borderColor;

  /// Background color of the button
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? Dimens.radiusMd;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: backgroundColor ?? const Color(0xFF161A21),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: borderColor ?? const Color(0xFF22262F),
              width: 1,
            ),
          ),
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              width: iconSize,
              height: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}

