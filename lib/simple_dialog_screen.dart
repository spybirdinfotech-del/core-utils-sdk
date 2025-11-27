import 'package:smartui_components/dialog/alert_dialog_cubit.dart';
import 'package:flutter/material.dart';

class SimpleDialogScreen extends StatelessWidget {
  const SimpleDialogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dialogCubit = AlertDialogCubit(); // create manually

    return Scaffold(
      appBar: AppBar(title: const Text("Direct Dialog Demo")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            dialogCubit.showDialogBox(
              context: context,
              title: "Delete File",
              content: "Are you sure you want to delete this file?",
              buttonNames: ["Cancel", "Delete"],
              buttonTextStyles: [
                const TextStyle(color: Colors.grey),
                const TextStyle(color: Colors.red),
              ],
              buttonActions: [
                    () => debugPrint("Cancel clicked"),
                    () => debugPrint("Delete confirmed"),
              ],
            );
          },
          child: const Text("Show Dialog"),
        ),
      ),
    );
  }
}
