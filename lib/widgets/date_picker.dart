import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {
  final Function onDateSelected;
  const DatePicker({super.key, required this.onDateSelected});

  set month(DateTime month) {}

  @override
  Widget build(BuildContext context) {
    DateTime? month;
    DateTime now = DateTime.now();

    onDateChanged(DateTime date) {
      if (month != null) {
        month = null;
      } else {
        onDateSelected(date);
      }
    }

    return CalendarDatePicker(
      initialDate: now.add(const Duration(days: 30)),
      currentDate: now.add(const Duration(days: 30)),
      firstDate: now,
      lastDate: DateTime(now.year + 2),
      onDateChanged: onDateChanged,
      onDisplayedMonthChanged: (pickedDate) => {month = pickedDate},
    );
  }
}
