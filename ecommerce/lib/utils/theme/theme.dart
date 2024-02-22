import 'package:flutter/material.dart';
import 'package:ecommerce/utils/theme/custom_themes/text_theme.dart';
import 'package:ecommerce/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:ecommerce/utils/theme/custom_themes/appbar_theme.dart';
import 'package:ecommerce/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:ecommerce/utils/theme/custom_themes/chekbox_theme.dart';
import 'package:ecommerce/utils/theme/custom_themes/chip_theme.dart';
import 'package:ecommerce/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:ecommerce/utils/theme/custom_themes/text_field_theme.dart';

class TAppTheme {
  TAppTheme._();
  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      primaryColor: Colors.cyanAccent,
      scaffoldBackgroundColor: Colors.white,
      textTheme: TTextTheme.lightTextTheme,
      chipTheme: TChipTheme.lightChipTheme,
      appBarTheme: TAppBarTheme.lightAppBarTheme,
      checkboxTheme: TCheckBoxTheme.lightCheckBoxTheme,
      bottomSheetTheme: TBottomSheet.lightBottomSheetTheme,
      elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
      outlinedButtonTheme: TOutLinedButtonTheme.lightOutLinedButtonTheme,
      inputDecorationTheme: TTexFromFieldTheme.lightInputDecorationTheme);
  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      primaryColor: Colors.cyanAccent,
      scaffoldBackgroundColor: Colors.black,
      textTheme: TTextTheme.darkTextTheme,
      chipTheme: TChipTheme.darkChipTheme,
      appBarTheme: TAppBarTheme.darkAppBarTheme,
      checkboxTheme: TCheckBoxTheme.darkCheckBoxTheme,
      bottomSheetTheme: TBottomSheet.darkBottomSheetTheme,
      elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
      outlinedButtonTheme: TOutLinedButtonTheme.darkOutLinedButtonTheme,
      inputDecorationTheme: TTexFromFieldTheme.darkInputDecorationTheme);
}
