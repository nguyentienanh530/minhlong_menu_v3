import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final String? scheme;

  AppTheme({required this.scheme});
  ThemeData get lightTheme => FlexThemeData.light(
        scheme: getFlexScheme(scheme!),
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 7,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 10,
          blendOnColors: false,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
          alignedDropdown: true,
          useInputDecoratorThemeInDialogs: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        // To use the Playground font, add GoogleFonts package and uncomment
        fontFamily: GoogleFonts.roboto().fontFamily,
      );
  ThemeData get darkTheme => FlexThemeData.dark(
        scheme: getFlexScheme(scheme!),
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 13,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
          alignedDropdown: true,
          useInputDecoratorThemeInDialogs: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        // To use the Playground font, add GoogleFonts package and uncomment
        fontFamily: GoogleFonts.roboto().fontFamily,
      );
  FlexScheme getFlexScheme(String scheme) {
    return listScheme.firstWhere((element) => element.key == scheme).scheme;
  }
}

Map<int, Color> getSwatch(Color color) {
  final hslColor = HSLColor.fromColor(color);
  final lightness = hslColor.lightness;

  /// if [500] is the default color, there are at LEAST five
  /// steps below [500]. (i.e. 400, 300, 200, 100, 50.) A
  /// divisor of 5 would mean [50] is a lightness of 1.0 or
  /// a color of #ffffff. A value of six would be near white
  /// but not quite.
  const lowDivisor = 6;

  /// if [500] is the default color, there are at LEAST four
  /// steps above [500]. A divisor of 4 would mean [900] is
  /// a lightness of 0.0 or color of #000000
  const highDivisor = 5;

  final lowStep = (1.0 - lightness) / lowDivisor;
  final highStep = lightness / highDivisor;

  return {
    50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
    100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
    200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
    300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
    400: (hslColor.withLightness(lightness + lowStep)).toColor(),
    500: (hslColor.withLightness(lightness)).toColor(),
    600: (hslColor.withLightness(lightness - highStep)).toColor(),
    700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
    800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
    900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
  };
}

class ThemeDTO {
  final String key;
  final Color color;
  final FlexScheme scheme;

  ThemeDTO({required this.key, required this.color, required this.scheme});
}

final listScheme = <ThemeDTO>[
  ThemeDTO(
      key: "material",
      color: const Color(0xFFBB86FC),
      scheme: FlexScheme.material),
  ThemeDTO(
      key: "materialHc",
      color: const Color(0xFFEFB7FF),
      scheme: FlexScheme.materialHc),
  ThemeDTO(
      key: "blue", color: const Color(0xFF90CAF9), scheme: FlexScheme.blue),
  ThemeDTO(
      key: "indigo", color: const Color(0xFF7986CB), scheme: FlexScheme.indigo),
  ThemeDTO(
      key: "hippieBlue",
      color: const Color(0xFF669DB3),
      scheme: FlexScheme.hippieBlue),
  ThemeDTO(
      key: "aquaBlue",
      color: const Color(0xFF5DB3D5),
      scheme: FlexScheme.aquaBlue),
  ThemeDTO(
      key: "brandBlue",
      color: const Color(0xFF8B9DC3),
      scheme: FlexScheme.brandBlue),
  ThemeDTO(
      key: "deepBlue",
      color: const Color(0xFF748BAC),
      scheme: FlexScheme.deepBlue),
  ThemeDTO(
      key: "sakura", color: const Color(0xFFEEC4D8), scheme: FlexScheme.sakura),
  ThemeDTO(
      key: "mandyRed",
      color: const Color(0xFFDA8585),
      scheme: FlexScheme.mandyRed),
  ThemeDTO(key: "red", color: const Color(0xFFEF9A9A), scheme: FlexScheme.red),
  ThemeDTO(
      key: "redWine",
      color: const Color(0xFFE4677C),
      scheme: FlexScheme.redWine),
  ThemeDTO(
      key: "green", color: const Color(0xFFA5D6A7), scheme: FlexScheme.green),
  ThemeDTO(
      key: "money", color: const Color(0xFF7AB893), scheme: FlexScheme.money),
  ThemeDTO(
      key: "jungle", color: const Color(0xFF519E67), scheme: FlexScheme.jungle),
  ThemeDTO(
      key: "greyLaw",
      color: const Color(0xFF90A4AE),
      scheme: FlexScheme.greyLaw),
  ThemeDTO(
      key: "wasabi", color: const Color(0xFFC3CB77), scheme: FlexScheme.wasabi),
  ThemeDTO(
      key: "gold", color: const Color(0xFFEDA85E), scheme: FlexScheme.gold),
  ThemeDTO(
      key: "mango", color: const Color(0xFFDEB059), scheme: FlexScheme.mango),
  ThemeDTO(
      key: "vesuviusBurn",
      color: const Color(0xFFD17D53),
      scheme: FlexScheme.vesuviusBurn),
  ThemeDTO(
      key: "deepPurple",
      color: const Color(0xFFB39DDB),
      scheme: FlexScheme.deepPurple),
  ThemeDTO(
      key: "ebonyClay",
      color: const Color(0xFF4E597D),
      scheme: FlexScheme.ebonyClay),
  ThemeDTO(
      key: "barossa",
      color: const Color(0xFF94667E),
      scheme: FlexScheme.barossa),
  ThemeDTO(
      key: "shark", color: const Color(0xFF777A7E), scheme: FlexScheme.shark),
  ThemeDTO(
      key: "bigStone",
      color: const Color(0xFF60748A),
      scheme: FlexScheme.bigStone),
  ThemeDTO(
      key: "damask", color: const Color(0xFFDA9882), scheme: FlexScheme.damask),
  ThemeDTO(
      key: "bahamaBlue",
      color: const Color(0xFF4585B5),
      scheme: FlexScheme.bahamaBlue),
  ThemeDTO(
      key: "mallardGreen",
      color: const Color(0xFF808E79),
      scheme: FlexScheme.mallardGreen),
  ThemeDTO(
      key: "espresso",
      color: const Color(0xFF8D7F7D),
      scheme: FlexScheme.espresso),
  ThemeDTO(
      key: "outerSpace",
      color: const Color(0xFF486A71),
      scheme: FlexScheme.outerSpace),
  ThemeDTO(
      key: "blueWhale",
      color: const Color(0xFF486A71),
      scheme: FlexScheme.blueWhale),
  ThemeDTO(
      key: "sanJuanBlue",
      color: const Color(0xFF5E7691),
      scheme: FlexScheme.sanJuanBlue),
  ThemeDTO(
      key: "rosewood",
      color: const Color(0xFF9C5A69),
      scheme: FlexScheme.rosewood),
  ThemeDTO(
      key: "blumineBlue",
      color: const Color(0xFF82BACE),
      scheme: FlexScheme.blumineBlue),
  ThemeDTO(
      key: "flutterDash",
      color: const Color(0xFFB4E6FF),
      scheme: FlexScheme.flutterDash),
  ThemeDTO(
      key: "materialBaseline",
      color: const Color(0xFFD0BCFF),
      scheme: FlexScheme.materialBaseline),
  ThemeDTO(
      key: "verdunHemlock",
      color: const Color(0xFFCBCC58),
      scheme: FlexScheme.verdunHemlock),
  ThemeDTO(
      key: "dellGenoa",
      color: const Color(0xFF9CD67D),
      scheme: FlexScheme.dellGenoa),
  ThemeDTO(
      key: "redM3", color: const Color(0xFFFFB4AA), scheme: FlexScheme.redM3),
  ThemeDTO(
      key: "pinkM3", color: const Color(0xFFFFB2BE), scheme: FlexScheme.pinkM3),
  ThemeDTO(
      key: "purpleM3",
      color: const Color(0xFFF9ABFF),
      scheme: FlexScheme.purpleM3),
  ThemeDTO(
      key: "indigoM3",
      color: const Color(0xFFBAC3FF),
      scheme: FlexScheme.indigoM3),
  ThemeDTO(
      key: "blueM3", color: const Color(0xFF9ECAFF), scheme: FlexScheme.blueM3),
  ThemeDTO(
      key: "cyanM3", color: const Color(0xFF44D8F1), scheme: FlexScheme.cyanM3),
  ThemeDTO(
      key: "tealM3", color: const Color(0xFF53DBCA), scheme: FlexScheme.tealM3),
  ThemeDTO(
      key: "greenM3",
      color: const Color(0xFF7EDB7B),
      scheme: FlexScheme.greenM3),
  ThemeDTO(
      key: "limeM3", color: const Color(0xFFBCD063), scheme: FlexScheme.limeM3),
  ThemeDTO(
      key: "yellowM3",
      color: const Color(0xFFD8C84F),
      scheme: FlexScheme.yellowM3),
  ThemeDTO(
      key: "orangeM3",
      color: const Color(0xFFFFB871),
      scheme: FlexScheme.orangeM3),
  ThemeDTO(
      key: "deepOrangeM3",
      color: const Color(0xFFFFB5A0),
      scheme: FlexScheme.deepOrangeM3),
];
