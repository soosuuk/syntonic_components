part of '../../widgets/syntonic_base_view.dart';

extension SyntonicDateTimeRangeExtension on DateTimeRange {
  String formatDateRange(
      BuildContext context,
      ) {
    // Use Japanese formatting explicitly
    const String jaLocale = 'ja';

    final DateFormat monthDayWeekFormat = DateFormat('M月d日(E)', jaLocale);
    final DateFormat dayWeekFormat = DateFormat('d日(E)', jaLocale);
    final DateFormat fullDateFormat = DateFormat('y年M月d日(E)', jaLocale);

    if (start.year != end.year) {
      // 年を跨ぐ場合: 年を含めて表示
      return '${fullDateFormat.format(start)} - ${fullDateFormat.format(end)}';
    } else if (start.month != end.month) {
      // 月を跨ぐ場合: 年が今年であれば年を省略
      final String startFormat = (start.year == DateTime.now().year)
          ? monthDayWeekFormat.format(start)
          : fullDateFormat.format(start);
      final String endFormat = (end.year == DateTime.now().year)
          ? monthDayWeekFormat.format(end)
          : fullDateFormat.format(end);
      return '$startFormat - $endFormat';
    } else if (start.day != end.day) {
      // 同じ月で異なる日付: 開始はM月d日、終了は日付のみ(d日)
      final String startFormat = (start.year == DateTime.now().year)
          ? monthDayWeekFormat.format(start)
          : fullDateFormat.format(start);
      final String endFormat = (end.year == DateTime.now().year)
          ? dayWeekFormat.format(end)
          : fullDateFormat.format(end);
      return '$startFormat - $endFormat';
    } else {
      // 同じ日: 年が今年なら年を省略して表示
      return (start.year == DateTime.now().year)
          ? monthDayWeekFormat.format(start)
          : fullDateFormat.format(start);
    }
  }

      String formatStartDate(
    BuildContext context,
  ) {
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
      final String startFormat = (start.year == DateTime.now().year)
          ? monthDayWeekFormat.format(start)
          : fullDateFormat.format(start);
      return startFormat;
    } else {
      // 同じ月の場合
      final String startFormat = (start.year == DateTime.now().year)
          ? monthDayWeekFormat.format(start)
          : fullDateFormat.format(start);
      final String endFormat = (start.year == DateTime.now().year)
          ? dayWeekFormat.format(end)
          : fullDateFormat.format(end);
      return startFormat;
    }
  }

  String formatEndDate(
    BuildContext context,
  ) {
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
      final String startFormat = (start.year == DateTime.now().year)
          ? monthDayWeekFormat.format(start)
          : fullDateFormat.format(start);
      return fullDateFormat.format(end);
    } else {
      // 同じ月の場合
      final String startFormat = (start.year == DateTime.now().year)
          ? monthDayWeekFormat.format(start)
          : fullDateFormat.format(start);
      final String endFormat = (start.year == DateTime.now().year)
          ? dayWeekFormat.format(end)
          : fullDateFormat.format(end);
      return endFormat;
    }
  }

  List<DateTime> toList() {
    // Create date-only versions (midnight) for start and end to detect calendar-day boundaries.
    final DateTime startDateOnly = DateTime(start.year, start.month, start.day);
    final DateTime endDateOnly = DateTime(end.year, end.month, end.day);

    final int dayCount = endDateOnly.difference(startDateOnly).inDays;
    if (dayCount < 0) return [];

    List<DateTime> dateTimes = [];
    for (int i = 0; i <= dayCount; i++) {
      dateTimes.add(startDateOnly.add(Duration(days: i)));
    }
    return dateTimes;
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
