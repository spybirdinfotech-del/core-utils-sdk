import 'package:smartui_components/file_picker_services/file_picker_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FilePickerScreen extends StatelessWidget {
  const FilePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 15,
        children: [
          //Pick Any File
          ElevatedButton(
            onPressed: () async {
              final file = await FilePickerCubit().pickAnyFile();

              if (file != null) {
                if (kDebugMode) {
                  print("Selected file: ${file.path}");
                }
              } else {
                if (kDebugMode) {
                  print("No file selected");
                }
              }
            },
            child: Text('Pick Any File'),
          ),
          ElevatedButton(
            onPressed: () async {
              final file = await FilePickerCubit().pickImageFile();

              if (file != null) {
                if (kDebugMode) {
                  print("Selected image: ${file.path}");
                }
              }
            },
            child: Text('Pick Only Image'),
          ),
          ElevatedButton(
            onPressed: () async {
              final file = await FilePickerCubit().pickVideoFile();

              if (file != null) {
                if (kDebugMode) {
                  print("Selected video: ${file.path}");
                }
              }
            },
            child: Text('Pick Only video'),
          ),
          ElevatedButton(
            onPressed: () async {
              final files = await FilePickerCubit().pickMultipleFiles();

              if (files!.isNotEmpty) {
                if (kDebugMode) {
                  print("Selected ${files.length} files");
                }
              }
            },
            child: Text('Pick Multiple Files'),
          ),
        ],
      ),
    );
  }
}
