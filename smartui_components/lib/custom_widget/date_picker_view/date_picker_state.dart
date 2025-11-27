class DatePickerState {
  final DateTime? selectedDate;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isRangeMode;
  final String? errorMessage;

  const DatePickerState({
    this.selectedDate,
    this.startDate,
    this.endDate,
    this.isRangeMode = false,
    this.errorMessage,
  });

  DatePickerState copyWith({
    DateTime? selectedDate,
    DateTime? startDate,
    DateTime? endDate,
    bool? isRangeMode,
    String? errorMessage,
  }) {
    return DatePickerState(
      selectedDate: selectedDate ?? this.selectedDate,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isRangeMode: isRangeMode ?? this.isRangeMode,
      errorMessage: errorMessage,
    );
  }
}
