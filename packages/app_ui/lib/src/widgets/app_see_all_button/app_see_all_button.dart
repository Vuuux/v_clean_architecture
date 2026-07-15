import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../theme/app_theme.dart';

/// A "See All" button with trailing arrow icon.
///
/// This widget is commonly used for section headers to navigate to full lists.
class AppSeeAllButton extends StatelessWidget {
  const AppSeeAllButton({
    required this.onPressed,
    this.label = 'See All',
    this.textColor,
    this.iconColor,
    this.textStyle,
    this.iconSize = 12.0,
    this.padding,
    super.key,
  });

  /// Callback when button is pressed
  final VoidCallback onPressed;

  /// Button label text
  final String label;

  /// Text color
  final Color? textColor;

  /// Icon color
  final Color? iconColor;

  /// Text style
  final TextStyle? textStyle;

  /// Icon size
  final double iconSize;

  /// Padding around the button
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = textColor ?? const Color(0xFF00EEFC);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(Dimens.radiusSm),
        child: Padding(
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: Dimens.sm,
                vertical: Dimens.xs,
              ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: textStyle ??
                    theme.textTheme.labelMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const Gap(Dimens.xxs),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: iconSize,
                color: iconColor ?? color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

