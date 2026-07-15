part of 'app_button.dart';

const _kDefaultBorderRadius = 16.0;

class AppButtonStyle {
  AppButtonStyle({
    this.backgroundColor,
    this.underlyingColor,
    this.borderColor,
    this.titleColor,
    this.disabledColor,
    this.disabledBorderColor,
    this.disabledTitleColor,
    this.padding,
    this.blurEnabled = false,
    this.blurValue = 8,
    this.boxShape = BoxShape.rectangle,
    BorderRadius? borderRadius = const BorderRadius.all(
      Radius.circular(_kDefaultBorderRadius),
    ),
  }) : borderRadius = boxShape == BoxShape.circle ? null : borderRadius;

  factory AppButtonStyle.icon() {
    return AppButtonStyle(
      backgroundColor: AppColors.btnSecondary,
      disabledColor: AppColors.btnDisabled,
      padding: const EdgeInsets.all(10),
    );
  }

  factory AppButtonStyle.filled() {
    return AppButtonStyle(
      backgroundColor: AppColors.btnPrimary,
      disabledColor: AppColors.btnDisabled,
      titleColor: AppColors.primary[700],
      disabledTitleColor: AppColors.white,
    );
  }

  factory AppButtonStyle.outlined() {
    return AppButtonStyle(
      backgroundColor: AppColors.bgLightGrey,
      disabledColor: AppColors.bgLightGrey,
      borderColor: AppColors.btnSecondaryOutlinedBorder,
      disabledBorderColor: AppColors.btnDisabled,
      titleColor: AppColors.textPrimaryBrand,
      disabledTitleColor: AppColors.btnDisabled,
    );
  }

  factory AppButtonStyle.glassed() {
    return AppButtonStyle(
      backgroundColor: AppColors.btnPrimary,
      underlyingColor: const Color(0x99FFFFFF),
      titleColor: AppColors.primary[700],
      disabledTitleColor: AppColors.white,
      blurEnabled: true,
    );
  }

  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Color? underlyingColor;
  final Color? borderColor;
  final Color? titleColor;
  final Color? disabledColor;
  final Color? disabledBorderColor;
  final Color? disabledTitleColor;
  final BorderRadius? borderRadius;
  final BoxShape boxShape;
  final bool blurEnabled;
  final double blurValue;

  AppButtonStyle from(AppButtonStyle? style) {
    return AppButtonStyle(
      padding: style?.padding ?? padding,
      backgroundColor: style?.backgroundColor ?? backgroundColor,
      underlyingColor: style?.underlyingColor ?? underlyingColor,
      titleColor: style?.titleColor ?? titleColor,
      borderColor: style?.borderColor ?? borderColor,
      disabledColor: style?.disabledColor ?? disabledColor,
      disabledBorderColor: style?.disabledBorderColor ?? disabledBorderColor,
      disabledTitleColor: style?.disabledTitleColor ?? disabledTitleColor,
      borderRadius: style?.borderRadius ?? borderRadius,
      boxShape: style?.boxShape ?? boxShape,
      blurEnabled: style?.blurEnabled ?? blurEnabled,
      blurValue: style?.blurValue ?? blurValue,
    );
  }
}
