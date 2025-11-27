import 'dart:io';

import 'package:smartui_components/file_picker_services/sdk_file_picker_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'file_picker_state.dart';

class FilePickerCubit extends Cubit<FilePickerState> {
  FilePickerCubit() : super(FilePickerInitial());

  /// Pick any file
  Future<File?> pickAnyFile() async {
    emit(FilePickerLoading());

    try {
      final file = await SdkFilePickerHandler.pickAnyFile();
      if (file == null) {
        emit(FilePickerError("No file selected"));
        return null;
      } else {
        emit(FilePickerSuccess([file]));
        return file;
      }
    } catch (e) {
      emit(FilePickerError(e.toString()));
      return null;
    }
  }

  /// Pick image only
  Future<File?> pickImageFile() async {
    emit(FilePickerLoading());

    try {
      final file = await SdkFilePickerHandler.pickImageFile();
      if (file == null) {
        emit(FilePickerError("No image selected"));
         return null;
      } else {
        emit(FilePickerSuccess([file]));
        return file;
      }
    } catch (e) {
      emit(FilePickerError(e.toString()));
       return null;
    }
  }

  /// Pick video only
  Future<File?> pickVideoFile() async {
    emit(FilePickerLoading());

    try {
      final file = await SdkFilePickerHandler.pickVideoFile();
      if (file == null) {
        emit(FilePickerError("No video selected"));
         return null;
      } else {
        emit(FilePickerSuccess([file]));
        return file;
      }
    } catch (e) {
      emit(FilePickerError(e.toString()));
       return null;
    }
  }

  /// Pick multiple files
  Future<List<File>?> pickMultipleFiles() async {
    emit(FilePickerLoading());

    try {
      final files = await SdkFilePickerHandler.pickMultipleFiles();
      if (files.isEmpty) {
        emit(FilePickerError("No files selected"));
         return null;
      } else {
        emit(FilePickerSuccess(files));
        return files;
      }
    } catch (e) {
      emit(FilePickerError(e.toString()));
       return null;
    }
  }
}
