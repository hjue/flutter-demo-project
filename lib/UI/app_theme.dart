import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get data {
    return ThemeData(
      textTheme: TextTheme(
        headline1: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20.0,
        ),
        subtitle1: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
