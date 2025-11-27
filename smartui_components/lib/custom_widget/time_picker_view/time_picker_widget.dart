import 'package:smartui_components/custom_widget/time_picker_view/time_picker_theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'time_picker_cubit.dart';
import 'time_picker_state.dart';

class CustomTimePickerWidget extends StatelessWidget {
  final String label;
  final bool isRangePicker;
  final TimeOfDay? selectedTime;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final Function(TimeOfDay)? onTimeSelected;
  final Function(TimeOfDay, TimeOfDay)? onRangeSelected;
  final Function(String msg)? onError;
  final Widget Function(BuildContext context, String label, String value)? customBuilder;
  final Future<TimeOfDay?> Function(BuildContext)? customSinglePicker;
  final Future<TimeOfDay?> Function(BuildContext)? customStartPicker;
  final Future<TimeOfDay?> Function(BuildContext)? customEndPicker;
  final Widget Function(BuildContext context, String label, TimeOfDay? time)? builder;

  const CustomTimePickerWidget({
    super.key,
    required this.label,
    this.isRangePicker = false,
    this.selectedTime,
    this.startTime,
    this.endTime,
    this.onRangeSelected,
    this.onTimeSelected,
    this.onError,
    this.customBuilder,
    this.customSinglePicker,
    this.customStartPicker,
    this.customEndPicker,
    this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimePickerCubit(range: isRangePicker),
      child: BlocConsumer<TimePickerCubit, TimePickerState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            onError?.call(state.errorMessage!);
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () => _openPicker(context),
            child: builder?.call(context, label, state.selectedTime) ?? _buildBox(context, state),
          );
        },
      ),
    );
  }

  /// ---------------- UI BOX -----------------
  Widget _buildBox(BuildContext context, TimePickerState state) {
    String value = "Select";

    if (!isRangePicker) {
      value = (state.selectedTime ?? selectedTime)?.format(context) ?? "Select";
    } else {
      if ((state.startTime ?? startTime) != null && (state.endTime ?? endTime) != null) {
        value = "${(state.startTime ?? startTime)!.format(context)} → ${(state.endTime ?? endTime)!.format(context)}";
      }
    }

    if (customBuilder != null) {
      return customBuilder!(context, label, value);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
        color: Colors.white,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label), Text(value)]),
    );
  }

  /// ---------------- OPEN PICKER ----------------
  Future<void> _openPicker(BuildContext context) async {
    final cubit = context.read<TimePickerCubit>();

    /// ---------------- SINGLE TIME ----------------
    if (!isRangePicker) {
      final picked = customSinglePicker != null
          ? await customSinglePicker!(context)
          : await _showThemedTimePicker(context, selectedTime ?? TimeOfDay.now());

      if (picked != null) {
        cubit.selectTime(picked);
        onTimeSelected?.call(picked);
      }
      return;
    }

    /// ---------------- RANGE START ----------------
    final start = customStartPicker != null
        ? await customStartPicker!(context)
        : await _showThemedTimePicker(context, TimeOfDay.now());

    if (start == null) return;

    cubit.selectStart(start);

    /// ---------------- RANGE END ----------------
    final end = customEndPicker != null ? await customEndPicker!(context) : await _showThemedTimePicker(context, start);

    if (end == null) return;

    cubit.selectEnd(end);

    /// no error
    if (cubit.state.errorMessage == null) {
      onRangeSelected?.call(start, end);
    }
  }

  Future<TimeOfDay?> _showThemedTimePicker(BuildContext context, TimeOfDay initialTime) async {
    return await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        final t = TimePickerThemeConfig.theme;

        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: t.backgroundColor,
              cancelButtonStyle: t.cancelButtonStyle,
              confirmButtonStyle: t.confirmButtonStyle,
              dayPeriodBorderSide: t.dayPeriodBorderSide,
              dayPeriodColor: t.dayPeriodColor,
              dayPeriodShape: t.dayPeriodShape,
              dayPeriodTextColor: t.dayPeriodTextColor,
              dayPeriodTextStyle: t.dayPeriodTextStyle,
              dialBackgroundColor: t.dialBackgroundColor,
              dialHandColor: t.dialHandColor,
              dialTextColor: t.dialTextColor,
              dialTextStyle: t.dialTextStyle,
              elevation: t.elevation,
              entryModeIconColor: t.entryModeIconColor,
              helpTextStyle: t.helpTextStyle,
              hourMinuteColor: t.hourMinuteColor,
              hourMinuteShape: t.hourMinuteShape,
              hourMinuteTextColor: t.hourMinuteTextColor,
              hourMinuteTextStyle: t.hourMinuteTextStyle,
              inputDecorationTheme: t.inputDecorationTheme,
              padding: t.padding,
              shape: t.shape,
              timeSelectorSeparatorColor: t.timeSelectorSeparatorColor,
              timeSelectorSeparatorTextStyle: t.timeSelectorSeparatorTextStyle,
            ),

            colorScheme: ColorScheme.light(
              primary: t.primaryButtonColor ?? Theme.of(context).primaryColor,
              onPrimary: t.buttonTextColor ?? Colors.white,
              onSurface: Colors.black,
            ),

            dialogTheme: DialogThemeData(
              backgroundColor: t.backgroundColor,
              shape: t.dialogShape ?? RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
          child: child!,
        );
      },
    );
  }
}
