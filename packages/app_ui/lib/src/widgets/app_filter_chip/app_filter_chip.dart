import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// A filter chip with gradient background when selected.
///
/// This widget is commonly used for filter tabs/chips in lists.
class AppFilterChip extends StatelessWidget {
  const AppFilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.selectedGradientColors,
    this.unselectedBackgroundColor,
    this.unselectedBorderColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.padding,
    this.borderRadius,
    this.textStyle,
    this.animationDuration = const Duration(milliseconds: 200),
    super.key,
  });

  /// The label text
  final String label;

  /// Whether the chip is selected
  final bool isSelected;

  /// Callback when chip is tapped
  final VoidCallback onTap;

  /// Gradient colors when selected
  final List<Color>? selectedGradientColors;

  /// Background color when not selected
  final Color? unselectedBackgroundColor;

  /// Border color when not selected
  final Color? unselectedBorderColor;

  /// Text color when selected
  final Color? selectedTextColor;

  /// Text color when not selected
  final Color? unselectedTextColor;

  /// Padding inside the chip
  final EdgeInsetsGeometry? padding;

  /// Border radius
  final double? borderRadius;

  /// Text style
  final TextStyle? textStyle;

  /// Animation duration
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = borderRadius ?? Dimens.radiusRounded;
    final gradientColors = selectedGradientColors ??
        const [Color(0xFF85ADFF), Color(0xFF00EEFC)];

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: AnimatedContainer(
          duration: animationDuration,
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: Dimens.md,
                vertical: Dimens.sm,
              ),
          decoration: BoxDecoration(
            gradient: isSelected ? LinearGradient(colors: gradientColors) : null,
            color: isSelected
                ? null
                : unselectedBackgroundColor ?? const Color(0xFF161A21),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: isSelected
                  ? Colors.transparent
                  : unselectedBorderColor ?? const Color(0xFF22262F),
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: textStyle ??
                theme.textTheme.labelMedium?.copyWith(
                  color: isSelected
                      ? selectedTextColor ?? Colors.white
                      : unselectedTextColor ?? const Color(0xFFA9ABB3),
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
    );
  }
}

