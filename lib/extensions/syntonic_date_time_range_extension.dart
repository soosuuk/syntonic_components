// part of '../../widgets/syntonic_base_view.dart';
//
// extension SyntonicDateTimeRangeExtension on DateTimeRange {
//   /// Format a [dateTime] to string (yyyy/MM/dd).
//   String toText({bool needsTime = false}) {
//     if (needsTime) {
//       return [start.toDateTime(), end.toDateTime()].combineWithEnDash();
//     } else {
//       return [
//         LocalizationService().localize.date_format_ymd(start),
//         LocalizationService().localize.date_format_ymd(end)
//       ].combineWithEnDash();
//     }
//   }
//
//   /// Get time range.
//   TimeRange get toTimeRange {
//     return TimeRange(
//         start: TimeOfDay(hour: start.hour, minute: start.minute),
//         end: TimeOfDay(hour: end.hour, minute: end.minute));
//   }
//
//   /// To list of [DateTime].
//   List<DateTime> get toList {
//     List<DateTime> _dateTimes = [];
//
//     for (int i = 0; i < end.difference(start).inDays + 2; i++) {
//       _dateTimes.add(DateTime(start.year, start.month, start.day + i));
//     }
//
//     return _dateTimes;
//   }
//
//   /// Whether a [DateTimeRange] has range?
//   bool get hasRange {
//     return end.difference(start).inMinutes > 0;
//   }
// }
