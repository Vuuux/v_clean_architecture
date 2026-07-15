import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// A styled text field for dark themed apps.
///
/// This widget provides a consistent styled text field with customizable
/// options for icons, labels, and appearance.
class AppDarkTextField extends StatelessWidget {
  const AppDarkTextField({
    required this.controller,
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.textInputAction,
    this.onSubmitted,
    this.onChanged,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.contentPadding,
    this.hintColor,
    this.textColor,
    this.iconColor,
    this.iconSize = 22.0,
    this.keyboardType,
    this.enabled = true,
    this.maxLines = 1,
    super.key,
  });

  /// Text editing controller
  final TextEditingController controller;

  /// Hint/label text
  final String label;

  /// Prefix icon
  final IconData? prefixIcon;

  /// Suffix widget
  final Widget? suffixIcon;

  /// Whether the text is obscured (for passwords)
  final bool obscureText;

  /// Text input action
  final TextInputAction? textInputAction;

  /// Callback when form is submitted
  final ValueChanged<String>? onSubmitted;

  /// Callback when text changes
  final ValueChanged<String>? onChanged;

  /// Background color
  final Color? backgroundColor;

  /// Border color
  final Color? borderColor;

  /// Border radius
  final double? borderRadius;

  /// Content padding
  final EdgeInsetsGeometry? contentPadding;

  /// Hint text color
  final Color? hintColor;

  /// Text color
  final Color? textColor;

  /// Icon color
  final Color? iconColor;

  /// Icon size
  final double iconSize;

  /// Keyboard type
  final TextInputType? keyboardType;

  /// Whether the text field is enabled
  final bool enabled;

  /// Maximum lines
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = borderRadius ?? Dimens.radiusMd;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFF161A21),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: borderColor ?? const Color(0xFF22262F),
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        textInputAction: textInputAction,
        onSubmitted: onSubmitted,
        onChanged: onChanged,
        keyboardType: keyboardType,
        enabled: enabled,
        maxLines: maxLines,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: textColor ?? Colors.white,
        ),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            color: hintColor ?? const Color(0xFF6B7280),
          ),
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: iconColor ?? const Color(0xFF6B7280),
                  size: iconSize,
                )
              : null,
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(
                horizontal: Dimens.md,
                vertical: Dimens.md,
              ),
        ),
      ),
    );
  }
}

