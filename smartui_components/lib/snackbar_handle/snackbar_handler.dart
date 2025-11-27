import 'package:smartui_components/snackbar_handle/snackbar_theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'snackbar_cubit.dart';
import 'snackbar_listener.dart';

class SnackbarHandler {
  /// Private method to ensure the SnackbarListener & BlocProvider exist
  static Widget setup({required Widget child}) {
    return BlocProvider(
      create: (_) => SnackbarCubit(),
      child: SnackbarListener(child: child),
    );
  }

  /// Public method — simple function to show snackbar from anywhere
  static void show(
    BuildContext context, {
    required String title,
    required String content,
    TextStyle? titleStyle,
    TextStyle? contentStyle,
    List<SnackbarButton>? buttons,
    Color? bgColor,
  }) {
    try {
      context.read<SnackbarCubit>().showSnackbar(
        title: title,
        titleStyle: titleStyle,
        content: content,
        contentStyle: contentStyle,
        buttons: buttons,
        bgColor: bgColor,
      );
    } catch (e) {
      debugPrint('⚠️ SnackbarCubit not found. Wrap your app with SnackbarHandler.setup()');
    }
  }

  static void success(BuildContext context, String title, String message,{List<SnackbarButton>? buttons}) {
    final t = SnackbarThemeConfig.theme;
    show(context, title: title, content: message, bgColor: t.successColor, titleStyle: t.titleStyle, contentStyle: t.contentStyle, buttons: buttons,);
  }

  static void error(BuildContext context, String title, String message,{List<SnackbarButton>? buttons}) {
    final t = SnackbarThemeConfig.theme;
    show(context, title: title, content: message, bgColor: t.errorColor, titleStyle: t.titleStyle, contentStyle: t.contentStyle, buttons: buttons,);
  }

  static void warning(BuildContext context, String title, String message,{List<SnackbarButton>? buttons}) {
    final t = SnackbarThemeConfig.theme;
    show(context, title: title, content: message, bgColor: t.warningColor, titleStyle: t.titleStyle, contentStyle: t.contentStyle, buttons: buttons,);
  }
}
