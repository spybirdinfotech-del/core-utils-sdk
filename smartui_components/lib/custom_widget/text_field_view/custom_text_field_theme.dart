import 'package:flutter/material.dart';

class CustomTextFieldTheme {
  final String? fontFamily;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final TextStyle? errorStyle;
  final TextStyle? hintStyle;
  final dynamic border;
  final dynamic errorBorder;
  final dynamic focusBorder;
  final dynamic enableBorder;
  final Color? cursorColor;
  final double? cursorHeight;
  final EdgeInsetsGeometry? contentPadding;


  const CustomTextFieldTheme({
    this.fontFamily,
    this.labelStyle,
    this.textStyle,
    this.errorStyle,
    this.hintStyle,
    this.border,
    this.errorBorder,
    this.focusBorder,
    this.enableBorder,
    this.cursorColor,
    this.cursorHeight,
    this.contentPadding,
  });
}
