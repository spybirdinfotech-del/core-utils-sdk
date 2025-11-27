import 'package:flutter_bloc/flutter_bloc.dart';
import 'toast_state.dart';

class ToastCubit extends Cubit<ToastState?> {
  ToastCubit() : super(null);

  void showToast(ToastState toastData) {
    emit(toastData);
  }

  void hideToast() {
    emit(null);
  }
}

