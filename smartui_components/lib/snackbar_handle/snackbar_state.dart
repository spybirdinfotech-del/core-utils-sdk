import 'package:smartui_components/snackbar_handle/snackbar_cubit.dart';
import 'package:flutter/cupertino.dart';

class SnackbarState {
  final String? title;
  final TextStyle? titleStyle;
  final String? content;
  final TextStyle? contentStyle;
  final List<SnackbarButton>? buttons;
  final Color? bgColor;
  final Duration? duration;
  final ShapeBorder? shape;

  SnackbarState({
    this.title,
    this.titleStyle,
    this.content,
    this.contentStyle,
    this.buttons,
    this.bgColor,
    this.duration,
    this.shape,
  });
}
