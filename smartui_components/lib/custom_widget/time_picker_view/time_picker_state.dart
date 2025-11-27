import 'package:flutter/material.dart';

class TimePickerState {
  final TimeOfDay? selectedTime;

  final TimeOfDay? startTime;
  final TimeOfDay? endTime;

  final bool isRange;

  final String? errorMessage;

  const TimePickerState({
    this.selectedTime,
    this.startTime,
    this.endTime,
    this.errorMessage,
    this.isRange = false,
  });

  TimePickerState copyWith({
    TimeOfDay? selectedTime,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    String? errorMessage,
    bool? isRange,
  }) {
    return TimePickerState(
      selectedTime: selectedTime ?? this.selectedTime,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      errorMessage: errorMessage,
      isRange: isRange ?? this.isRange,
    );
  }
}
