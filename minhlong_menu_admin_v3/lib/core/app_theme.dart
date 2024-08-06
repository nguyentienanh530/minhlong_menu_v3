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
  final Color colorDark;
  final Color colorLight;
  final FlexScheme scheme;

  ThemeDTO(
      {required this.key,
      required this.colorDark,
      required this.colorLight,
      required this.scheme});
}

final listScheme = <ThemeDTO>[
  ThemeDTO(
      key: "material",
      colorDark: const Color(0xFFBB86FC),
      colorLight: const Color(0xFF6200EE),
      scheme: FlexScheme.material),
  ThemeDTO(
      key: "materialHc",
      colorDark: const Color(0xFFEFB7FF),
      colorLight: const Color(0xFF0000BA),
      scheme: FlexScheme.materialHc),
  ThemeDTO(
    key: "blue",
    colorDark: const Color(0xFF90CAF9),
    colorLight: const Color(0xFF1565C0),
    scheme: FlexScheme.blue,
  ),
  ThemeDTO(
      key: "indigo",
      colorDark: const Color(0xFF7986CB),
      colorLight: const Color(0xFF303F9F),
      scheme: FlexScheme.indigo),
  ThemeDTO(
      key: "hippieBlue",
      colorDark: const Color(0xFF669DB3),
      colorLight: const Color(0xFF4C9BBA),
      scheme: FlexScheme.hippieBlue),
  ThemeDTO(
      key: "aquaBlue",
      colorDark: const Color(0xFF5DB3D5),
      colorLight: const Color(0xFF35A0CB),
      scheme: FlexScheme.aquaBlue),
  ThemeDTO(
      key: "brandBlue",
      colorDark: const Color(0xFF8B9DC3),
      colorLight: const Color(0xFF3B5998),
      scheme: FlexScheme.brandBlue),
  ThemeDTO(
      key: "deepBlue",
      colorDark: const Color(0xFF748BAC),
      colorLight: const Color(0xFF223A5E),
      scheme: FlexScheme.deepBlue),
  ThemeDTO(
      key: "sakura",
      colorDark: const Color(0xFFEEC4D8),
      colorLight: const Color(0xFFCE5B78),
      scheme: FlexScheme.sakura),
  ThemeDTO(
      key: "mandyRed",
      colorDark: const Color(0xFFDA8585),
      colorLight: const Color(0xFFCD5758),
      scheme: FlexScheme.mandyRed),
  ThemeDTO(
    key: "red",
    colorDark: const Color(0xFFEF9A9A),
    colorLight: const Color(0xFFC62828),
    scheme: FlexScheme.red,
  ),
  ThemeDTO(
      key: "redWine",
      colorDark: const Color(0xFFE4677C),
      colorLight: const Color(0xFF9B1B30),
      scheme: FlexScheme.redWine),
  ThemeDTO(
      key: "green",
      colorDark: const Color(0xFFA5D6A7),
      colorLight: const Color(0xFF2E7D32),
      scheme: FlexScheme.green),
  ThemeDTO(
      key: "money",
      colorDark: const Color(0xFF7AB893),
      colorLight: const Color(0xFF264E36),
      scheme: FlexScheme.money),
  ThemeDTO(
      key: "jungle",
      colorDark: const Color(0xFF519E67),
      colorLight: const Color(0xFF004E15),
      scheme: FlexScheme.jungle),
  ThemeDTO(
      key: "greyLaw",
      colorDark: const Color(0xFF90A4AE),
      colorLight: const Color(0xFF37474F),
      scheme: FlexScheme.greyLaw),
  ThemeDTO(
      key: "wasabi",
      colorDark: const Color(0xFFC3CB77),
      colorLight: const Color(0xFF738625),
      scheme: FlexScheme.wasabi),
  ThemeDTO(
    key: "gold",
    colorDark: const Color(0xFFEDA85E),
    colorLight: const Color(0xFFB86914),
    scheme: FlexScheme.gold,
  ),
  ThemeDTO(
      key: "mango",
      colorDark: const Color(0xFFDEB059),
      colorLight: const Color(0xFFC78D20),
      scheme: FlexScheme.mango),
  ThemeDTO(
      key: "vesuviusBurn",
      colorDark: const Color(0xFFD17D53),
      colorLight: const Color(0xFFA6400F),
      scheme: FlexScheme.vesuviusBurn),
  ThemeDTO(
      key: "deepPurple",
      colorDark: const Color(0xFFB39DDB),
      colorLight: const Color(0xFF4527A0),
      scheme: FlexScheme.deepPurple),
  ThemeDTO(
      key: "ebonyClay",
      colorDark: const Color(0xFF4E597D),
      colorLight: const Color(0xFF202541),
      scheme: FlexScheme.ebonyClay),
  ThemeDTO(
      key: "barossa",
      colorDark: const Color(0xFF94667E),
      colorLight: const Color(0xFF4E0029),
      scheme: FlexScheme.barossa),
  ThemeDTO(
      key: "shark",
      colorDark: const Color(0xFF777A7E),
      colorLight: const Color(0xFF1D2228),
      scheme: FlexScheme.shark),
  ThemeDTO(
      key: "bigStone",
      colorDark: const Color(0xFF60748A),
      colorLight: const Color(0xFF1A2C42),
      scheme: FlexScheme.bigStone),
  ThemeDTO(
      key: "damask",
      colorDark: const Color(0xFFDA9882),
      colorLight: const Color(0xFFC96646),
      scheme: FlexScheme.damask),
  ThemeDTO(
      key: "bahamaBlue",
      colorDark: const Color(0xFF4585B5),
      colorLight: const Color(0xFF095D9E),
      scheme: FlexScheme.bahamaBlue),
  ThemeDTO(
      key: "mallardGreen",
      colorDark: const Color(0xFF808E79),
      colorLight: const Color(0xFF2D4421),
      scheme: FlexScheme.mallardGreen),
  ThemeDTO(
      key: "espresso",
      colorDark: const Color(0xFF8D7F7D),
      colorLight: const Color(0xFF452F2B),
      scheme: FlexScheme.espresso),
  ThemeDTO(
      key: "outerSpace",
      colorDark: const Color(0xFF486A71),
      colorLight: const Color(0xFF1F3339),
      scheme: FlexScheme.outerSpace),
  ThemeDTO(
      key: "blueWhale",
      colorDark: const Color(0xFF486A71),
      colorLight: const Color(0xFF023047),
      scheme: FlexScheme.blueWhale),
  ThemeDTO(
      key: "sanJuanBlue",
      colorDark: const Color(0xFF5E7691),
      colorLight: const Color(0xFF375778),
      scheme: FlexScheme.sanJuanBlue),
  ThemeDTO(
      key: "rosewood",
      colorDark: const Color(0xFF9C5A69),
      colorLight: const Color(0xFF5C000E),
      scheme: FlexScheme.rosewood),
  ThemeDTO(
      key: "blumineBlue",
      colorDark: const Color(0xFF82BACE),
      colorLight: const Color(0xFF19647E),
      scheme: FlexScheme.blumineBlue),
  ThemeDTO(
      key: "flutterDash",
      colorDark: const Color(0xFFB4E6FF),
      colorLight: const Color(0xFF4496E0),
      scheme: FlexScheme.flutterDash),
  ThemeDTO(
      key: "materialBaseline",
      colorDark: const Color(0xFFD0BCFF),
      colorLight: const Color(0xFF6750A4),
      scheme: FlexScheme.materialBaseline),
  ThemeDTO(
      key: "verdunHemlock",
      colorDark: const Color(0xFFCBCC58),
      colorLight: const Color(0xFF616200),
      scheme: FlexScheme.verdunHemlock),
  ThemeDTO(
      key: "dellGenoa",
      colorDark: const Color(0xFF9CD67D),
      colorLight: const Color(0xFF386A20),
      scheme: FlexScheme.dellGenoa),
  ThemeDTO(
      key: "redM3",
      colorDark: const Color(0xFFFFB4AA),
      colorLight: const Color(0xFFBB1614),
      scheme: FlexScheme.redM3),
  ThemeDTO(
      key: "pinkM3",
      colorDark: const Color(0xFFFFB2BE),
      colorLight: const Color(0xFFBC004B),
      scheme: FlexScheme.pinkM3),
  ThemeDTO(
      key: "purpleM3",
      colorDark: const Color(0xFFF9ABFF),
      colorLight: const Color(0xFF9A25AE),
      scheme: FlexScheme.purpleM3),
  ThemeDTO(
      key: "indigoM3",
      colorDark: const Color(0xFFBAC3FF),
      colorLight: const Color(0xFF4355B9),
      scheme: FlexScheme.indigoM3),
  ThemeDTO(
      key: "blueM3",
      colorDark: const Color(0xFF9ECAFF),
      colorLight: const Color(0xFF0061A4),
      scheme: FlexScheme.blueM3),
  ThemeDTO(
      key: "cyanM3",
      colorDark: const Color(0xFF44D8F1),
      colorLight: const Color(0xFF006876),
      scheme: FlexScheme.cyanM3),
  ThemeDTO(
      key: "tealM3",
      colorDark: const Color(0xFF53DBCA),
      colorLight: const Color(0xFF006A60),
      scheme: FlexScheme.tealM3),
  ThemeDTO(
      key: "greenM3",
      colorDark: const Color(0xFF7EDB7B),
      colorLight: const Color(0xFF006E1C),
      scheme: FlexScheme.greenM3),
  ThemeDTO(
      key: "limeM3",
      colorDark: const Color(0xFFBCD063),
      colorLight: const Color(0xFF556500),
      scheme: FlexScheme.limeM3),
  ThemeDTO(
      key: "yellowM3",
      colorDark: const Color(0xFFD8C84F),
      colorLight: const Color(0xFF695F00),
      scheme: FlexScheme.yellowM3),
  ThemeDTO(
      key: "orangeM3",
      colorDark: const Color(0xFFFFB871),
      colorLight: const Color(0xFF8B5000),
      scheme: FlexScheme.orangeM3),
  ThemeDTO(
      key: "deepOrangeM3",
      colorDark: const Color(0xFFFFB5A0),
      colorLight: const Color(0xFFBF360C),
      scheme: FlexScheme.deepOrangeM3),
];
