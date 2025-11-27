import 'dart:io';
import 'package:file_picker/file_picker.dart';

class SdkFilePickerHandler {
  static Future<File?> pickAnyFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null || result.files.isEmpty) return null;

    return File(result.files.single.path!);
  }

  static Future<File?> pickImageFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result == null || result.files.isEmpty) return null;

    return File(result.files.single.path!);
  }

  static Future<File?> pickVideoFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result == null || result.files.isEmpty) return null;

    return File(result.files.single.path!);
  }

  static Future<List<File>> pickMultipleFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result == null || result.files.isEmpty) return [];

    return result.paths.map((path) => File(path!)).toList();
  }
}
