part of '../../widgets/syntonic_base_view.dart';

extension SyntonicStringExtension on String {
  /// Capitalize [this] text.
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    // return "${substring(0, 1).toUpperCase()}${substring(1).toLowerCase()}";
    return "${substring(0, 1)}${substring(1)}";
  }

  /// Get initial text of [this] text.
  String getInitial() {
    return substring(0, 1);
  }

  /// Get final text of [this] text.
  String getFinal() {
    return substring(length - 1);
  }

  /// Convert from Base64 to [Image].
  Image toImage() {
    return Image.memory(base64Decode(split(',').last));
  }

  /// Format a [text] with brackets.
  String withBrackets() {
    return '($this)';
  }

  /// Format a [text] with quotation mark.
  String withQuotationMark() {
    return '"$this"';
  }

  /// Convert from String"HH:mm" to TimeOfDay(HH:mm).
  TimeOfDay toTimeOfDay() {
    return TimeOfDay(
        hour: int.parse(split(":")[0]), minute: int.parse(split(":")[1]));
  }
}
