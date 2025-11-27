import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'alert_dialog_state.dart';

class AlertDialogCubit extends Cubit<AlertDialogState> {
  AlertDialogCubit() : super(AlertDialogInitial());

  void showDialogBox({
    required BuildContext context,
    required String title,
    TextStyle? titleStyle,
    required String content,
    TextStyle? contentStyle,
    required List<String> buttonNames,
    List<TextStyle>? buttonTextStyles,
    List<VoidCallback>? buttonActions,
  }) {
    emit(AlertDialogShowing());

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(title, style: titleStyle ?? const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          content: Text(content, style: contentStyle ?? const TextStyle(fontSize: 16)),
          actions: List.generate(buttonNames.length, (index) {
            return TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (buttonActions != null && buttonActions.length > index) {
                  buttonActions[index]();
                }
              },
              child: Text(
                buttonNames[index],
                style: buttonTextStyles != null && buttonTextStyles.length > index
                    ? buttonTextStyles[index]
                    : const TextStyle(color: Colors.blue, fontSize: 16),
              ),
            );
          }),
        );
      },
    ).then((_) {
      emit(AlertDialogClosed());
    });
  }
}
