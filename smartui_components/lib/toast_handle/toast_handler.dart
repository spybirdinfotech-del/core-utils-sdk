import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'toast_cubit.dart';
import 'toast_state.dart';
import 'toast_widget.dart';
import 'toast_config.dart';

class ToastHandler {
  static final ToastHandler _instance = ToastHandler._internal();
  factory ToastHandler() => _instance;
  ToastHandler._internal();

  final ToastCubit _cubit = ToastCubit();

  void show({
    required BuildContext context,
    String? title,
    String? message,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    Color? backgroundColor,
    Duration? duration,
    Alignment? alignment,
  }) {
    final config = ToastConfig();

    final toastData = ToastState(
      title: title,
      message: message,
      titleStyle: titleStyle ?? config.titleStyle,
      messageStyle: messageStyle ?? config.messageStyle,
      backgroundColor: backgroundColor ?? config.backgroundColor,
      duration: duration ?? config.duration,
      alignment: alignment ?? config.alignment,
    );

    _cubit.showToast(toastData);

    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => BlocProvider.value(
        value: _cubit,
        child: BlocBuilder<ToastCubit, ToastState?>(
          builder: (context, state) {
            if (state == null) return const SizedBox.shrink();
            return Material(
              color: Colors.transparent,
              child: ToastWidget(data: state),
            );
          },
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(toastData.duration, () {
      overlayEntry.remove();
      _cubit.hideToast();
    });
  }
}
