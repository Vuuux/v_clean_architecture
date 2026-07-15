import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class AnimatedFloatingLabel extends StatelessWidget {
  const AnimatedFloatingLabel({
    required this.shouldFloat,
    required this.labelText,
    super.key,
    this.animationDuration = const Duration(milliseconds: 200),
    this.labelColor,
    this.labelStyle,
    this.bottomPadding,
  });

  final bool shouldFloat;
  final String labelText;
  final Duration animationDuration;
  final Color? labelColor;
  final TextStyle? labelStyle;
  final double? bottomPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultLabelStyle =
        theme.textTheme.bodySmall?.copyWith(
          color: labelColor ?? AppColors.textSecondaryBlack,
          fontWeight: FontWeight.w500,
        ) ??
        const TextStyle();

    return AnimatedSize(
      duration: animationDuration,
      curve: Curves.easeOutQuart,
      child: shouldFloat
          ? AnimatedOpacity(
              duration: animationDuration,
              opacity: 1,
              curve: Curves.easeOutQuart,
              child: AnimatedSlide(
                duration: animationDuration,
                offset: Offset.zero,
                curve: Curves.easeOutQuart,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: bottomPadding ?? Dimens.xs),
                  child: AnimatedDefaultTextStyle(
                    duration: animationDuration,
                    curve: Curves.easeOutQuart,
                    style: labelStyle ?? defaultLabelStyle,
                    child: Text(labelText),
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
