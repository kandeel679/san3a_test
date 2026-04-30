import 'package:flutter/material.dart';

/// Faithful port of San3aColors from Kotlin design system.
/// Mirrors: lightThemeColors.kt and darkThemColor.kt

class San3aColors {
  final BackgroundColors background;
  final ShadeColors shade;
  final BrandColors brand;
  final ButtonColors button;
  final StrokeColors stroke;
  final OverlayColors overlay;
  final AdditionalColors additional;

  const San3aColors({
    required this.background,
    required this.shade,
    required this.brand,
    required this.button,
    required this.stroke,
    required this.overlay,
    required this.additional,
  });
}

class BackgroundColors {
  final Color screen;
  final Color card;
  final Color bottomSheet;
  final Color bottomSheetCard;

  const BackgroundColors({
    required this.screen,
    required this.card,
    required this.bottomSheet,
    required this.bottomSheetCard,
  });
}

class ShadeColors {
  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color quaternary;
  final Color quinary;

  const ShadeColors({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.quaternary,
    required this.quinary,
  });
}

class BrandColors {
  final Color primary;
  final Color secondary;
  final Color tertiary;

  const BrandColors({
    required this.primary,
    required this.secondary,
    required this.tertiary,
  });
}

class ButtonColors {
  final Color primary;
  final Color secondary;
  final Color disabled;
  final Color onPrimary;
  final Color onSecondary;
  final Color onDisabled;
  final Color onTertiary;

  const ButtonColors({
    required this.primary,
    required this.secondary,
    required this.disabled,
    required this.onPrimary,
    required this.onSecondary,
    required this.onDisabled,
    required this.onTertiary,
  });
}

class StrokeColors {
  final Color primary;
  const StrokeColors({required this.primary});
}

class OverlayColors {
  final Color primary;
  const OverlayColors({required this.primary});
}

class AdditionalColorSet {
  final Color error;
  final Color success;
  final Color warning;
  final Color purple;
  final Color red;
  final Color blue;
  final Color turquoise;
  final Color yellow;
  final Color green;

  const AdditionalColorSet({
    required this.error,
    required this.success,
    required this.warning,
    required this.purple,
    required this.red,
    required this.blue,
    required this.turquoise,
    required this.yellow,
    required this.green,
  });
}

class AdditionalColors {
  final AdditionalColorSet primary;
  final AdditionalColorSet secondary;
  const AdditionalColors({required this.primary, required this.secondary});
}

// --- Light Theme (from lightThemeColors.kt) ---
const lightThemeColors = San3aColors(
  background: BackgroundColors(
    screen: Color(0xFFF7F7F7),
    card: Color(0xFFFFFFFF),
    bottomSheet: Color(0xFFFFFFFF),
    bottomSheetCard: Color(0xFFF6F6F6),
  ),
  shade: ShadeColors(
    primary: Color(0xFF313131),
    secondary: Color(0xFF717171),
    tertiary: Color(0xFFA5A5A5),
    quaternary: Color(0xFFECECEC),
    quinary: Color(0xFFF6F6F6),
  ),
  brand: BrandColors(
    primary: Color(0xFF5C9EFF),
    secondary: Color(0xFFC1DAFF),
    tertiary: Color(0xFFF2F7FF),
  ),
  button: ButtonColors(
    primary: Color(0xFF5C9EFF),
    secondary: Color(0xFFFFFFFF),
    disabled: Color(0xFFECECEC),
    onPrimary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFF313131),
    onDisabled: Color(0xFFA5A5A5),
    onTertiary: Color(0xFF5C9EFF),
  ),
  stroke: StrokeColors(primary: Color(0xFFEDEDED)),
  overlay: OverlayColors(primary: Color(0x99121212)),
  additional: AdditionalColors(
    primary: AdditionalColorSet(
      error: Color(0xFFEF4444),
      success: Color(0xFF22C55E),
      warning: Color(0xFFFACC15),
      purple: Color(0xFF9A83CE),
      red: Color(0xFFF56C6C),
      blue: Color(0xFF4C8FD3),
      turquoise: Color(0xFF4BA8A7),
      yellow: Color(0xFFE3B339),
      green: Color(0xFF6DBF7E),
    ),
    secondary: AdditionalColorSet(
      error: Color(0xFFEBEEEE),
      success: Color(0xFFEEF5EF),
      warning: Color(0xFFFFFAEB),
      purple: Color(0xFFF7F5FB),
      red: Color(0xFFFEF3F3),
      blue: Color(0xFFF1F6FB),
      turquoise: Color(0xFFF1F8F8),
      yellow: Color(0xFFFDF9EF),
      green: Color(0xFFF3FAF5),
    ),
  ),
);

// --- Dark Theme (from darkThemColor.kt) ---
const darkThemeColors = San3aColors(
  background: BackgroundColors(
    screen: Color(0xFF121321),
    card: Color(0xFF1B1C2A),
    bottomSheet: Color(0xFF1B1C2A),
    bottomSheetCard: Color(0xFF242533),
  ),
  shade: ShadeColors(
    primary: Color(0xFFE1E1E3),
    secondary: Color(0xFFA4A4AA),
    tertiary: Color(0xFF72727B),
    quaternary: Color(0xFF2D2E3B),
    quinary: Color(0xFF242533),
  ),
  brand: BrandColors(
    primary: Color(0xFF5C9EFF),
    secondary: Color(0xFF344D7B),
    tertiary: Color(0xFF20263B),
  ),
  button: ButtonColors(
    primary: Color(0xFF5C9EFF),
    secondary: Color(0xFF20263B),
    disabled: Color(0xFF2D2E3B),
    onPrimary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFFE1E1E3),
    onDisabled: Color(0xFF72727B),
    onTertiary: Color(0xFF5C9EFF),
  ),
  stroke: StrokeColors(primary: Color(0xFF24263B)),
  overlay: OverlayColors(primary: Color(0x99121321)),
  additional: AdditionalColors(
    primary: AdditionalColorSet(
      error: Color(0xFFFF6B6B),
      success: Color(0xFF00E676),
      warning: Color(0xFFFFD600),
      purple: Color(0xFF9A83CE),
      red: Color(0xFFF56C6C),
      blue: Color(0xFF4C8FD3),
      turquoise: Color(0xFF4BA8A7),
      yellow: Color(0xFFE3B339),
      green: Color(0xFF6DBF7E),
    ),
    secondary: AdditionalColorSet(
      error: Color(0xFF2C202D),
      success: Color(0xFF232A31),
      warning: Color(0xFF2D2927),
      purple: Color(0xFF252437),
      red: Color(0xFF2C222F),
      blue: Color(0xFF1F2538),
      turquoise: Color(0xFF1F2734),
      yellow: Color(0xFF2B282B),
      green: Color(0xFF222931),
    ),
  ),
);
