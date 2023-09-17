part of '../../widgets/syntonic_base_view.dart';

extension SyntonicDoubleExtension on double {

  // /// Format a [this] to format of amount.
  // String toAmount() {
  //   String formattedText = LocalizationService().localize.monetary_unit + _toThousandsSeparator(value: this);
  //   return this < 0 ? LocalizationService().localize.en_dash + ' ' + formattedText : formattedText;
  // }

  /// Format a [this] with thousands separator.
  String _toThousandsSeparator({required double value}) {
    final formatter = NumberFormat("#,###");
    return formatter.format(value >= 0 ? value : value * -1);
  }
}