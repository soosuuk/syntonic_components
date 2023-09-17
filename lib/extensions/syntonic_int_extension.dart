// part of '../../widgets/syntonic_base_view.dart';
//
// extension SyntonicIntExtension on int {
//
//   /// Format a [this] to format of amount.
//   String toAmount() {
//     String formattedText = AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.monetary_unit + _toThousandsSeparator(value: this);
//     return this < 0 ? AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.en_dash + ' ' + formattedText : formattedText;
//   }
//
//   /// Format a [this] to format of amount.
//   String toPoint() {
//     String formattedText = AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.point + _toThousandsSeparator(value: this);
//     return this < 0 ? AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.en_dash + ' ' + formattedText : formattedText;
//   }
//
//   /// Format a [this] for minute.
//   String toMinute() {
//     return this.toString() + AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.minute;
//   }
//
//   /// Format a [this] for number.
//   String toThousanFormat() {
//     return _toThousandsSeparator(value: this);
//   }
//
//   /// Format a [this] for day.
//   String toDay() {
//     switch (this) {
//       case 1:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_1;
//       case 2:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_2;
//       case 3:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_3;
//       case 4:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_4;
//       case 5:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_5;
//       case 6:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_6;
//       case 7:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_7;
//       case 8:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_8;
//       case 9:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_9;
//       case 10:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_10;
//       case 11:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_11;
//       case 12:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_12;
//       case 13:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_13;
//       case 14:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_14;
//       case 15:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_15;
//       case 16:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_16;
//       case 17:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_17;
//       case 18:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_18;
//       case 19:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_19;
//       case 20:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_20;
//       case 21:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_21;
//       case 22:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_22;
//       case 23:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_23;
//       case 24:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_24;
//       case 25:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_25;
//       case 26:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_26;
//       case 27:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_27;
//       case 28:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_28;
//       case 29:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_29;
//       case 30:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_30;
//       case 31:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_31;
//         default:
//           return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.day_1;
//     }
//   }
//
//   DayOfTheWeek toDayOfTheWeek() {
//     switch (this) {
//       case 0:
//         return DayOfTheWeek.monday;
//       case 1:
//         return DayOfTheWeek.tuesday;
//       case 2:
//         return DayOfTheWeek.wednesday;
//       case 3:
//         return DayOfTheWeek.thursday;
//       case 4:
//         return DayOfTheWeek.friday;
//       case 5:
//         return DayOfTheWeek.saturday;
//       case 6:
//         return DayOfTheWeek.sunday;
//       case 7:
//         return DayOfTheWeek.holiday;
//       default:
//         return DayOfTheWeek.monday;
//     }
//   }
//
//   String toMonth() {
//     switch (this) {
//       case 1:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.january;
//       case 2:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.february;
//       case 3:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.march;
//       case 4:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.april;
//       case 5:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.may;
//       case 6:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.june;
//       case 7:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.july;
//       case 8:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.august;
//       case 9:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.september;
//       case 10:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.october;
//       case 11:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.november;
//       case 12:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.december;
//       default:
//         return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!.january;
//     }
//   }
//
//   /// Return negative number.
//   String toNegative() {
//     return '-' + toString();
//   }
//
//   /// Return positive number.
//   String toPositive() {
//     return '+' + toString();
//   }
//
//   /// Format a [this] with thousands separator.
//   String _toThousandsSeparator({required int value}) {
//     final formatter = NumberFormat("#,###");
//     return formatter.format(value >= 0 ? value : value * -1);
//   }
//
//   int toRatio({required int targetValue}) {
//     return (this / targetValue * 100).round();
//   }
//
//   int fromRatio({required int targetValue}) {
//     return (targetValue * this / 100).round();
//   }
// }