import 'package:smartui_components/snackbar_handle/snackbar_cubit.dart';
import 'package:smartui_components/snackbar_handle/snackbar_handler.dart';
import 'package:flutter/material.dart';
import 'package:smartui_components/toast_handle/toast_handler.dart';

class SimpleSnackbarScreen extends StatelessWidget {
  const SimpleSnackbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Snackbar Demo')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              SnackbarHandler.success(context, 'Success!',"Profile saved successfully!", buttons: [
                SnackbarButton(
                  name: 'OK',
                  onPressed: () => debugPrint('OK pressed'),
                  style: TextButton.styleFrom(foregroundColor: Colors.blue),
                ),
              ],);
             /* SnackbarHandler.show(
                context,
                title: 'Success!',
                content: 'Data saved successfully.',
                bgColor: Colors.white,
                buttons: [
                  SnackbarButton(
                    name: 'OK',
                    onPressed: () => debugPrint('OK pressed'),
                    style: TextButton.styleFrom(foregroundColor: Colors.blue),
                  ),
                ],
              );*/
            },
            child: const Text('Show Snackbar'),
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () {
              ToastHandler().show(
                context: context,
                title: "Warning",
                message: "Please fill all fields!",
              );
            },
            child: const Text('Show Toast'),
          ),
        ],
      ),
    );
  }
}
