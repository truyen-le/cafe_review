import 'package:cafe_review/constant/colors.dart';
import 'package:flutter/material.dart';

final ThemeData themeLight = ThemeData(
  scaffoldBackgroundColor: AppColors.background,
  backgroundColor: AppColors.background,
  primaryColor: AppColors.primary,
  primaryColorDark: AppColors.secondary,
  accentColor: AppColors.shade[10],
  dividerColor: AppColors.shade[60],
  errorColor: AppColors.error,
  canvasColor: Colors.transparent,
  textTheme: TextTheme(
    headline1: TextStyle(
      color: AppColors.shade[90],
      fontFamily: 'Nunito',
      fontSize: 20.0,
    ),
    headline2: TextStyle(
      color: AppColors.shade[90],
      fontFamily: 'Nunito',
      fontSize: 20.0,
    ),
    headline3: TextStyle(
      color: AppColors.shade[90],
      fontFamily: 'Nunito',
      fontSize: 20.0,
    ),
    headline4: TextStyle(
      color: AppColors.shade[90],
      fontFamily: 'Nunito',
      fontSize: 18.0,
    ),
    headline5: TextStyle(
      color: AppColors.shade[90],
      fontFamily: 'Nunito',
      fontSize: 18.0,
    ),
    headline6: TextStyle(
      color: AppColors.shade[90],
      fontFamily: 'Nunito',
      fontSize: 18.0,
    ),
    bodyText1: TextStyle(
      color: AppColors.shade[90],
      fontFamily: 'Nunito',
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    ),
    bodyText2: TextStyle(
      color: AppColors.shade[90],
      fontFamily: 'Nunito',
      fontSize: 16.0,
    ),
    subtitle1: TextStyle(
      color: AppColors.shade[60],
      fontFamily: 'Nunito',
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
    ),
    subtitle2: TextStyle(
      color: AppColors.shade[60],
      fontFamily: 'Nunito',
      fontSize: 14.0,
    ),
    caption: TextStyle(
      color: AppColors.shade[60],
      fontFamily: 'Nunito',
      fontSize: 14.0,
    ),
    button: TextStyle(
      color: AppColors.shade[90],
      fontFamily: 'Nunito',
      fontSize: 14.0,
    ),
    overline: TextStyle(
      color: AppColors.shade[90],
      fontFamily: 'Nunito',
      fontSize: 14.0,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      color: AppColors.shade[90],
      fontFamily: 'Nunito',
      fontSize: 16.0,
    ),
    hintStyle: TextStyle(
      color: AppColors.shade[40],
      fontFamily: 'Nunito',
      fontSize: 14.0,
    ),
    contentPadding: const EdgeInsets.all(8.0),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.shade[40]!),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.primary),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.shade[40]!),
    ),
    fillColor: AppColors.background,
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) => AppColors.primary),
    checkColor:
        MaterialStateProperty.resolveWith((states) => AppColors.background),
  ),
  cardTheme: CardTheme(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    color: AppColors.background,
    shadowColor: AppColors.shade[60],
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.pressed)) {
          return TextStyle(
            color: AppColors.background,
            fontFamily: 'Nunito',
            fontSize: 16.0,
          );
        } else if (states.contains(MaterialState.disabled)) {
          return TextStyle(
            color: AppColors.shade[40],
            fontFamily: 'Nunito',
            fontSize: 16.0,
          );
        }
        return TextStyle(
          color: AppColors.shade[40],
          fontFamily: 'Nunito',
          fontSize: 16.0,
        );
      }),
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.pressed)) {
          return AppColors.primary;
        } else if (states.contains(MaterialState.disabled)) {
          return AppColors.shade[60];
        }
        return AppColors.primary;
      }),
      overlayColor: MaterialStateColor.resolveWith(
          (states) => AppColors.background.withOpacity(0.38)),
      shape: MaterialStateProperty.resolveWith(
        (states) => RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.resolveWith(
        (states) => TextStyle(
          color: AppColors.primary,
          fontFamily: 'Nunito',
          fontSize: 16.0,
        ),
      ),
      backgroundColor:
          MaterialStateProperty.resolveWith((states) => Colors.transparent),
      foregroundColor:
          MaterialStateProperty.resolveWith((states) => AppColors.primary),
      overlayColor: MaterialStateColor.resolveWith(
          (states) => AppColors.primary.withOpacity(0.38)),
    ),
  ),
);
