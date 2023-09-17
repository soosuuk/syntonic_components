import 'package:syntonic_components/configs/constants/syntonic_color.dart';
import 'package:syntonic_components/widgets/icons/syntonic_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../configs/themes/syntonic_text_theme.dart';

enum OutlinedTextFieldType {
  Normal,
  Obscure,
}

enum TextFieldTheme {
  outlined,
  underline,
}

class SyntonicTextField extends StatelessWidget {
  /// [errorMessage] is display to below the text field.
  /// [label] is a name of the text field.
  /// [value] is entered texts.
  /// If you need to set height of the text field, set a number into [maxLines] or [minLines].
  /// If you need to left or right padding, set true into [hasPadding].
  /// [onTextChanged] is called when focused out from the text field .
  String? errorMessage;
  String? helperText;
  @required
  String? label;
  @required
  String? value;
  int? maxLines;
  int minLines;
  bool hasPadding = false;
  @required late Function(String text) onTextChanged;
  @required late OutlinedTextFieldType outlinedTextFieldType;
  FormFieldValidator<String>? validator;
  TextInputType? keyboardType;
  TextInputAction? textInputAction;
  List<TextInputFormatter>? inputFormatters;
  TextEditingController? controller;
  bool isEnabled = true;
  bool needsMasking = false;
  int? itemKey;
  TextFieldTheme? theme;
  TextStyle? textStyle;
  String? hintText;

  /// Normal.
  SyntonicTextField._(
      {required this.label,
      required this.onTextChanged,
      required this.value,
      this.errorMessage,
      this.maxLines,
      this.minLines = 1,
      this.hasPadding = true,
      this.helperText,
      this.validator,
      this.textInputAction = TextInputAction.done,
      this.keyboardType,
      this.inputFormatters,
      this.controller,
      this.isEnabled = true,
        this.needsMasking = false,
      this.itemKey,
        this.theme = TextFieldTheme.outlined,
        this.textStyle,
        this.hintText,
      }) {
    textInputAction = (minLines > 1) ? TextInputAction.newline : TextInputAction.done;

    if (needsMasking) {
      outlinedTextFieldType = OutlinedTextFieldType.Obscure;
    } else {
      outlinedTextFieldType = OutlinedTextFieldType.Normal;
    }
  }

  SyntonicTextField.outlined({String? label,
    required Function(String text) onTextChanged,
    required String? value,
    String? errorMessage,
    int? maxLines,
    int minLines = 1,
    bool hasPadding = true,
    String? helperText,
    FormFieldValidator<String>? validator,
    TextInputAction? textInputAction = TextInputAction.done,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    TextEditingController? controller,
    bool isEnabled = true,
    bool needsMasking = false,
    int? itemKey,
    TextFieldTheme? theme,
    TextStyle? textStyle,
    String? hintText,
  }) : this._(label: label,
      onTextChanged: onTextChanged,
      value: value,
      errorMessage: errorMessage,
      maxLines: maxLines,
      minLines: minLines,
      hasPadding: hasPadding,
      helperText: helperText,
      validator: validator,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      controller: controller,
      isEnabled: isEnabled,
      needsMasking: needsMasking,
      itemKey: itemKey,
      theme: theme,
      textStyle: textStyle,
      hintText: hintText);

  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
        create: (context) => OutlinedTextFieldManager(),
        child: Consumer<OutlinedTextFieldManager>(
            builder: (context, model, child) {
          return Container(
            padding:
                this.hasPadding ? EdgeInsets.only(left: 16, right: 16) : null,
            child: getTextFormField(context, model),
          );
        }));
  }

  /// Get text form field depends on [outlinedTextFieldType].
  Widget getTextFormField(
      BuildContext context, OutlinedTextFieldManager outlinedTextFieldManager) {
    final controller = new TextEditingController();

    // set value of the text fields.
    controller.text = this.value ?? '';

    // set cursor position at the end of the value.
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));

    switch (this.outlinedTextFieldType) {
      case OutlinedTextFieldType.Normal:
        return TextFormField(
          key: PageStorageKey(itemKey),
          enabled: this.isEnabled,
          controller: this.controller ?? controller,
          maxLines: this.maxLines,
          minLines: this.minLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            labelText: label,
            errorText: errorMessage,
            helperText: helperText,
            border: theme == TextFieldTheme.outlined ? OutlineInputBorder() : InputBorder.none,
            suffixIcon: this.errorMessage != null
                ? SyntonicIcon(icon: Icons.error, color: SyntonicColor.torch_red)
                : null,
          ),
          textInputAction: this.textInputAction,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          onFieldSubmitted: (text) {
            this.onTextChanged(text);
          },
          onChanged: (text) {
            this.onTextChanged(text);
          },
          style: textStyle ?? null,
        );
        break;
      case OutlinedTextFieldType.Obscure:
        return Stack(alignment: Alignment.centerRight, children: [
          TextFormField(
            key: PageStorageKey(itemKey),
            controller: controller,
            validator: validator,
            obscureText: !outlinedTextFieldManager.isVisible,
            decoration: InputDecoration(
              hintText: hintText,
              labelText: label,
              errorText: errorMessage,
              border: theme == TextFieldTheme.outlined ? OutlineInputBorder() : InputBorder.none,
            ),
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (text) {
              this.onTextChanged(text);
            },
            onChanged: (text) {
              this.onTextChanged(text);
            },
            style: textStyle ?? null,
          ),
          Positioned(
            top: 6,
            right: 0,
            child: IconButton(
              icon: Icon(!outlinedTextFieldManager.isVisible
                  ? Icons.visibility_off
                  : Icons.visibility),
              onPressed: () {
                this.value = controller.text;
                outlinedTextFieldManager.changeTextVisibilityState();
              },
            ),
          ),
        ]);
    }
  }
}

class OutlinedTextFieldManager extends ChangeNotifier {
  bool isVisible = false;

  /// Change visibility state.
  void changeTextVisibilityState() {
    isVisible = !isVisible;
    notifyListeners();
  }
}
