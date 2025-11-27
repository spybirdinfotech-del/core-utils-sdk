import 'package:flutter/material.dart';

class ToastConfig {
  static final ToastConfig _instance = ToastConfig._internal();

  factory ToastConfig() => _instance;

  ToastConfig._internal();

  Color backgroundColor = Colors.black87;
  TextStyle titleStyle = const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16);
  TextStyle messageStyle = const TextStyle(color: Colors.white70, fontSize: 14);
  Duration duration = const Duration(seconds: 2);
  Alignment alignment = Alignment.bottomCenter;

  /// Call this once when app starts to apply your custom global styles
  void init({
    Color? backgroundColor,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    Duration? duration,
    Alignment? alignment,
  }) {
    if (backgroundColor != null) this.backgroundColor = backgroundColor;
    if (titleStyle != null) this.titleStyle = titleStyle;
    if (messageStyle != null) this.messageStyle = messageStyle;
    if (duration != null) this.duration = duration;
    if (alignment != null) this.alignment = alignment;
  }
}
