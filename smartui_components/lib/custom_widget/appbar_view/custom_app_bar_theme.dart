import 'package:flutter/material.dart';

class CustomAppBarTheme {
  final Color? bgColor;
  final Color? surfaceTintColor;
  final Color? titleTextColor;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final double? fontSize;
  final void Function()? backOnTap;
  final IconData? icon;
  final double? elevation;

  const CustomAppBarTheme({
    this.bgColor,
    this.surfaceTintColor,
    this.titleTextColor,
    this.fontFamily,
    this.fontWeight,
    this.fontSize,
    this.backOnTap,
    this.icon,
    this.elevation
  });
}
