part of '../../widgets/syntonic_base_view.dart';

extension SyntonicDateTimeExtension on DateTime {
  /// Format a [dateTime] to string (yyyy/MM/dd).
  String toDate() {
    var formatter = DateFormat(
        (year == 0000)
            ? SyntonicDateAndTime.mm_dd_with_slash
            : SyntonicDateAndTime.yyyy_mm_dd_with_slash,
        SyntonicLanguage.japanese);
    var formatted = formatter.format(this);
    return formatted;
  }

  /// Format a [dateTime] to string (MM/dd).
  String toDateMonthDay() {
    var formatter = DateFormat(
        SyntonicDateAndTime.mm_dd_with_slash, SyntonicLanguage.japanese);
    var formatted = formatter.format(this);
    return formatted;
  }

  /// Format [dateTime] to string (HH:mm).
  String toTime() {
    var formatter = DateFormat(
        SyntonicDateAndTime.hh_mm_with_colon, SyntonicLanguage.japanese);
    var formatted = formatter.format(this);
    return formatted;
  }

  /// Format [dateTime] to string (yyyy/MM/dd HH:mm am/pm).
  String toDateTime() {
    var formatter = DateFormat(
        SyntonicDateAndTime.yyyy_mm_dd_with_slash_and_hh_mm_with_colon,
        SyntonicLanguage.japanese);
    var formatted = formatter.format(this);
    return formatted;
  }

  /// Format [dateTime] to string (dayofweek, MMMM day).
  String toDayOfWeekMonthDay() {
    var formatter = DateFormat(
        SyntonicDateAndTime.dayofweek_month_day, SyntonicLanguage.english);
    var formatted = formatter.format(this);
    return formatted;
  }

  /// Format a [dayOfWeek] to string (EEE).
  String toDayOfWeek() {
    var formatter =
        DateFormat(SyntonicDateAndTime.day_of_week, SyntonicLanguage.japanese);
    var formatted = formatter.format(this);
    return formatted;
  }

  /// Get new [DateTime] with [year] or [month] or [day] or [hour] or [minute].
  DateTime withSomeDateTime(
      {int? year, int? month, int? day, int? hour, int? minute}) {
    return DateTime(year ?? this.year, month ?? this.month, day ?? this.day,
        hour ?? this.hour, minute ?? this.minute);
  }

  /// Convert to [TimeOfDay].
  TimeOfDay toTimeOfDay() {
    return TimeOfDay(hour: hour, minute: minute);
  }

  /// Whether the time is across 2 days.
  bool isAcrossTwoDays(DateTime other) {
    Duration _duration = difference(other);
    return _duration.inHours < 0;
  }

  /// Get a formatted [String] of [DateTime] (yyyy-MM-dd).
  get toHyphen => DateFormat('yyyy-MM-dd').format(this);
}
