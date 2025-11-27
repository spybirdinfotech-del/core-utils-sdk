import 'package:flutter/material.dart';

class SnackbarTheme {
  final Color successColor;
  final Color errorColor;
  final Color warningColor;

  final TextStyle titleStyle;
  final TextStyle contentStyle;
  final TextStyle buttonStyle;
  final double borderRadius;

  const SnackbarTheme({
    this.successColor = const Color(0xFF4CAF50), // green
    this.errorColor = const Color(0xFFF44336),   // red
    this.warningColor = const Color(0xFFFFC107), // yellow
    this.titleStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    this.contentStyle = const TextStyle(
      color: Colors.white,
      fontSize: 14,
    ),
    this.buttonStyle = const TextStyle(
      color: Colors.blue,
      fontSize: 13,
    ),
    this.borderRadius = 12,
  });
}