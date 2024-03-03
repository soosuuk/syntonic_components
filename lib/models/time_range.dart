// import 'package:syntonic_components/widgets/syntonic_base_view.dart';
// import 'package:flutter/material.dart';
//
// class TimeRange {
//   TimeOfDay? end;
//   TimeOfDay? start;
//
//   TimeRange({this.end, this.start});
//
//   /// Copy data (Deep copy).
//   ///
//   /// Because dart does not have how to copy for deeply, have to create new
//   /// instance of model instead of deep copy.
//   TimeRange copyWith() {
//     TimeRange _timeRange = TimeRange();
//     _timeRange.end = end;
//     _timeRange.start = start;
//     return _timeRange;
//   }
//
//   @override
//   String toString() {
//     return [start != null ? start!.toTime() : "00:00", end != null ? end!.toTime() : "00:00"].combineWithEnDash();
//   }
//
//   /// "Enabled" means both of [start] and [end] is exist.
//   bool isEnabled() {
//     return end != null && start != null;
//   }
//
//   Iterable<TimeOfDay> toList(Duration interval) sync* {
//     bool _isAcrossTwoDays = end!.toDateTime().isAcrossTwoDays(start!.toDateTime());
//       var hour = start!.hour;
//       var minute = start!.minute;
//       do {
//         yield TimeOfDay(hour: (_isAcrossTwoDays && hour > 23) ? hour - 24 : hour, minute: minute);
//         minute += interval.inMinutes;
//         while (minute >= 60) {
//           minute -= 60;
//           hour++;
//         }
//       } while ((_isAcrossTwoDays) ? hour - 24  < end!.hour : hour < end!.hour);
//
//   }
//
//   /// Whether a [TimeRange] is across two days.
//   bool get isAcrossTwoDays {
//     return end!.toDateTime().isAcrossTwoDays(start!.toDateTime());
//   }
// }
