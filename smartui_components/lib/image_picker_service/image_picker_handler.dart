import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SdkImagePickerHandler {
  static final ImagePicker _picker = ImagePicker();

  /// Pick image from gallery
  static Future<File?> pickImageFromGallery() async {
    final XFile? file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (file == null) return null;
    return File(file.path);
  }

  /// Pick image from camera
  static Future<File?> pickImageFromCamera() async {
    final XFile? file = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );

    if (file == null) return null;
    return File(file.path);
  }

  /// Pick video from gallery
  static Future<File?> pickVideoFromGallery() async {
    final XFile? file = await _picker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(minutes: 5),
    );

    if (file == null) return null;
    return File(file.path);
  }

  /// Pick video from camera
  static Future<File?> pickVideoFromCamera() async {
    final XFile? file = await _picker.pickVideo(
      source: ImageSource.camera,
      maxDuration: const Duration(minutes: 5),
    );

    if (file == null) return null;
    return File(file.path);
  }
}
