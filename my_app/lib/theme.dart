import 'dart:ui';

import 'package:flutter/material.dart';

final Color primaryGreen = Color(0xFF135729);
final Color accentGreen = Color(0xFF3EA85C);

final ThemeData myThemeData = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.light,
  primaryColor: primaryGreen,
  accentColor: accentGreen,
  fontFamily: 'Open Sans',
  colorScheme: ColorScheme.light(
    primary: accentGreen,
    primaryVariant: primaryGreen,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
  ),
  buttonTheme: ButtonThemeData(
    colorScheme: ColorScheme.light(primary: accentGreen),
    buttonColor: accentGreen,
  ),
  timePickerTheme: TimePickerThemeData(
    // dayPeriodColor: Color(0xFFB5ECCD),
    // dayPeriodTextColor: accentGreen,
    // dialBackgroundColor: primaryGreen,
    dialHandColor: accentGreen,
    inputDecorationTheme: InputDecorationTheme(
        // focusColor: Color(0xFFB5ECCD),
        ),
  ),
  textTheme: TextTheme(
    headline2: TextStyle(
        fontSize: 59, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    headline3: TextStyle(fontSize: 48, fontWeight: FontWeight.normal),
    headline4: TextStyle(
        fontSize: 34, fontWeight: FontWeight.normal, letterSpacing: 0.25),
    headline5: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
    headline6: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 0.15),
    bodyText1: TextStyle(
        fontSize: 16, fontWeight: FontWeight.normal, letterSpacing: 0.5),
    bodyText2: TextStyle(
        fontSize: 14, fontWeight: FontWeight.normal, letterSpacing: 0.25),
    subtitle1: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    subtitle2: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.1),
    button: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 1.25),
    overline: TextStyle(
        fontSize: 10, fontWeight: FontWeight.normal, letterSpacing: 1.5),
    caption: TextStyle(
        fontSize: 12, fontWeight: FontWeight.normal, letterSpacing: 0.4),
  ),
);
