import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../theme/app_theme.dart';

/// A section header with title and optional action button.
///
/// This widget is commonly used for section titles with "See All" or similar actions.
class AppSectionHeader extends StatelessWidget {
  const AppSectionHeader({
    required this.title,
    this.action,
    this.titleStyle,
    this.padding,
    super.key,
  });

  /// The title text
  final String title;

  /// Optional action widget (e.g., "See All" button)
  final Widget? action;

  /// Text style for the title
  final TextStyle? titleStyle;

  /// Padding around the header
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: titleStyle ??
                theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
          ),
          if (action != null) action!,
        ],
      ),
    );
  }
}

/// A section container with title, optional action, and content.
///
/// This widget wraps content with a section header.
class AppSection extends StatelessWidget {
  const AppSection({
    required this.title,
    required this.child,
    this.action,
    this.titleStyle,
    this.spacing = Dimens.md,
    this.padding,
    super.key,
  });

  /// The title text
  final String title;

  /// The content widget
  final Widget child;

  /// Optional action widget
  final Widget? action;

  /// Text style for the title
  final TextStyle? titleStyle;

  /// Spacing between header and content
  final double spacing;

  /// Padding around the section
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSectionHeader(
            title: title,
            action: action,
            titleStyle: titleStyle,
          ),
          Gap(spacing),
          child,
        ],
      ),
    );
  }
}

