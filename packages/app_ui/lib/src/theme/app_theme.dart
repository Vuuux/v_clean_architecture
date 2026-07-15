import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'app_colors.dart';
part 'app_dimens.dart';
part 'app_text_theme.dart';

// The Kinetic Blueprint uses Inter for Swiss-style neutrality on functional text.
// Space Grotesk is assigned to headlines/displays inside AppTextTheme.
const _kFontFamily = 'Inter';
const _kDisplayFontFamily = 'Space Grotesk';

const Color _lightTextColor = AppColors.textPrimaryBlack;
const Color _darkTextColor = AppColors.white;

final class AppTheme {
  // Note: The Kinetic Blueprint is an inherently dark-themed system.
  // The light theme is maintained here for structural safety but uses the new dark tokens.
  static ThemeData light() {
    return ThemeData(
      fontFamily: _kFontFamily,
      brightness: Brightness.light,
      splashColor: Colors.transparent,
      scaffoldBackgroundColor: AppColors.bgDark,
      primaryColor: AppColors.primary,
      textTheme: AppTextTheme.lightTextTheme,
      iconTheme: const IconThemeData(color: AppColors.icPrimaryBlack),

      appBarTheme: const AppBarTheme(
        foregroundColor: AppColors.textPrimaryBlack,
        backgroundColor: AppColors.bgDark, // Level 0 (The Void)
        elevation: 0, // No standard Material shadows
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),

      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.zero,
        minVerticalPadding: Dimens.zero,
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.success, // "Electric Blue... associated with progress"
        linearTrackColor: AppColors.bgLayerDark,
        strokeCap: StrokeCap.round,
        borderRadius: BorderRadius.circular(Dimens.radiusRounded),
        linearMinHeight: 2.0, // The "Laser" Progress Bar rule
      ),

      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.accentBlue,
        surface: AppColors.bgLightGrey, // Level 1 (The Bed)
        error: AppColors.error,
        onSecondary: AppColors.white,
        onSurface: AppColors.textPrimaryBlack,
      ),

      dividerTheme: const DividerThemeData(
        space: 1,
        color: AppColors.divider, // Ghost Border rule fallback
        thickness: Dimens.dividerThickness,
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      fontFamily: _kFontFamily,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.bgDark, // Level 0 (The Void)
      primaryColor: AppColors.primary,
      splashColor: Colors.transparent,

      appBarTheme: const AppBarTheme(
        foregroundColor: AppColors.textPrimaryBlack,
        backgroundColor: AppColors.bgDark,
        elevation: 0, // Enforcing "No Standard Material Shadows"
      ),

      textTheme: AppTextTheme.darkTextTheme,

      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.zero,
        minVerticalPadding: Dimens.zero,
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.success, // Progress uses secondary "Electric Blue"
        linearTrackColor: AppColors.bgLayerDark,
        strokeCap: StrokeCap.round,
        borderRadius: BorderRadius.circular(Dimens.radiusRounded),
        linearMinHeight: 2.0, // The "Laser" Progress Bar rule
      ),

      bottomSheetTheme: const BottomSheetThemeData(
        // Glassmorphism rule: Requires a BackdropFilter widget in the UI,
        // but we set the transparent overlay base color here.
        backgroundColor: AppColors.bgOverlay,
        elevation: 0, // No standard shadows
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: Colors
            .transparent, // "No-Line" Rule globally. Use Ghost borders only when necessary.
        thickness: Dimens.dividerThickness,
      ),

      iconTheme: const IconThemeData(color: AppColors.icPrimaryBlack),

      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.accentBlue,
        surface: AppColors.bgLightGrey, // Level 1 (The Bed)
        error: AppColors.error,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onSurface: AppColors.textPrimaryBlack,
        onError: AppColors.white,
        brightness: Brightness.dark,
      ),

      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.textPrimaryBlack,
        labelStyle: AppTextTheme.darkTextTheme.button.semibold,
        unselectedLabelStyle: AppTextTheme.darkTextTheme.button,
        unselectedLabelColor: AppColors.textDisabled,
        dividerColor: Colors.transparent, // "No-Line" Rule
        indicator: const UnderlineTabIndicator(
          // 2px accent to mimic the "Digital Readout"
          borderSide: BorderSide(width: 2, color: AppColors.accentBlue),
        ),
        indicatorColor: AppColors.accentBlue,
        indicatorSize: TabBarIndicatorSize.tab,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
      ),

      // --- NEW KINETIC BLUEPRINT ADDITIONS ---

      // Buttons (Holographic Controls)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.white, // on_primary_fixed
          backgroundColor: AppColors.primary, // Fallback for gradient
          elevation: 0, // "Depth is achieved by stacking", no standard shadows
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              12.0,
            ), // xl roundedness (0.75rem)
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(
            color: AppColors.btnSecondaryOutlinedBorder,
          ), // Ghost Border
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // xl roundedness
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor:
              AppColors.accentBlue, // Secondary color for actionable weight
          elevation: 0,
        ),
      ),

      // Input Fields (Precision Data)
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFF22262F), // surface_container_highest
        border: UnderlineInputBorder(borderSide: BorderSide.none),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: UnderlineInputBorder(
          // 2px bottom-only accent in secondary to mimic digital readout
          borderSide: BorderSide(color: AppColors.accentBlue, width: 2.0),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.error, width: 2.0),
        ),
      ),
    );
  }
}
