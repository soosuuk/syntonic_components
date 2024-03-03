part of '../../widgets/syntonic_base_view.dart';

extension SyntonicColorExtension on Color {
  /// Get an alpha color of [Color].
  Color get toAlpha {
    return withAlpha((255 * 12 / 100).round());
  }

  Color get getColorByLuminance {
    if (computeLuminance() < 0.5) {
      return Colors.white;
    }
    return Colors.black87;
  }
}
