import 'package:flutter/material.dart';

class PermissionTheme {
  final Color contentTextColor;
  final Color titleTextColor;
  final Color buttonTextColor;
  final TextStyle? contentTextStyle;
  final TextStyle? titleTextStyle;
  final TextStyle? buttonTextStyle;

  const PermissionTheme({
    this.contentTextColor = Colors.black,
    this.titleTextColor = Colors.black,
    this.buttonTextColor = Colors.deepPurple,
    this.contentTextStyle,
    this.titleTextStyle,
    this.buttonTextStyle,
  });
}
