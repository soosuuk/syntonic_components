part of '../../widgets/syntonic_base_view.dart';

extension SyntonicDateTimeRangeExtension on DateTimeRange {

  String formatDateRange(BuildContext context,) {
    final locale = Localizations.localeOf(context).toString();
    // initializeMessages(locale);

    final DateFormat monthDayWeekFormat = DateFormat('E, MMMM d', locale);
    final DateFormat dayWeekFormat = DateFormat('E, d', locale);
    final DateFormat fullDateFormat = DateFormat('E, MMMM d, y', locale);

    if (start.year != end.year) {
      // 年を跨ぐ場合
      return '${fullDateFormat.format(start)} - ${fullDateFormat.format(end)}';
    } else if (start.month != end.month) {
      // 月を跨ぐ場合
      final String startFormat = (start.year == DateTime.now().year) ? monthDayWeekFormat.format(start) : fullDateFormat.format(start);
      return '$startFormat - ${fullDateFormat.format(end)}';
    } else {
      // 同じ月の場合
      final String startFormat = (start.year == DateTime.now().year) ? monthDayWeekFormat.format(start) : fullDateFormat.format(start);
      final String endFormat = (start.year == DateTime.now().year) ? dayWeekFormat.format(end) : fullDateFormat.format(end);
      return '$startFormat - $endFormat';
    }
  }

  String formatStartDate(BuildContext context,) {
    final locale = Localizations.localeOf(context).toString();
    // initializeMessages(locale);

    final DateFormat monthDayWeekFormat = DateFormat('E, MMMM d', locale);
    final DateFormat dayWeekFormat = DateFormat('E, d', locale);
    final DateFormat fullDateFormat = DateFormat('E, MMMM d, y', locale);

    if (start.year != end.year) {
      // 年を跨ぐ場合
      return fullDateFormat.format(start);
    } else if (start.month != end.month) {
      // 月を跨ぐ場合
      final String startFormat = (start.year == DateTime.now().year) ? monthDayWeekFormat.format(start) : fullDateFormat.format(start);
      return startFormat;
    } else {
      // 同じ月の場合
      final String startFormat = (start.year == DateTime.now().year) ? monthDayWeekFormat.format(start) : fullDateFormat.format(start);
      final String endFormat = (start.year == DateTime.now().year) ? dayWeekFormat.format(end) : fullDateFormat.format(end);
      return startFormat;
    }
  }

  String formatEndDate(BuildContext context,) {
    final locale = Localizations.localeOf(context).toString();
    // initializeMessages(locale);

    final DateFormat monthDayWeekFormat = DateFormat('E, MMMM d', locale);
    final DateFormat dayWeekFormat = DateFormat('E, d', locale);
    final DateFormat fullDateFormat = DateFormat('E, MMMM d, y', locale);

    if (start.year != end.year) {
      // 年を跨ぐ場合
      return fullDateFormat.format(end);
    } else if (start.month != end.month) {
      // 月を跨ぐ場合
      final String startFormat = (start.year == DateTime.now().year) ? monthDayWeekFormat.format(start) : fullDateFormat.format(start);
      return fullDateFormat.format(end);
    } else {
      // 同じ月の場合
      final String startFormat = (start.year == DateTime.now().year) ? monthDayWeekFormat.format(start) : fullDateFormat.format(start);
      final String endFormat = (start.year == DateTime.now().year) ? dayWeekFormat.format(end) : fullDateFormat.format(end);
      return endFormat;
    }
  }

  // /// Format a [dateTime] to string (yyyy/MM/dd).
  // String toText({bool needsTime = false}) {
  //   if (needsTime) {
  //     return [start.toDateTime(), end.toDateTime()].combineWithEnDash();
  //   } else {
  //     return [
  //       LocalizationService().localize.date_format_ymd(start),
  //       LocalizationService().localize.date_format_ymd(end)
  //     ].combineWithEnDash();
  //   }
  // }
  //
  // /// Get time range.
  // TimeRange get toTimeRange {
  //   return TimeRange(
  //       start: TimeOfDay(hour: start.hour, minute: start.minute),
  //       end: TimeOfDay(hour: end.hour, minute: end.minute));
  // }
  //
  // /// To list of [DateTime].
  // List<DateTime> get toList {
  //   List<DateTime> _dateTimes = [];
  //
  //   for (int i = 0; i < end.difference(start).inDays + 2; i++) {
  //     _dateTimes.add(DateTime(start.year, start.month, start.day + i));
  //   }
  //
  //   return _dateTimes;
  // }
  //
  // /// Whether a [DateTimeRange] has range?
  // bool get hasRange {
  //   return end.difference(start).inMinutes > 0;
  // }
}
