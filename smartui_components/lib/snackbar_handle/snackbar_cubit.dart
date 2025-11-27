import 'package:smartui_components/snackbar_handle/snackbar_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SnackbarButton {
  final String name;
  final VoidCallback onPressed;
  final ButtonStyle? style;

  SnackbarButton({
    required this.name,
    required this.onPressed,
    this.style,
  });
}

class SnackbarCubit extends Cubit<SnackbarState?> {
  SnackbarCubit() : super(null);

  void showSnackbar({
    required String title,
    TextStyle? titleStyle,
    required String content,
    TextStyle? contentStyle,
    List<SnackbarButton>? buttons,
    Color? bgColor,
  }) {
    emit(SnackbarState(
      title: title,
      titleStyle: titleStyle,
      content: content,
      contentStyle: contentStyle,
      buttons: buttons,
      bgColor: bgColor,
    ));
  }

  void clear() => emit(null);
}
