import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'time_picker_state.dart';

class TimePickerCubit extends Cubit<TimePickerState> {
  TimePickerCubit({required bool range})
      : super(TimePickerState(isRange: range));

  void selectTime(TimeOfDay time) {
    emit(state.copyWith(selectedTime: time, errorMessage: null));
  }

  void selectStart(TimeOfDay time) {
    emit(state.copyWith(startTime: time, errorMessage: null));
  }

  void selectEnd(TimeOfDay time) {
    final start = state.startTime;

    if (start != null) {
      final startMin = start.hour * 60 + start.minute;
      final endMin = time.hour * 60 + time.minute;

      if (endMin < startMin) {
        emit(state.copyWith(errorMessage: "End time cannot be earlier"));
        return;
      }
    }

    emit(state.copyWith(endTime: time, errorMessage: null));
  }
}
