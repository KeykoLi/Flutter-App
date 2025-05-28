import 'package:flutter/material.dart';

class AppTheme {
  static const _mint = Color(0xFF00BFA5);
  static const _bg = Color(0xFFFDF5F0);
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: _bg,
    primaryColor: _mint,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: _mint,
      secondary: _mint,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black87),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _bg,
      elevation: 0,
      foregroundColor: Colors.black87,
    ),
  );
}
