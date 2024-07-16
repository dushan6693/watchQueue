import 'package:flutter/material.dart';

class ColorProfile {
  // Light theme color scheme
  static const light = ColorScheme(
    primary: Color(0xFF007678),
    secondary: Color(0xFF03DAC6),
    surface: Color(0xFF35BCBF),
    background: Color(0xFFFFFFFF),
    error: Color(0xFFB00020),
    outline: Color(0xFFB26D6D),
    onPrimary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFFD3D3D3),
    onSurface: Color(0xFF000000),
    onBackground: Color(0xFF000000),
    onError: Color(0xFFA25353),
    brightness: Brightness.light,
  );

  // Dark theme color scheme
  static const dark = ColorScheme(
    primary: Color(0xFF007678),
    secondary: Color(0xFF03DAC6),
    surface: Color(0xFF263849),
    background: Color(0xFF212121),
    error: Color(0xFFCF6679),
    outline: Color(0xFFFF9F9F),
    onPrimary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFF808080),
    onSurface: Color(0xFFFFFFFF),
    onBackground: Color(0xFFFFFFFF),
    onError: Color(0xFFB00020),
    brightness: Brightness.dark,
  );


}