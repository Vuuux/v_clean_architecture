part of 'app_theme.dart';

final class AppTextTheme {
  // Functional text uses Inter (_kFontFamily)
  static TextTheme lightTextTheme = const TextTheme(
    bodyLarge: TextStyle(
      fontSize: Dimens.textBody,
      fontWeight: FontWeight.w600,
      height: Dimens.textBodyHeight,
      color: _lightTextColor,
      fontFamily: _kFontFamily,
      decorationColor: _lightTextColor,
      letterSpacing: 0,
    ),
    bodyMedium: TextStyle(
      fontSize: Dimens.textBody,
      fontWeight: FontWeight.w500,
      height: Dimens.textBodyHeight,
      color: _lightTextColor,
      fontFamily: _kFontFamily,
      decorationColor: _lightTextColor,
      letterSpacing: 0,
    ),
    bodySmall: TextStyle(
      fontSize: Dimens.textBodySmall,
      fontWeight: FontWeight.w400,
      height: Dimens.textBodySmallHeight,
      color: _lightTextColor,
      fontFamily: _kFontFamily,
      decorationColor: _lightTextColor,
      letterSpacing: 0,
    ),
    labelMedium: TextStyle(
      fontSize: Dimens.textLabel,
      fontWeight: FontWeight.w500,
      height: Dimens.textLabelHeight,
      color: AppColors.textSecondaryGray, // De-emphasize secondary information
      fontFamily: _kFontFamily,
      decorationColor: AppColors.textSecondaryGray,
      letterSpacing: 0,
    ),
  );

  static TextTheme darkTextTheme = const TextTheme(
    bodyLarge: TextStyle(
      fontSize: Dimens.textBody,
      fontWeight: FontWeight.w600,
      height: Dimens.textBodyHeight,
      color: _darkTextColor,
      fontFamily: _kFontFamily,
      decorationColor: _darkTextColor,
      letterSpacing: 0,
    ),
    bodyMedium: TextStyle(
      fontSize: Dimens.textBody,
      fontWeight: FontWeight.w500,
      height: Dimens.textBodyHeight,
      color: _darkTextColor,
      fontFamily: _kFontFamily,
      decorationColor: _darkTextColor,
      letterSpacing: 0,
    ),
    bodySmall: TextStyle(
      fontSize: Dimens.textBodySmall,
      fontWeight: FontWeight.w400,
      height: Dimens.textBodySmallHeight,
      color: _darkTextColor,
      fontFamily: _kFontFamily,
      decorationColor: _darkTextColor,
      letterSpacing: 0,
    ),
    labelMedium: TextStyle(
      fontSize: Dimens.textLabel,
      fontWeight: FontWeight.w500,
      height: Dimens.textLabelHeight,
      color: AppColors.textSecondaryGray, // De-emphasize secondary information
      fontFamily: _kFontFamily,
      decorationColor: AppColors.textSecondaryGray,
      letterSpacing: 0,
    ),
  );
}

extension TextStyleExtension on TextStyle {
  TextStyle get semibold => copyWith(fontWeight: FontWeight.w600);
  double get lineHeight =>
      fontSize != null && height != null ? fontSize! * height! : 0;
}

// Display and Headlines use Space Grotesk (_kDisplayFontFamily)
extension TextThemeExtension on TextTheme {
  TextStyle get h1 => const TextStyle(
    fontSize: Dimens.textH1,
    fontWeight: FontWeight.w500,
    height: Dimens.textH1Height,
    fontFamily: _kDisplayFontFamily,
    letterSpacing: 0,
  );
  TextStyle get h2 => const TextStyle(
    fontSize: Dimens.textH2,
    fontWeight: FontWeight.w500,
    height: Dimens.textH2Height,
    fontFamily: _kDisplayFontFamily,
    letterSpacing: 0,
  );
  TextStyle get h3 => const TextStyle(
    fontSize: Dimens.textH3,
    fontWeight: FontWeight.w500,
    height: Dimens.textH3Height,
    fontFamily: _kDisplayFontFamily,
    letterSpacing: 0,
  );
  TextStyle get h4 => const TextStyle(
    fontSize: Dimens.textH4,
    fontWeight: FontWeight.w500,
    height: Dimens.textH4Height,
    fontFamily: _kDisplayFontFamily,
    letterSpacing: 0,
  );
  TextStyle get h5 => const TextStyle(
    fontSize: Dimens.textH5,
    fontWeight: FontWeight.w500,
    height: Dimens.textH5Height,
    fontFamily: _kDisplayFontFamily,
    letterSpacing: 0,
  );
  TextStyle get h6 => const TextStyle(
    fontSize: Dimens.textH6,
    fontWeight: FontWeight.w500,
    height: Dimens.textH6Height,
    fontFamily: _kDisplayFontFamily,
    letterSpacing: 0,
  );
  TextStyle get remark => const TextStyle(
    fontSize: Dimens.textRemark,
    fontWeight: FontWeight.w500,
    height: Dimens.textRemarkHeight,
    fontFamily: _kFontFamily, // Remark stays Inter
    letterSpacing: 0,
  );
  TextStyle get button => const TextStyle(
    fontSize: Dimens.textButton,
    fontWeight: FontWeight.w600,
    height: Dimens.textButtonHeight,
    fontFamily: _kFontFamily, // Button text stays Inter
    letterSpacing: 0,
  );
}
