import 'package:syntonic_components/configs/constants/syntonic_color.dart';
import 'package:syntonic_components/widgets/syntonic_base_view.dart';
import 'package:flutter/material.dart';

class SyntonicDateRangePicker {
  ///To get picked date range [context, selectedDate].
  Future<DateTimeRange?> show(
    BuildContext context,
    DateTimeRange? selectedDateTimeRange,
  ) {
    // var brightness = SchedulerBinding.instance.window.platformBrightness;
    // bool _isDarkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return showDateRangePicker(
        context: context,
        firstDate: DateTime(1920),
        initialDateRange: selectedDateTimeRange,
        lastDate:
            DateTime.now().withSomeDateTime(year: DateTime.now().year + 100),
        builder: (BuildContext context, Widget? child) {
          return child!;
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: SyntonicColor.black4,
                onSurface: SyntonicColor.primary_color,
                onPrimary: SyntonicColor.primary_color,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor:
                      SyntonicColor.primary_color, // button text color
                ),
              ),
            ),
            child: child!,
          );
        });
  }
}
