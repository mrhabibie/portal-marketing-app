import 'package:flutter/material.dart';

import 'theme.dart';

ThemeData themeLight = ThemeData(
  primaryColor: Pallet.primary,
  colorScheme: ThemeData().colorScheme.copyWith(
        primary: Pallet.primary,
      ),
);

ThemeData themeDark = ThemeData(
  primaryColor: Pallet.primary,
  colorScheme: ThemeData().colorScheme.copyWith(
        primary: Pallet.primary,
        brightness: Brightness.dark,
      ),
);

class TextStyles {
  TextStyles._();

  static TextStyle get title1 => TextStyle(
        fontSize: AppDimension.style48,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        color: Pallet.neutral900,
      );

  static TextStyle get title2 => TextStyle(
        fontSize: AppDimension.style32,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        color: Pallet.neutral900,
      );

  static TextStyle get title3 => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style24,
        color: Pallet.neutral900,
        fontWeight: FontWeight.bold,
      );

  //LARGE NONE
  static TextStyle get largeNoneBold => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style18,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get largeNoneMedium => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style18,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get largeNoneRegular => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style18,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w400,
      );

  //LARGE TIGHT
  static TextStyle get largeTightBold => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style18,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get largeTightMedium => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style18,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get largeTightRegular => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style18,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w400,
      );

  // LARGE NORMAL
  static TextStyle get largeNormalBold => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style18,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get largeNormalMedium => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style18,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get largeNormalRegular => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style18,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w400,
      );

  // REGULAR NONE
  static TextStyle get regularNoneBold => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style16,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get regularNoneMedium => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style16,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get regularNoneRegular => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style16,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w400,
      );

  // REGULAR TIGHT
  static TextStyle get regularTightBold => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style16,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get regularTightMedium => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style16,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get regularTightRegular => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style16,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w400,
      );

  // REGULAR NORMAL
  static TextStyle get regularNormalBold => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style16,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get regularNormalMedium => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style16,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get regularNormalRegular => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style16,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w400,
      );

  // SMALL NONE
  static TextStyle get smallNoneBold => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style14,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get smallNoneMedium => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style14,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get smallNoneMediumRed => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style14,
        color: Pallet.primary500,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get smallNoneRegular => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style14,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w400,
      );

  // SMALL TIGHT
  static TextStyle get smallTightBold => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style14,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get smallTightMedium => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style14,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get smallTightRegular => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style14,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w400,
      );

  // SMALL NORMAL
  static TextStyle get smallNormalBold => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style14,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get smallNormalMedium => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style14,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get smallNormalRegular => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style14,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w400,
      );

  // TINY NONE
  static TextStyle get tinyNoneBold => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style12,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get tinyNoneMedium => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style12,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get tinyNoneRegular => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style12,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get tinyNoneRegularLight => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style12,
        color: Pallet.neutral100,
        fontWeight: FontWeight.w400,
      );

  // TINY TIGHT
  static TextStyle get tinyTightBold => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style12,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get tinyTightMedium => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style12,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get tinyTightRegular => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style12,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w400,
      );

  // TINY NORMAL
  static TextStyle get tinyNormalBold => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style12,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get tinyNormalMedium => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style12,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get tinyNormalRegular => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style12,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w400,
      );

//  PRICE STYLE
  static TextStyle get price => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style12,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get description10 => TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: AppDimension.style10,
        color: Pallet.neutral900,
        fontWeight: FontWeight.w400,
      );
}
