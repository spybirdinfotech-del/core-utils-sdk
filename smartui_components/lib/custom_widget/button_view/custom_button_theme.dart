import 'package:flutter/material.dart';

class CustomButtonTheme {
  final double? height;
  final double? width;
  final Color? buttonColor;
  final TextStyle? buttonTextStyle;
  final BorderRadiusGeometry? borderRadius;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;
  final BoxShape? shape;

  const CustomButtonTheme({
    this.height,
    this.width,
    this.buttonColor,
    this.buttonTextStyle,
    this.borderRadius,
    this.gradient,
    this.boxShadow,
    this.border,
    this.shape,
  });
}
