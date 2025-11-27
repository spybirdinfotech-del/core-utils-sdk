import 'dart:io';

abstract class ImagePickerState {}

class ImagePickerInitial extends ImagePickerState {}

class ImagePickerLoading extends ImagePickerState {}

class ImagePickerSuccess extends ImagePickerState {
  final List<File> files;
  ImagePickerSuccess(this.files);
}

class ImagePickerError extends ImagePickerState {
  final String message;
  ImagePickerError(this.message);
}
