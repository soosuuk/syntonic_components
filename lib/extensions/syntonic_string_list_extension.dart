part of '../../widgets/syntonic_base_view.dart';

extension SyntonicStringListExtension on List<String> {
  /// Combine text strings in [textList] with no space.
  String combineWithNoSpace() {
    String conbinedString = '';
    for (int i = 0; i < this.length; i++) {
      conbinedString += this[i];
    }
    return conbinedString;
  }

  /// Combine text strings in [textList] with comma.
  String combineWithComma() {
    String combinedString = '';
    for (int i = 0; i < this.length; i++) {
      combinedString += this[i] +
          ',' +
          ' ';
    }
    return combinedString.substring(0, combinedString.length - 2);
  }

  /// Combine [from] and [to] with en dash.
  String combineWithEnDash() {
    String combinedString = '';
    for (int i = 0; i < this.length; i++) {
      combinedString += this[i] +
          ' ' +
          '-' +
          ' ';
    }
    return combinedString.substring(0, combinedString.length - 3);
  }

  /// Combine text strings in [textList] with space.
  String combineWithSpace() {
    String combinedString = '';
    for (int i = 0; i < this.length; i++) {
      combinedString += this[i] + ' ';
    }
    return combinedString;
  }

  /// Combine text strings in [textList] with middle dot.
  String combineWithMiddleDot() {
    String combinedString = '';
    for (int i = 0; i < this.length; i++) {
      combinedString += this[i] + '・';
    }
    return combinedString.substring(0, combinedString.length - 1);
  }

  /// Combine [index] and [value] with colon.
  String combineWithColon() {
    String combinedString = '';
    for (int i = 0; i < this.length; i++) {
      combinedString += this[i] +
          '' +
          ':' +
          ' ';
    }
    return combinedString.substring(0, combinedString.length - 2);
  }

  /// Combine [index] and [value] with colon.
  String combineWithSlash() {
    String combinedString = '';
    for (int i = 0; i < this.length; i++){
      combinedString += this[i] + '' + '/' + ' ';
    }
    return combinedString.substring(0, combinedString.length - 2);
  }

  /// Combine text strings in [textList] with >.
  String combineWithArrow() {
    String combinedString = '';
    for (int i = 0; i < this.length; i++) {
      combinedString += this[i] +
          '>' +
          ' ';
    }
    return combinedString.substring(0, combinedString.length - 2);
  }
}
