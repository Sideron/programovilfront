import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff006c4d),
      surfaceTint: Color(0xff006c4d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff29ebae),
      onPrimaryContainer: Color(0xff006548),
      secondary: Color(0xff186853),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff37816b),
      onSecondaryContainer: Color(0xfff5fff9),
      tertiary: Color(0xff315348),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff496b60),
      onTertiaryContainer: Color(0xffc5eadc),
      error: Color(0xff705d00),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffd72c),
      onErrorContainer: Color(0xff715d00),
      surface: Color.fromARGB(255, 214, 255, 244),
      onSurface: Color(0xff1a1c1b),
      onSurfaceVariant: Color(0xff3b4a42),
      outline: Color(0xff6b7b72),
      outlineVariant: Color(0xffbacac0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3130),
      inversePrimary: Color(0xff09e1a5),
      primaryFixed: Color(0xff49fec0),
      onPrimaryFixed: Color(0xff002115),
      primaryFixedDim: Color(0xff09e1a5),
      onPrimaryFixedVariant: Color(0xff005139),
      secondaryFixed: Color(0xffa7f2d7),
      onSecondaryFixed: Color(0xff002118),
      secondaryFixedDim: Color(0xff8bd5bb),
      onSecondaryFixedVariant: Color(0xff00513f),
      tertiaryFixed: Color(0xffc5ebdd),
      onTertiaryFixed: Color(0xff002019),
      tertiaryFixedDim: Color(0xffaacec1),
      onTertiaryFixedVariant: Color(0xff2b4d43),
      surfaceDim: Color(0xffdadad8),
      surfaceBright: Color(0xfff9f9f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4f4f2),
      surfaceContainer: Color(0xffeeeeec),
      surfaceContainerHigh: Color(0xffe8e8e6),
      surfaceContainerHighest: Color(0xffe2e2e1),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003f2b),
      surfaceTint: Color(0xff006c4d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff007c59),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff003e30),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff2e7964),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff1a3c33),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff496b60),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff413500),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff826b00),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9f9f7),
      onSurface: Color(0xff0f1211),
      onSurfaceVariant: Color(0xff2b3932),
      outline: Color(0xff47564e),
      outlineVariant: Color(0xff617168),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3130),
      inversePrimary: Color(0xff09e1a5),
      primaryFixed: Color(0xff007c59),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff006145),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff2e7964),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff0a604c),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff527469),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff3a5b51),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc6c7c5),
      surfaceBright: Color(0xfff9f9f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4f4f2),
      surfaceContainer: Color(0xffe8e8e6),
      surfaceContainerHigh: Color(0xffdddddb),
      surfaceContainerHighest: Color(0xffd1d2d0),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003323),
      surfaceTint: Color(0xff006c4d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff00543b),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff003327),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff005441),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff0f3229),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff2e4f45),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff362b00),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff584800),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9f9f7),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff212f28),
      outlineVariant: Color(0xff3d4c45),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3130),
      inversePrimary: Color(0xff09e1a5),
      primaryFixed: Color(0xff00543b),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003b28),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff005441),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff003a2d),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff2e4f45),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff16382f),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb8b9b7),
      surfaceBright: Color(0xfff9f9f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f1ef),
      surfaceContainer: Color(0xffe2e2e1),
      surfaceContainerHigh: Color(0xffd4d4d3),
      surfaceContainerHighest: Color(0xffc6c7c5),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffa1ffd5),
      surfaceTint: Color(0xff09e1a5),
      onPrimary: Color.fromARGB(255, 141, 237, 206),
      primaryContainer: Color(0xff29ebae),
      onPrimaryContainer: Color(0xff006548),
      secondary: Color(0xff8bd5bb),
      onSecondary: Color(0xff00382b),
      secondaryContainer: Color(0xff559e87),
      onSecondaryContainer: Color(0xff00281d),
      tertiary: Color(0xffaacec1),
      onTertiary: Color(0xff14362d),
      tertiaryContainer: Color(0xff496b60),
      onTertiaryContainer: Color(0xffc5eadc),
      error: Color(0xfffff6e2),
      onError: Color(0xff3b2f00),
      errorContainer: Color(0xffffd72c),
      onErrorContainer: Color(0xff715d00),
      surface: Color(0xff121413),
      onSurface: Color(0xffe2e2e1),
      onSurfaceVariant: Color(0xffbacac0),
      outline: Color(0xff84948b),
      outlineVariant: Color(0xff3b4a42),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e1),
      inversePrimary: Color(0xff006c4d),
      primaryFixed: Color(0xff49fec0),
      onPrimaryFixed: Color(0xff002115),
      primaryFixedDim: Color(0xff09e1a5),
      onPrimaryFixedVariant: Color(0xff005139),
      secondaryFixed: Color(0xffa7f2d7),
      onSecondaryFixed: Color(0xff002118),
      secondaryFixedDim: Color(0xff8bd5bb),
      onSecondaryFixedVariant: Color(0xff00513f),
      tertiaryFixed: Color(0xffc5ebdd),
      onTertiaryFixed: Color(0xff002019),
      tertiaryFixedDim: Color(0xffaacec1),
      onTertiaryFixedVariant: Color(0xff2b4d43),
      surfaceDim: Color(0xff121413),
      surfaceBright: Color(0xff383a39),
      surfaceContainerLowest: Color(0xff0d0f0e),
      surfaceContainerLow: Color(0xff1a1c1b),
      surfaceContainer: Color(0xff1e201f),
      surfaceContainerHigh: Color(0xff282a29),
      surfaceContainerHighest: Color(0xff333534),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffa1ffd5),
      surfaceTint: Color(0xff09e1a5),
      onPrimary: Color(0xff003826),
      primaryContainer: Color(0xff29ebae),
      onPrimaryContainer: Color(0xff004631),
      secondary: Color(0xffa1ebd1),
      onSecondary: Color(0xff002c21),
      secondaryContainer: Color(0xff559e87),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffbfe4d7),
      onTertiary: Color(0xff072b22),
      tertiaryContainer: Color(0xff75988c),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff6e2),
      onError: Color(0xff3b2f00),
      errorContainer: Color(0xffffd72c),
      onErrorContainer: Color(0xff504200),
      surface: Color(0xff121413),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd0e0d6),
      outline: Color(0xffa5b6ac),
      outlineVariant: Color(0xff84948b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e1),
      inversePrimary: Color(0xff00533a),
      primaryFixed: Color(0xff49fec0),
      onPrimaryFixed: Color(0xff00150c),
      primaryFixedDim: Color(0xff09e1a5),
      onPrimaryFixedVariant: Color(0xff003f2b),
      secondaryFixed: Color(0xffa7f2d7),
      onSecondaryFixed: Color(0xff00150e),
      secondaryFixedDim: Color(0xff8bd5bb),
      onSecondaryFixedVariant: Color(0xff003e30),
      tertiaryFixed: Color(0xffc5ebdd),
      onTertiaryFixed: Color(0xff00150f),
      tertiaryFixedDim: Color(0xffaacec1),
      onTertiaryFixedVariant: Color(0xff1a3c33),
      surfaceDim: Color(0xff121413),
      surfaceBright: Color(0xff434544),
      surfaceContainerLowest: Color(0xff060807),
      surfaceContainerLow: Color(0xff1c1e1d),
      surfaceContainer: Color(0xff262827),
      surfaceContainerHigh: Color(0xff313332),
      surfaceContainerHighest: Color(0xff3c3e3d),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb9ffdd),
      surfaceTint: Color(0xff09e1a5),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff29ebae),
      onPrimaryContainer: Color(0xff002115),
      secondary: Color(0xffb5ffe4),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xff87d1b8),
      onSecondaryContainer: Color(0xff000e09),
      tertiary: Color(0xffd3f8ea),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffa6cabd),
      onTertiaryContainer: Color(0xff000e09),
      error: Color(0xfffff6e2),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffd72c),
      onErrorContainer: Color(0xff2c2300),
      surface: Color(0xff121413),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffe3f4e9),
      outlineVariant: Color(0xffb6c7bc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e1),
      inversePrimary: Color(0xff00533a),
      primaryFixed: Color(0xff49fec0),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff09e1a5),
      onPrimaryFixedVariant: Color(0xff00150c),
      secondaryFixed: Color(0xffa7f2d7),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xff8bd5bb),
      onSecondaryFixedVariant: Color(0xff00150e),
      tertiaryFixed: Color(0xffc5ebdd),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffaacec1),
      onTertiaryFixedVariant: Color(0xff00150f),
      surfaceDim: Color(0xff121413),
      surfaceBright: Color(0xff4f504f),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1e201f),
      surfaceContainer: Color(0xff2f3130),
      surfaceContainerHigh: Color(0xff3a3c3b),
      surfaceContainerHighest: Color(0xff454746),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
