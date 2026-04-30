import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Mirrors San3aTheme.kt — provides design tokens to the whole widget tree.
///
/// Usage: San3aTheme.of(context).colors / .textStyle / .radius
class San3aTheme extends InheritedWidget {
  final San3aColors colors;
  final San3aTextStyles textStyle;
  final San3aRadius radius;

  const San3aTheme({
    Key? key,
    required this.colors,
    required this.textStyle,
    required this.radius,
    required Widget child,
  }) : super(key: key, child: child);

  static San3aTheme of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<San3aTheme>()!;
  }

  @override
  bool updateShouldNotify(San3aTheme oldWidget) =>
      colors != oldWidget.colors;
}

/// Wrapper that provides both Material theme + San3a custom tokens.
class San3aThemeWrapper extends StatelessWidget {
  final bool isDark;
  final Widget child;

  const San3aThemeWrapper({
    Key? key,
    required this.isDark,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final san3aColors = isDark ? darkThemeColors : lightThemeColors;

    return San3aTheme(
      colors: san3aColors,
      textStyle: defaultTextStyles,
      radius: defaultRadius,
      child: child,
    );
  }
}

// --- Typography (from defaultTextStyle.kt, Plus Jakarta Sans) ---
class San3aTextStyles {
  final TextStyle displayXLarge;
  final TextStyle titleXLarge;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle bodyLargeRegular;
  final TextStyle bodyLargeMedium;
  final TextStyle bodyLargeSemibold;
  final TextStyle bodyMediumRegular;
  final TextStyle bodyMediumMedium;
  final TextStyle bodyMediumSemibold;
  final TextStyle bodySmallRegular;
  final TextStyle bodySmallMedium;
  final TextStyle bodySmallSemibold;
  final TextStyle labelMediumRegular;
  final TextStyle labelMediumMedium;
  final TextStyle labelMediumSemibold;

  const San3aTextStyles({
    required this.displayXLarge,
    required this.titleXLarge,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLargeRegular,
    required this.bodyLargeMedium,
    required this.bodyLargeSemibold,
    required this.bodyMediumRegular,
    required this.bodyMediumMedium,
    required this.bodyMediumSemibold,
    required this.bodySmallRegular,
    required this.bodySmallMedium,
    required this.bodySmallSemibold,
    required this.labelMediumRegular,
    required this.labelMediumMedium,
    required this.labelMediumSemibold,
  });
}

// Note: Plus Jakarta Sans must be added to pubspec.yaml assets or use google_fonts
// For now we use the font family name — it can be bundled or fetched at runtime.
const _fontFamily = 'PlusJakartaSans';

const defaultTextStyles = San3aTextStyles(
  displayXLarge: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w700, fontSize: 28),
  titleXLarge: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w600, fontSize: 24),
  titleLarge: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w500, fontSize: 20),
  titleMedium: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w500, fontSize: 18),
  titleSmall: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w500, fontSize: 16),
  bodyLargeRegular: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, fontSize: 16),
  bodyLargeMedium: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w500, fontSize: 16),
  bodyLargeSemibold: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w600, fontSize: 16),
  bodyMediumRegular: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, fontSize: 14),
  bodyMediumMedium: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w500, fontSize: 14),
  bodyMediumSemibold: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w600, fontSize: 14),
  bodySmallRegular: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, fontSize: 12),
  bodySmallMedium: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w500, fontSize: 12),
  bodySmallSemibold: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w600, fontSize: 12),
  labelMediumRegular: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400, fontSize: 12),
  labelMediumMedium: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w500, fontSize: 12),
  labelMediumSemibold: TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w600, fontSize: 12),
);

// --- Radius (from defaultSan3aRadius.kt) ---
class San3aRadius {
  final double none;
  final double extraExtraSmall;
  final double extraSmall;
  final double small;
  final double medium;
  final double large;
  final double extraLarge;
  final double extraExtraLarge;
  final double tripleXLarge;
  final double quadXLarge;
  final double quintXLarge;
  final double full;

  const San3aRadius({
    required this.none,
    required this.extraExtraSmall,
    required this.extraSmall,
    required this.small,
    required this.medium,
    required this.large,
    required this.extraLarge,
    required this.extraExtraLarge,
    required this.tripleXLarge,
    required this.quadXLarge,
    required this.quintXLarge,
    required this.full,
  });
}

const defaultRadius = San3aRadius(
  none: 0,
  extraExtraSmall: 2,
  extraSmall: 4,
  small: 8,
  medium: 10,
  large: 12,
  extraLarge: 16,
  extraExtraLarge: 20,
  tripleXLarge: 24,
  quadXLarge: 28,
  quintXLarge: 32,
  full: 1000,
);
