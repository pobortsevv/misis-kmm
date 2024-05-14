import 'package:flutter/cupertino.dart';

class ThemeClass {
  static CupertinoTextThemeData lightThemeTextData = CupertinoTextThemeData(
    primaryColor: FigmaColors.texticonsPrimaruLight,
    textStyle: const FigmaTextStyles().body,
    navTitleTextStyle: const FigmaTextStyles().title,
    navLargeTitleTextStyle: const FigmaTextStyles().headline,
    tabLabelTextStyle: const FigmaTextStyles().footnote
  );

  static CupertinoTextThemeData darkThemeTextData = CupertinoTextThemeData(
    primaryColor: FigmaColors.texticonsPrimaruDark,
    textStyle: const FigmaTextStyles().darkBody,
    navTitleTextStyle: const FigmaTextStyles().darkTitle,
    navLargeTitleTextStyle: const FigmaTextStyles().darkHeadline,
    tabLabelTextStyle: const FigmaTextStyles().dartFootnote
  );

  static CupertinoThemeData lightThemeData = CupertinoThemeData(
    brightness: Brightness.light,
    textTheme: ThemeClass.lightThemeTextData,
    primaryColor: FigmaColors.primary,
    scaffoldBackgroundColor: FigmaColors.background1levelLight,
    barBackgroundColor: FigmaColors.background1levelLight,
    applyThemeToAll: true
  );

  static CupertinoThemeData darkThemeData = CupertinoThemeData(
    brightness: Brightness.dark,
    textTheme: ThemeClass.darkThemeTextData,
    primaryColor: FigmaColors.texticonsPrimaruDark,
    scaffoldBackgroundColor: FigmaColors.background1levelDark,
    barBackgroundColor: FigmaColors.background1levelDark,
    applyThemeToAll: true
  );
}

class FigmaColors {
  const FigmaColors();

  static const Color primary = Color(0xff0541f1);
  static const Color secondary = Color(0xffff7d63);
  static const Color background1levelLight = Color(0xffffffff);
  static const Color background2levelLight = Color(0xffffffff);
  static const Color backgroundAccentLight = Color(0xfff5f5f5);
  static const Color background1levelDark = Color(0xff121212);
  static const Color background2levelDark = Color(0xff212121);
  static const Color backgroundAccentDark = Color(0xff333333);
  static const Color texticonsPrimaruLight = Color(0xe5000000);
  static const Color texticonsSecondaryLight = Color(0x80000000);
  static const Color texticonsPrimaruDark = Color(0xffffffff);
  static const Color texticonsSecondaryDark = Color(0xb2ffffff);
}

class FigmaTextStyles {
  const FigmaTextStyles();

  // LIGHT --

  TextStyle get headline => const TextStyle(
    fontSize: 28,
    color: FigmaColors.texticonsPrimaruLight,
    decoration: TextDecoration.none,
    fontFamily: 'Roboto-Bold',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    height: 32 / 28,
    letterSpacing: -0.41,
  );

  TextStyle get title => const TextStyle(
    fontSize: 20,
    color: FigmaColors.texticonsPrimaruLight,
    decoration: TextDecoration.none,
    fontFamily: 'Roboto-Bold',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    height: 27 / 20,
    letterSpacing: 0,
  );

  TextStyle get body => const TextStyle(
    fontSize: 16,
    color: FigmaColors.texticonsPrimaruLight,
    decoration: TextDecoration.none,
    fontFamily: 'Roboto-Regular',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    height: 21.6 / 16,
    letterSpacing: 0,
  );

  TextStyle get footnote => const TextStyle(
    fontSize: 14,
    color: FigmaColors.texticonsPrimaruLight,
    decoration: TextDecoration.none,
    fontFamily: 'Roboto-Regular',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    height: 22 / 14,
    letterSpacing: 0,
  );

  TextStyle get caption => const TextStyle(
    fontSize: 12,
    decoration: TextDecoration.none,
    fontFamily: 'Roboto-Medium',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    height: 14 / 12,
    letterSpacing: 4,
  );

  // DARK --

  TextStyle get darkHeadline => const TextStyle(
    fontSize: 28,
    color: FigmaColors.texticonsPrimaruDark,
    decoration: TextDecoration.none,
    fontFamily: 'Roboto-Bold',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    height: 32 / 28,
    letterSpacing: -0.41,
  );

  TextStyle get darkTitle => const TextStyle(
    fontSize: 20,
    color: FigmaColors.texticonsPrimaruDark,
    decoration: TextDecoration.none,
    fontFamily: 'Roboto-Bold',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    height: 27 / 20,
    letterSpacing: 0,
  );

  TextStyle get darkBody => const TextStyle(
    fontSize: 16,
    color: FigmaColors.texticonsPrimaruDark,
    decoration: TextDecoration.none,
    fontFamily: 'Roboto-Regular',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    height: 21.6 / 16,
    letterSpacing: 0,
  );

  TextStyle get dartFootnote => const TextStyle(
    fontSize: 14,
    color: FigmaColors.texticonsPrimaruDark,
    decoration: TextDecoration.none,
    fontFamily: 'Roboto-Regular',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    height: 22 / 14,
    letterSpacing: 0,
  );

  TextStyle get darkCaption => const TextStyle(
    fontSize: 12,
    color: FigmaColors.texticonsSecondaryDark,
    decoration: TextDecoration.none,
    fontFamily: 'Roboto-Medium',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    height: 14 / 12,
    letterSpacing: 4,
  );

  // Alternative --

  TextStyle get secondaryTitle => TextStyle(
    fontSize: 20,
    color: FigmaColors.texticonsPrimaruLight.withOpacity(0.3),
    decoration: TextDecoration.none,
    fontFamily: 'Roboto-Bold',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    height: 27 / 20,
    letterSpacing: 0,
  );

  TextStyle get boldBody => const TextStyle(
    fontSize: 16,
    color: FigmaColors.texticonsPrimaruLight,
    decoration: TextDecoration.none,
    fontFamily: 'Roboto-Bold',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    height: 21.6 / 16,
    letterSpacing: 0,
  );
}
