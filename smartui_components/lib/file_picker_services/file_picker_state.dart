import 'dart:io';

abstract class FilePickerState {}

class FilePickerInitial extends FilePickerState {}

class FilePickerLoading extends FilePickerState {}

class FilePickerSuccess extends FilePickerState {
  final List<File> files;
  FilePickerSuccess(this.files);
}

class FilePickerError extends FilePickerState {
  final String message;
  FilePickerError(this.message);
}
