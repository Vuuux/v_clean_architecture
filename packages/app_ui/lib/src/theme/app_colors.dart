part of 'app_theme.dart';

final class AppColors {
  AppColors._();

  // ---------------------------------------------------------------------------
  // 1. SURFACES & HIERARCHY (The Physical Layers)
  // ---------------------------------------------------------------------------
  // Level 0 (The Void) - The base obsidian background
  static const Color bgDark = Color(0xFF0B0E14); // surface
  static const Color bgDarkOverlay = Color(0xB20B0E14); // background @ 70%

  // Level 1 (The Bed) - Used for large layout sections to create a soft edge
  static const Color bgLightGrey = Color(0xFF10131A); // surface_container_low

  // Level 2 (The Component) - Used for primary interactive cards
  static const Color bgLayerDark = Color(0xFF161A21); // surface_container

  // Level 3 (The Focus) - Active states, popovers, input fields
  static const Color bgFocus = Color(0xFF22262F); // surface_container_highest

  // Glassmorphism Overlays - Floating elements/modals
  static const Color bgSurfaceBright = Color(
    0xFF282C36,
  ); // surface_bright (base)
  static const Color bgOverlay = Color(
    0x80282C36,
  ); // surface_bright @ 50% opacity
  static const Color bgModalOverlay = Color(
    0x800B0E14,
  ); // Darkened modal backdrop

  // ---------------------------------------------------------------------------
  // 2. TYPOGRAPHY (Technical Editorial)
  // ---------------------------------------------------------------------------
  // Primary Data: Must "pop" against the dark background
  static const Color textPrimaryBlack = Color(0xFF00306C); // on_surface

  // Secondary/Labels: De-emphasized to balance technical precision
  static const Color textSecondaryGray = Color(
    0xFFA9ABB3,
  ); // on_surface_variant
  static const Color textSecondaryBlack = Color(
    0xFFA9ABB3,
  ); // on_surface_variant

  // Disabled / Inactive text
  static const Color textTertiaryBlack = Color(0xFF45484F); // outline_variant
  static const Color textDisabled = Color(0xFF45484F); // outline_variant

  // Brand / Actionable text
  static const Color textPrimaryBrand = primary;
  static const Color textContrast = Color(
    0xFF00EEFC,
  ); // secondary (Electric Blue)

  // ---------------------------------------------------------------------------
  // 3. BUTTONS (Holographic Controls)
  // ---------------------------------------------------------------------------
  static const Color btnPrimary = primary;
  static const Color btnPrimaryPressed = Color(
    0xFF0070EB,
  ); // primary_dim (gradient target)

  static const Color btnSecondary = Colors.transparent;
  static const Color btnSecondaryOutlinedBorder = Color(
    0xFF555555,
  ); // Ghost Border
  static const Color btnSecondaryPressed = Color(
    0xFF22262F,
  ); // surface_container_highest

  static const Color btnDisabled = Color(0xFF45484F); // outline_variant

  // ---------------------------------------------------------------------------
  // 4. BORDERS & DIVIDERS (The "No-Line" Rule)
  // ---------------------------------------------------------------------------
  // Dividers should ideally be transparent (background shifts define boundaries).
  // If borders are strictly necessary, ONLY use the "Ghost Border".
  static const Color outlineVariant = Color(0xFF45484F);
  static const Color divider = Color(
    0x2645484F,
  ); // Ghost Border: outline_variant @ 15%
  static const Color enabledBorderColor = Color(0x2645484F); // Ghost Border
  static const Color darkDivider = Color(
    0xFF45484F,
  ); // Solid fallback (avoid if possible)
  static const Color dividerFilledBorder = Color(0xFF45484F);

  // ---------------------------------------------------------------------------
  // 5. ICONS
  // ---------------------------------------------------------------------------
  static const Color icPrimaryBlack = Color(0xFFECEDF6); // on_surface
  static const Color icSecondary = Color(0xFFA9ABB3); // on_surface_variant
  static const Color icPrimary = primary;
  static const Color icLightGreen = Color(
    0xFF00EEFC,
  ); // Mapped to "Electric Blue"
  static const Color icDisabled = Color(0xFF45484F); // outline_variant

  // ---------------------------------------------------------------------------
  // 6. FEEDBACK & PROGRESS (Strict Mappings)
  // ---------------------------------------------------------------------------
  // Progress/Precision: Strictly mapped to Electric Blue (Laser Progress Bar)
  static const Color success = Color(0xFF00EEFC); // secondary
  static const Color successLight = Color(0x3300EEFC);

  // Errors: Strict red mapping. NEVER use primary/secondary for errors.
  static const Color error = Color(0xFFFF716C); // error
  static const Color errorLight = Color(0x33FF716C); // 20% opacity error

  // Warnings
  static const Color warning = Color(0xFFFFC107);
  static const Color warningLight = Color(0x33FFC107);

  // ---------------------------------------------------------------------------
  // 7. BRAND PALETTES
  // ---------------------------------------------------------------------------
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // The high-frequency vibration accent
  static const Color accentBlue = Color(0xFF00EEFC); // secondary
  static const Color accentYellow = Color(0xFFF0B208);

  // Blueprint Blue Palette
  static const MaterialAccentColor primary = MaterialAccentColor(
    _primaryDefaultValue,
    <int, Color>{
      50: Color(0xFFE5EEFF),
      100: Color(0xFFCCDDFF),
      200: Color(0xFF99BBFF),
      300: Color(0xFF85ADFF), // primary
      400: Color(0xFF6699FF),
      500: Color(_primaryDefaultValue),
      600: Color(0xFF0070EB), // primary_dim
      700: Color(0xFF005BC0),
      800: Color(0xFF004696),
      900: Color(0xFF00306C),
    },
  );
  static const int _primaryDefaultValue = 0xFF85ADFF; // primary

  // Neutral Tones mapped to surfaces
  static const MaterialAccentColor neutralsGrey = MaterialAccentColor(
    _neutralsGreyPrimaryValue,
    <int, Color>{
      50: Color(0xFF282C36), // surface_bright
      600: Color(_neutralsGreyPrimaryValue),
      900: Color(0xFF0B0E14), // background / The Void
    },
  );
  static const int _neutralsGreyPrimaryValue =
      0xFF161A21; // surface_container / Component

  static const MaterialAccentColor neutralsTinted = MaterialAccentColor(
    _neutralsTintedPrimaryValue,
    <int, Color>{
      500: Color(0xFF45484F), // outline_variant
      900: Color(_neutralsTintedPrimaryValue),
    },
  );
  static const int _neutralsTintedPrimaryValue =
      0xFF22262F; // surface_container_highest / Focus
}
