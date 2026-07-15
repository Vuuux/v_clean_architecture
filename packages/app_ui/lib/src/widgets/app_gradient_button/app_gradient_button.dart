import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// A gradient button commonly used for primary actions.
///
/// This widget provides a button with a gradient background and
/// optional loading state.
class AppGradientButton extends StatelessWidget {
  const AppGradientButton({
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.gradientColors,
    this.shadowColor,
    this.borderRadius,
    this.height,
    this.width,
    this.padding,
    this.textStyle,
    this.loadingWidget,
    this.loadingSize = 24.0,
    this.enabled = true,
    super.key,
  });

  /// Button label text
  final String label;

  /// Callback when button is pressed
  final VoidCallback? onPressed;

  /// Whether the button is in loading state
  final bool isLoading;

  /// Gradient colors for the background
  final List<Color>? gradientColors;

  /// Shadow color for the button
  final Color? shadowColor;

  /// Border radius of the button
  final double? borderRadius;

  /// Height of the button
  final double? height;

  /// Width of the button
  final double? width;

  /// Padding inside the button
  final EdgeInsetsGeometry? padding;

  /// Text style for the label
  final TextStyle? textStyle;

  /// Custom loading widget
  final Widget? loadingWidget;

  /// Size of the default loading indicator
  final double loadingSize;

  /// Whether the button is enabled
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = borderRadius ?? Dimens.radiusMd;
    final colors = gradientColors ??
        const [Color(0xFF85ADFF), Color(0xFF00EEFC)];
    final shadow = shadowColor ?? const Color(0xFF85ADFF).withAlpha(76);

    final isDisabled = !enabled || isLoading;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isDisabled ? null : onPressed,
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          width: width ?? double.infinity,
          height: height,
          padding: padding ??
              const EdgeInsets.symmetric(vertical: Dimens.md),
          decoration: BoxDecoration(
            gradient: isDisabled
                ? LinearGradient(
                    colors: colors.map((c) => c.withAlpha(128)).toList(),
                  )
                : LinearGradient(colors: colors),
            borderRadius: BorderRadius.circular(radius),
            boxShadow: isDisabled
                ? null
                : [
                    BoxShadow(
                      color: shadow,
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: Center(
            child: isLoading
                ? loadingWidget ??
                    SizedBox(
                      width: loadingSize,
                      height: loadingSize,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                : Text(
                    label,
                    style: textStyle ??
                        theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
          ),
        ),
      ),
    );
  }
}

