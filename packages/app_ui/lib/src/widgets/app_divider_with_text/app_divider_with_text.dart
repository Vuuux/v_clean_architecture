import 'package:flutter/material.dart';

/// A section divider with text in the middle.
///
/// This widget displays a horizontal line with optional text in the center.
class AppDividerWithText extends StatelessWidget {
  const AppDividerWithText({
    this.text,
    this.textStyle,
    this.dividerColor,
    this.thickness = 1.0,
    this.horizontalPadding = 16.0,
    super.key,
  });

  /// Text to display in the center
  final String? text;

  /// Text style
  final TextStyle? textStyle;

  /// Color of the divider lines
  final Color? dividerColor;

  /// Thickness of the divider lines
  final double thickness;

  /// Horizontal padding around the text
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = dividerColor ?? const Color(0xFF22262F);

    return Row(
      children: [
        Expanded(
          child: Container(
            height: thickness,
            color: color,
          ),
        ),
        if (text != null) ...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Text(
              text!,
              style: textStyle ??
                  theme.textTheme.labelMedium?.copyWith(
                    color: const Color(0xFF6B7280),
                  ),
            ),
          ),
          Expanded(
            child: Container(
              height: thickness,
              color: color,
            ),
          ),
        ],
      ],
    );
  }
}

