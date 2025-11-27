import 'package:flutter/material.dart';

class ToastState {
  final String? title;
  final String? message;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;
  final Color? backgroundColor;
  final Duration duration;
  final Alignment alignment;

  ToastState({
    this.title,
    this.message,
    this.titleStyle,
    this.messageStyle,
    this.backgroundColor,
    this.duration = const Duration(seconds: 2),
    this.alignment = Alignment.bottomCenter,
  });

  ToastState copyWith({
    String? title,
    String? message,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    Color? backgroundColor,
    Duration? duration,
    Alignment? alignment,
  }) {
    return ToastState(
      title: title ?? this.title,
      message: message ?? this.message,
      titleStyle: titleStyle ?? this.titleStyle,
      messageStyle: messageStyle ?? this.messageStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      duration: duration ?? this.duration,
      alignment: alignment ?? this.alignment,
    );
  }
}
