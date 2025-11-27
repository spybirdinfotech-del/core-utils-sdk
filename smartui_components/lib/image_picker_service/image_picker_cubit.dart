import 'dart:io';

import 'package:smartui_components/image_picker_service/image_picker_handler.dart';
import 'package:smartui_components/image_picker_service/image_picker_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit() : super(ImagePickerInitial());

  /// pick Image from gallery
  Future<File?> pickImageOnGallery() async {
    emit(ImagePickerLoading());

    try {
      final file = await SdkImagePickerHandler.pickImageFromGallery();
      if (file == null) {
        emit(ImagePickerError("No file selected"));
        return null;
      } else {
        emit(ImagePickerSuccess([file]));
        return file;
      }
    } catch (e) {
      emit(ImagePickerError(e.toString()));
      return null;
    }
  }

  /// Pick image from camera
  Future<File?> pickImageOnCamera() async {
    emit(ImagePickerLoading());

    try {
      final file = await SdkImagePickerHandler.pickImageFromCamera();
      if (file == null) {
        emit(ImagePickerError("No image selected"));
        return null;
      } else {
        emit(ImagePickerSuccess([file]));
        return file;
      }
    } catch (e) {
      emit(ImagePickerError(e.toString()));
      return null;
    }
  }

  /// Pick video From camera
  Future<File?> pickVideoOnCamera() async {
    emit(ImagePickerLoading());

    try {
      final file = await SdkImagePickerHandler.pickVideoFromCamera();
      if (file == null) {
        emit(ImagePickerError("No video selected"));
        return null;
      } else {
        emit(ImagePickerSuccess([file]));
        return file;
      }
    } catch (e) {
      emit(ImagePickerError(e.toString()));
      return null;
    }
  }

  /// Pick video From gallery
  Future<File?> pickVideoOnGallery() async {
    emit(ImagePickerLoading());

    try {
      final file = await SdkImagePickerHandler.pickVideoFromGallery();
      if (file == null) {
        emit(ImagePickerError("No video selected"));
        return null;
      } else {
        emit(ImagePickerSuccess([file]));
        return file;
      }
    } catch (e) {
      emit(ImagePickerError(e.toString()));
      return null;
    }
  }
}
