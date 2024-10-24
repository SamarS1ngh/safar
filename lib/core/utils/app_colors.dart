import 'package:flutter/material.dart';

class AppColorsTheme extends ThemeExtension<AppColorsTheme> {
  //reference colors
  static final Color _lightOrange = Colors.orange.shade100;
  static const Color _red = Color(0xFFAF0121);
  static const Color _green = Color(0xFF00F318);
  static const Color _orange = Color.fromARGB(255, 255, 153, 0);
  static const Color _white = Color(0xFFFFFFFF);

  //actual colors to be used throughout the app
  final Color primary;
  final Color secondary;
  final Color snackbarValidation;
  final Color snackBarFailure;
  final Color textDefault;

  // private constructor (use factories below instead):
  const AppColorsTheme._internal({
    required this.primary,
    required this.secondary,
    required this.snackbarValidation,
    required this.snackBarFailure,
    required this.textDefault,
  });

//defining light theme
  factory AppColorsTheme.light() {
    return AppColorsTheme._internal(
        primary: _orange,
        secondary: _lightOrange,
        snackbarValidation: _green,
        snackBarFailure: _red,
        textDefault: _white);
  }

  @override
  ThemeExtension<AppColorsTheme> copyWith({bool? lightMode}) {
    if (lightMode == null || lightMode == true) {
      return AppColorsTheme.light();
    }
    return AppColorsTheme.light();
  }

  @override
  ThemeExtension<AppColorsTheme> lerp(
          covariant ThemeExtension<AppColorsTheme>? other, double t) =>
      this;
}
