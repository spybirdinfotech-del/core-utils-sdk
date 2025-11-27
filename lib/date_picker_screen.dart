import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smartui_components/custom_widget/date_picker_view/custom_date_picker_widget.dart';

class DatePickerScreen extends StatefulWidget {
  const DatePickerScreen({super.key});

  @override
  State<DatePickerScreen> createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {
  DateTime? startDate;
  DateTime? endDate;
  DateTime? dob;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [

          SizedBox(height: 20),
          CustomDatePickerWidget(
            label: "Pick Date",
            firstDate: DateTime(2020),
            lastDate: DateTime(2030),
            initialDate: DateTime.now(),
            onDateSelected: (date) {
              if (kDebugMode) {
                print("Selected: $date");
              }
            },
          ),

          SizedBox(height: 20),
          CustomDatePickerWidget(
            label: "Select Range",
            isRangePicker: true,
            firstDate: DateTime(2022),
            lastDate: DateTime(2035),
            initialDate: DateTime.now(),
            onRangeSelected: (start, end) {
              if (kDebugMode) {
                print("Start: $start → End: $end");
              }
            },
            onValidationFailed: (msg) {
              if (kDebugMode) {
                print("Error: $msg");
              }
            },
          ),

          /// -------- DOB --------
          CustomDatePickerWidget(
            label: "Date of Birth",
            selectedDate: dob,
            firstDate: DateTime(1900),
            lastDate: DateTime.now(), // no future
            onDateSelected: (d) {
              setState(() => dob = d);
            },
          ),

          const SizedBox(height: 20),

          /// -------- START DATE --------
          CustomDatePickerWidget(
            label: "Start Date",
            selectedDate: startDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            onDateSelected: (d) {
              setState(() {
                startDate = d;
                endDate = null; // reset end date
              });
            },
          ),

          const SizedBox(height: 20),

          /// -------- END DATE --------
          CustomDatePickerWidget(
            label: "End Date",
            selectedDate: endDate,
            firstDate: startDate ?? DateTime(2000),
            lastDate: DateTime(2100),
            onDateSelected: (d) {
              if (startDate == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select Start Date first")));
                return;
              }

              if (d.isBefore(startDate!)) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("End Date cannot be before Start Date")));
                return;
              }

              setState(() => endDate = d);
            },
          ),

        ],
      ),
    );
  }
}
