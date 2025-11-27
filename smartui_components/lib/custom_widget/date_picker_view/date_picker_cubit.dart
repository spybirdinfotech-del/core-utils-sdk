import 'package:flutter_bloc/flutter_bloc.dart';
import 'date_picker_state.dart';

class DatePickerCubit extends Cubit<DatePickerState> {
  DatePickerCubit({bool rangeMode = false})
      : super(DatePickerState(isRangeMode: rangeMode));

  // -------- Single Date Validation (DOB) --------
  void selectDate(DateTime date) {
    if (date.isAfter(DateTime.now())) {
      emit(state.copyWith(errorMessage: "Future dates are not allowed"));
      return;
    }

    emit(state.copyWith(selectedDate: date, errorMessage: null));
  }

  // -------- Range Selection Validation --------
  void selectStartDate(DateTime date) {
    emit(state.copyWith(startDate: date, errorMessage: null));
  }

  void selectEndDate(DateTime date) {
    if (state.startDate != null && date.isBefore(state.startDate!)) {
      emit(state.copyWith(errorMessage: "End Date cannot be before Start Date"));
      return;
    }

    emit(state.copyWith(endDate: date, errorMessage: null));
  }
}
