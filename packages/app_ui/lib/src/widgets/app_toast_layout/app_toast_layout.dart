import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

const _kWrapperRadius = 12.0;
const _kWrapperShadow = [
  BoxShadow(
    color: Color(0x26000000),
    blurRadius: 2,
    spreadRadius: 1,
    offset: Offset(0, 1),
  ),
];

enum AppToastType { info, success, error }

class AppToastLayout extends StatelessWidget {
  const AppToastLayout({
    required this.type,
    required this.title,
    required this.description,
    this.titleStyle,
    this.icon,
    this.backgroundColor,
    this.onCloseTap,
    this.onTap,
    super.key,
  });

  final AppToastType type;
  final String title;
  final TextStyle? titleStyle;
  final String? description;
  final VoidCallback? onCloseTap;
  final VoidCallback? onTap;
  final Widget? icon;
  final Color? backgroundColor;

  Color get _backgroundColor {
    if (backgroundColor != null) {
      return backgroundColor!;
    }
    switch (type) {
      case AppToastType.info:
        return AppColors.bgDark;
      case AppToastType.success:
        return AppColors.primary[100]!;
      case AppToastType.error:
        return const Color(0xFFFDEDED);
    }
  }

  Color get _closeIconColor {
    switch (type) {
      case AppToastType.info:
        return AppColors.icDisabled;
      case AppToastType.success:
      case AppToastType.error:
        return AppColors.icPrimaryBlack;
    }
  }

  Color get _titleColor {
    switch (type) {
      case AppToastType.info:
        return AppColors.white;
      case AppToastType.success:
        return AppColors.textPrimaryBrand;
      case AppToastType.error:
        return AppColors.error;
    }
  }

  Color get _descriptionColor {
    switch (type) {
      case AppToastType.info:
        return AppColors.white;
      case AppToastType.success:
        return AppColors.textSecondaryBlack;
      case AppToastType.error:
        return AppColors.textPrimaryBlack;
    }
  }

  bool get _hasDescription => description != null && description!.isNotEmpty;

  void _handleOnTap() {
    onTap?.call();
    onCloseTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    Widget? iconWidget;
    switch (type) {
      case AppToastType.info:
        iconWidget = icon;
      case AppToastType.success:
        iconWidget = const Icon(
          Icons.check_circle_rounded,
          color: AppColors.btnPrimary,
        );
      case AppToastType.error:
        iconWidget = const Icon(Icons.error_rounded, color: AppColors.error);
    }

    final closeIcon = ScaleGestureDetector(
      onTap: onCloseTap,
      child: Icon(
        Icons.close_rounded,
        color: _closeIconColor,
        size: Dimens.iconMd,
      ),
    );
    return GestureDetector(
      onTap: _handleOnTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: Dimens.xs),
        padding: const EdgeInsets.only(
          top: Dimens.xs,
          bottom: Dimens.xs,
          left: Dimens.md,
          right: Dimens.xxs,
        ),
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(_kWrapperRadius),
          boxShadow: _kWrapperShadow,
        ),
        child: Row(
          crossAxisAlignment: _hasDescription
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          spacing: Dimens.xs,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: Dimens.xxs),
              child: iconWidget,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:
                        titleStyle ??
                        Theme.of(
                          context,
                        ).textTheme.h6.semibold.copyWith(color: _titleColor),
                  ),
                  if (_hasDescription)
                    Text(
                      description!,
                      style: Theme.of(
                        context,
                      ).textTheme.remark.copyWith(color: _descriptionColor),
                    ),
                ],
              ),
            ),
            closeIcon,
          ],
        ),
      ),
    );
  }
}
