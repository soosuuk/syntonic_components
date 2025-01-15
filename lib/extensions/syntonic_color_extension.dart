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

  Color get optimalColor {
    double rNorm = red / 255.0;
    double gNorm = green / 255.0;
    double bNorm = blue / 255.0;

    num rLinear =
    rNorm <= 0.03928 ? rNorm / 12.92 : pow((rNorm + 0.055) / 1.055, 2.4);
    num gLinear =
    gNorm <= 0.03928 ? gNorm / 12.92 : pow((gNorm + 0.055) / 1.055, 2.4);
    num bLinear =
    bNorm <= 0.03928 ? bNorm / 12.92 : pow((bNorm + 0.055) / 1.055, 2.4);

    double luminance = 0.2126 * rLinear + 0.7152 * gLinear + 0.0722 * bLinear;

    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
