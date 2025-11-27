import 'package:smartui_components/custom_widget/date_picker_view/custom_date_picker_theme.dart';
import 'package:smartui_components/custom_widget/date_picker_view/date_picker_theme_config.dart';
import 'package:flutter/material.dart';

class CustomDatePickerWidget extends StatelessWidget {
  final String label;
  final DateTime? selectedDate;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isRangePicker;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialDate;
  final CustomDatePickerTheme? theme;
  final Function(DateTime)? onDateSelected;
  final Function(DateTime start, DateTime end)? onRangeSelected;
  final Function(String msg)? onValidationFailed;
  final Widget Function(BuildContext context, String label, String value)?
  customBuilder;
  final Future<DateTime?> Function(BuildContext)? customSinglePicker;
  final Future<DateTimeRange?> Function(BuildContext)? customRangePicker;

  const CustomDatePickerWidget({
    super.key,
    required this.label,
    this.isRangePicker = false,
    this.theme,
    this.selectedDate,
    this.startDate,
    this.endDate,
    this.firstDate,
    this.lastDate,
    this.initialDate,
    this.onDateSelected,
    this.onRangeSelected,
    this.onValidationFailed,
    this.customBuilder,
    this.customSinglePicker,
    this.customRangePicker,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () => _openPicker(context), child: _box(context));
  }

  Widget _box(BuildContext context) {
    String value = "Select";

    if (isRangePicker) {
      if (startDate != null && endDate != null) {
        value =
        "${startDate!.toString().split(' ').first} → ${endDate!.toString().split(' ').first}";
      }
    } else {
      value = selectedDate?.toString().split(' ').first ?? "Select";
    }

    if (customBuilder != null) {
      return customBuilder!(context, label, value);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: theme?.backgroundColor ?? Colors.white,
        borderRadius: theme?.dialogShape is RoundedRectangleBorder
            ? (theme?.dialogShape as RoundedRectangleBorder).borderRadius
            : theme?.radius ?? BorderRadius.circular(10),
        border: Border.all(color: theme?.headerColor ?? Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: theme?.dateTextStyle),
          Text(value, style: theme?.headerTextStyle),
        ],
      ),
    );
  }

  Future<void> _openPicker(BuildContext context) async {
    if (!isRangePicker) {
      return _pickSingleDate(context);
    } else {
      return _pickDateRange(context);
    }
  }

  // ---------------- SINGLE DATE PICK ----------------
  Future<void> _pickSingleDate(BuildContext context) async {
    final picked = customSinglePicker != null
        ? await customSinglePicker!(context)
        : await showDatePicker(
      context: context,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime.now(),
      initialDate: selectedDate ?? initialDate ?? DateTime.now(),
      builder: (context, child) => _applyTheme(context, child),
    );

    if (picked != null) onDateSelected?.call(picked);
  }

  // ---------------- RANGE DATE PICK ----------------
  Future<void> _pickDateRange(BuildContext context) async {
    if (customRangePicker != null) {
      final range = await customRangePicker!(context);
      if (range != null) {
        if (range.end.isBefore(range.start)) {
          onValidationFailed?.call("End date cannot be before Start date");
        } else {
          onRangeSelected?.call(range.start, range.end);
        }
      }
      return;
    }

    final range = await showDateRangePicker(
      context: context,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2100),
      initialDateRange: (startDate != null && endDate != null)
          ? DateTimeRange(start: startDate!, end: endDate!)
          : null,
      builder: (context, child) => _applyTheme(context, child),
    );

    if (range == null) return;

    if (range.end.isBefore(range.start)) {
      onValidationFailed?.call("End date cannot be before Start date");
      return;
    }

    onRangeSelected?.call(range.start, range.end);
  }

  // ---------------- APPLY THEME ----------------
  Widget _applyTheme(BuildContext context, Widget? child) {
    final t = DatePickerThemeConfig.theme;

    return Theme(
      data: Theme.of(context).copyWith(
        datePickerTheme: DatePickerThemeData(
          backgroundColor: t.backgroundColor,
          elevation: t.elevation,
          shadowColor: t.shadowColor,
          surfaceTintColor: t.surfaceTintColor,
          shape: t.shape,
          headerBackgroundColor: t.headerBackgroundColor,
          headerForegroundColor: t.headerForegroundColor,
          headerHeadlineStyle: t.headerHeadlineStyle,
          headerHelpStyle: t.headerHelpStyle,
          weekdayStyle: t.weekdayStyle,
          dayStyle: t.dayStyle,
          dayForegroundColor: t.dayForegroundColor,
          dayBackgroundColor: t.dayBackgroundColor,
          dayOverlayColor: t.dayOverlayColor,
          dayShape: t.dayShape,
          todayForegroundColor: t.todayForegroundColor,
          todayBackgroundColor: t.todayBackgroundColor,
          todayBorder: t.todayBorder,
          yearStyle: t.yearStyle,
          yearForegroundColor: t.yearForegroundColor,
          yearBackgroundColor: t.yearBackgroundColor,
          yearOverlayColor: t.yearOverlayColor,
          yearShape: t.yearShape,
          rangePickerBackgroundColor: t.rangePickerBackgroundColor,
          rangePickerElevation: t.rangePickerElevation,
          rangePickerShadowColor: t.rangePickerShadowColor,
          rangePickerSurfaceTintColor: t.rangePickerSurfaceTintColor,
          rangePickerShape: t.rangePickerShape,
          rangePickerHeaderBackgroundColor: t.rangePickerHeaderBackgroundColor,
          rangePickerHeaderForegroundColor: t.rangePickerHeaderForegroundColor,
          rangePickerHeaderHeadlineStyle: t.rangePickerHeaderHeadlineStyle,
          rangePickerHeaderHelpStyle: t.rangePickerHeaderHelpStyle,
          rangeSelectionBackgroundColor: t.rangeSelectionBackgroundColor,
          rangeSelectionOverlayColor: t.rangeSelectionOverlayColor,
          dividerColor: t.dividerColor,
          inputDecorationTheme: t.inputDecorationTheme,
          cancelButtonStyle: t.cancelButtonStyle,
          confirmButtonStyle: t.confirmButtonStyle,
          locale: t.locale,
          toggleButtonTextStyle: t.toggleButtonTextStyle,
          subHeaderForegroundColor: t.subHeaderForegroundColor,
        ),
        dialogTheme: DialogThemeData(
          backgroundColor: t.backgroundColor,
          shape: t.dialogShape ??
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
      ),
      child: child!,
    );
  }
}
