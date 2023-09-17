// part of '../../widgets/syntonic_base_view.dart';
//
// extension SyntonicTimeOfDayExtension on TimeOfDay {
//
//   /// Convert to [DateTime].
//   /// The time is treated as next day, depending on [other].
//   DateTime toDateTime({TimeOfDay? other}) {
//     bool _isAcrossTwoDays = false;
//     if (other != null) {
//       DateTime _other = other.toDateTime();
//       _isAcrossTwoDays = toDateTime().isBefore(_other);
//     }
//
//     return DateTime(0, 0, _isAcrossTwoDays ? 1 : 0, hour, minute);
//   }
//
//   /// Format to string (HH:mm).
//   String toTime() {
//     DateFormat formatter = DateFormat(DateAndTime.hh_mm_with_colon, Language.japanese);
//     return formatter.format(toDateTime());
//   }
//
//   /// Whether the time included in [timeRange].
//   bool isIncludedIn(TimeRange timeRange) {
//     DateTime _target = toDateTime();
//     DateTime _start = timeRange.start!.toDateTime();
//     DateTime _end = timeRange.end!.toDateTime();
//     bool _isAcrossTwoDays = _end.isBefore(_start);
//
//     // Check across 2 days (when end time of range is over 23:59).
//     if (_isAcrossTwoDays) {
//       _end = timeRange.end!.toDateTime(other: timeRange.start!);
//     }
//
//     // Generate span of hours.
//     // Because it is to check whether the time is over 23:59,
//     // when end time of range is over 23:59.
//     // Treat As next day, If the time over 23:59.
//     final List<int> _hours = [];
//     int _hourSpan = _end.difference(_start).inHours;
//     for (int i = timeRange.start!.hour;
//         i < timeRange.start!.hour + _hourSpan + 1;
//         i++) {
//       int _hour = i;
//       if (_hour > 23) {
//         _hour = i - 24;
//       }
//       _hours.add(_hour);
//     }
//
//     if (_isAcrossTwoDays) {
//       List<int> _trimmedHours = _hours.sublist(_hours.indexOf(0));
//       if (_trimmedHours.contains(hour)) {
//         _target = DateTime(0, 0, 1, hour, minute);
//       }
//     }
//
//     // print(_target);
//     // print(_start);
//     // print(_end);
//     // print(_hours);
//     // print(_target.isAfter(_start) && _target.isBefore(_end));
//
//     if (_target.isAtSameMomentAs(_start) || _target.isAtSameMomentAs(_end)) {
//       return true;
//     } else {
//       return _target.isAfter(_start) && _target.isBefore(_end);
//     }
//   }
//
//   /// Get whether a [TimeOfDay] is over [TimeRange.start].
//   /// true: 0:00, 23:00 - 1:00
//   /// true: 3:00, 18:00 - 12:00
//   /// false: 23:00, 10:00 - 19:00
//   bool isOverDay({required TimeRange timeRange}) {
//     if (timeRange.isAcrossTwoDays && timeRange.start!.hour > hour) {
//       return hour > 0;
//     } else {
//       return false;
//     }
//   }
//
//   /// Whether same time.
//   isSameTimeAs({required TimeOfDay other}) {
//     return toDateTime().isAtSameMomentAs(other.toDateTime());
//   }
//
//   /// Get interval time between a [TimeOfDay] and [other].
//   int difference(TimeOfDay other) {
//     if (TimeRange(start: other, end: this).isAcrossTwoDays) {
//       return (hour * 60 + minute) + ((24 - other.hour) * 60 + other.minute);
//     } else {
//       return (hour * 60 + minute) - (other.hour * 60 + other.minute);
//     }
//   }
//
//   /// Get text formatted by "hh:mm".
//   String get toText {
//     var _numberFormat = NumberFormat("00");
//     return _numberFormat.format(hour) + ":" + _numberFormat.format(minute);
//   }
// }
