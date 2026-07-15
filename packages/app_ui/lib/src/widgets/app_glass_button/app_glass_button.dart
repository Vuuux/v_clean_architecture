import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// A glass/frosted style button commonly used on gradient backgrounds.
class AppGlassButton extends StatelessWidget {
  const AppGlassButton({
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.textStyle,
    this.padding,
    this.borderRadius,
    this.icon,
    this.iconSize = 16.0,
    super.key,
  });

  /// Button label text
  final String label;

  /// Callback when button is pressed
  final VoidCallback onPressed;

  /// Background color (default: white with 15% opacity)
  final Color? backgroundColor;

  /// Border color (default: white with 30% opacity)
  final Color? borderColor;

  /// Text color
  final Color? textColor;

  /// Text style
  final TextStyle? textStyle;

  /// Padding inside the button
  final EdgeInsetsGeometry? padding;

  /// Border radius
  final double? borderRadius;

  /// Optional leading icon
  final IconData? icon;

  /// Icon size
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = borderRadius ?? Dimens.radiusSm;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: Dimens.lg,
                vertical: Dimens.sm,
              ),
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white.withAlpha(38),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: borderColor ?? Colors.white.withAlpha(76),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: textColor ?? Colors.white,
                  size: iconSize,
                ),
                const SizedBox(width: Dimens.xs),
              ],
              Text(
                label,
                style: textStyle ??
                    theme.textTheme.bodySmall?.copyWith(
                      color: textColor ?? Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

