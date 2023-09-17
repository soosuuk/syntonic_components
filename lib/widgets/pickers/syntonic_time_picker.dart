import 'package:syntonic_components/configs/constants/syntonic_color.dart';
import 'package:syntonic_components/widgets/syntonic_base_view.dart';
import 'package:flutter/material.dart';

class SyntonicTimePicker {
  TimeOfDay initialTime = TimeOfDay.now();
  TimeOfDay? pickedTime;

  ///To get picked time[context, selectedTime].
  Future<TimeOfDay?> show(BuildContext context, DateTime? selectedTime) {
    if (selectedTime != null) {
      pickedTime = TimeOfDay(hour: selectedTime.hour, minute: selectedTime.minute);
    }

    return showTimePicker(context: context, initialTime: pickedTime ?? initialTime, builder: (context, child) => MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!));
  }
}
