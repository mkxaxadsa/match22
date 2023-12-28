import 'package:flutter/material.dart';

class MyTheme {
  static const Color white = Color(0xFFFCFCFC);
  static const Color grey = Color(0xFFBDBDBD);
  static const Color black = Color(0xFF111111);

  static ThemeData get theme => ThemeData(
        scaffoldBackgroundColor: white,
        primaryColor: const Color(0xFFF6B40B),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: white,
            fontWeight: FontWeight.w700,
            fontSize: 32,
          ),
          displayMedium: TextStyle(
            color: white,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
          displaySmall: TextStyle(
            color: white,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      );
}

extension BuildContextExt on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  ThemeData get theme => Theme.of(this);
}
