import 'package:syntonic_components/configs/constants/syntonic_color.dart';
import 'package:syntonic_components/widgets/syntonic_base_view.dart';
import 'package:flutter/material.dart';

class SyntonicDatePicker {
  DateTime initialDate = DateTime.now();

  ///To get picked date[context, selectedDate].
  Future<DateTime?> show(BuildContext context, DateTime? selectedDate, DateTime? minimumDate, DateTime? maximumDate, bool? hasEntryMode) {
    return showDatePicker(
      context: context,
      initialDate: (selectedDate != null) ? selectedDate : initialDate,
      firstDate: (minimumDate != null) ? minimumDate : DateTime(1920),
      lastDate: (maximumDate != null) ? maximumDate : initialDate.withSomeDateTime(year: initialDate.year + 100),
      initialEntryMode: hasEntryMode == true ? DatePickerEntryMode.calendarOnly : DatePickerEntryMode.calendar,
    );
  }
}