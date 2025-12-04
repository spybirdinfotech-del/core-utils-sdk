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
  final dynamic disableBorder;
  final dynamic focusErrorBorder;
  final dynamic enableBorder;
  final Color? cursorColor;
  final double? cursorHeight;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final bool? filled;


  const CustomTextFieldTheme({
    this.fontFamily,
    this.labelStyle,
    this.textStyle,
    this.errorStyle,
    this.hintStyle,
    this.border,
    this.errorBorder,
    this.focusBorder,
    this.disableBorder,
    this.focusErrorBorder,
    this.enableBorder,
    this.cursorColor,
    this.cursorHeight,
    this.contentPadding,
    this.fillColor,
    this.filled,
  });
}
