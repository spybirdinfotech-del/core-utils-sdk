import 'package:flutter/material.dart';
import 'package:smartui_components/custom_widget/time_picker_view/time_picker_widget.dart';


class TimePickerDemoScreen extends StatefulWidget {
  const TimePickerDemoScreen({super.key});

  @override
  State<TimePickerDemoScreen> createState() => _TimePickerDemoScreenState();
}

class _TimePickerDemoScreenState extends State<TimePickerDemoScreen> {
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Time Picker Demo")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// START TIME
            CustomTimePickerWidget(
              label: "Start Time",
              selectedTime: startTime,
              onTimeSelected: (time) {
                setState(() {
                  startTime = time;
                  endTime = null;
                });
              },

              /// YOUR DESIGN HERE
              builder: (context, label, time) {
                return _timeVIew(
                    label, time?.format(context) ?? "Select Start Time");
              },
            ),

            const SizedBox(height: 20),

            /// END TIME
            CustomTimePickerWidget(
              label: "End Time",
              selectedTime: endTime,
              onTimeSelected: (time) {
                if (startTime == null) {
                  _error(context, "Please select Start Time first");
                  return;
                }

                final startMin =
                    startTime!.hour * 60 + startTime!.minute;
                final endMin = time.hour * 60 + time.minute;

                if (endMin <= startMin) {
                  _error(context, "End Time must be after Start Time");
                  return;
                }

                setState(() => endTime = time);
              },

              /// YOUR DESIGN HERE
              builder: (context, label, time) {
                return _timeVIew(
                  label,
                  time?.format(context) ?? "Select End Time",
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Your own UI option
  Widget _timeVIew(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }

  void _error(BuildContext context, String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }
}
