import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF2196F3);
  static const primaryVariant = Color(0xFF1976D2);
  static const secondary = Color(0xFF03DAC6);
  static const surface = Color(0xFFFAFAFA);
  static const background = Color(0xFFFFFFFF);
  static const error = Color(0xFFB00020);
  
  static const darkSurface = Color(0xFF121212);
  static const darkBackground = Color(0xFF000000);
  
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: Colors.white,
    secondary: secondary,
    onSecondary: Colors.black,
    error: error,
    onError: Colors.white,
    background: background,
    onBackground: Colors.black87,
    surface: surface,
    onSurface: Colors.black87,
    surfaceVariant: Color(0xFFF5F5F5),
    onSurfaceVariant: Colors.black54,
  );
  
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: primary,
    onPrimary: Colors.white,
    secondary: secondary,
    onSecondary: Colors.black,
    error: error,
    onError: Colors.white,
    background: darkBackground,
    onBackground: Colors.white,
    surface: darkSurface,
    onSurface: Colors.white,
    surfaceVariant: Color(0xFF2C2C2C),
    onSurfaceVariant: Colors.white70,
  );
}
