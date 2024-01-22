import 'package:syntonic_components/configs/constants/syntonic_color.dart';
import 'package:syntonic_components/widgets/icons/syntonic_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
  final String? errorMessage;
  final String? helperText;
  final String? label;
  final String? value;
  final int? maxLines;
  final int minLines;
  final bool hasPadding;
  final Function(String text) onTextChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final bool isEnabled;
  final bool needsMasking;
  final int? itemKey;
  final TextFieldTheme? theme;
  final TextStyle? textStyle;
  final String? hintText;

  TextInputAction? get _textInputAction => textInputAction ?? ((minLines > 1) ? TextInputAction.newline : TextInputAction.done);
  OutlinedTextFieldType get outlinedTextFieldType => needsMasking ? OutlinedTextFieldType.Obscure : OutlinedTextFieldType.Normal;

  /// Normal.
  const SyntonicTextField._(
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
      });

  const SyntonicTextField.outlined({String? label,
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

  static final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // set value of the text fields.
    // _controller.text = value ?? '';

    // set cursor position at the end of the value.
    // _controller.selection = TextSelection.fromPosition(
    //     TextPosition(offset: _controller.text.length));

    return RepaintBoundary(child: Padding(padding: hasPadding ? const EdgeInsets.symmetric(vertical: 8, horizontal: 16) : EdgeInsets.zero, child: TextFormField(
      key: PageStorageKey(itemKey),
      initialValue: value,
      enabled: isEnabled,
      // controller: controller ?? _controller,
      maxLines: maxLines,
      minLines: minLines,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: label,
        errorText: errorMessage,
        helperText: helperText,
        border: theme == TextFieldTheme.outlined ? const OutlineInputBorder() : InputBorder.none,
        suffixIcon: errorMessage != null
            ? const SyntonicIcon(icon: Icons.error, color: SyntonicColor.torch_red)
            : null,
      ),
      textInputAction: _textInputAction,
      keyboardType: maxLines != null ? TextInputType.multiline : keyboardType,
      inputFormatters: inputFormatters,
      onFieldSubmitted: (text) {
        onTextChanged(text);
      },
      onChanged: (text) {
        onTextChanged(text);
      },
      style: textStyle,
    ),),);

    return ListenableProvider(
        create: (context) => OutlinedTextFieldManager(),
        child: Consumer<OutlinedTextFieldManager>(
            builder: (context, model, child) {
              return Padding(padding: hasPadding ? const EdgeInsets.only(left: 16, right: 16) : EdgeInsets.zero, child: getTextFormField(context, model),);
        }));
  }

  /// Get text form field depends on [outlinedTextFieldType].
  Widget getTextFormField(
      BuildContext context, OutlinedTextFieldManager outlinedTextFieldManager) {

    // set value of the text fields.
    _controller.text = value ?? '';

    // set cursor position at the end of the value.
    _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length));

    switch (outlinedTextFieldType) {
      case OutlinedTextFieldType.Normal:
        return TextFormField(
          key: PageStorageKey(itemKey),
          enabled: isEnabled,
          controller: controller ?? _controller,
          maxLines: maxLines,
          minLines: minLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            labelText: label,
            errorText: errorMessage,
            helperText: helperText,
            border: theme == TextFieldTheme.outlined ? const OutlineInputBorder() : InputBorder.none,
            suffixIcon: errorMessage != null
                ? const SyntonicIcon(icon: Icons.error, color: SyntonicColor.torch_red)
                : null,
          ),
          textInputAction: _textInputAction,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          onFieldSubmitted: (text) {
            onTextChanged(text);
          },
          onChanged: (text) {
            onTextChanged(text);
          },
          style: textStyle,
        );
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
              border: theme == TextFieldTheme.outlined ? const OutlineInputBorder() : InputBorder.none,
            ),
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (text) {
              onTextChanged(text);
            },
            onChanged: (text) {
              onTextChanged(text);
            },
            style: textStyle,
          ),
          Positioned(
            top: 6,
            right: 0,
            child: IconButton(
              icon: Icon(!outlinedTextFieldManager.isVisible
                  ? Icons.visibility_off
                  : Icons.visibility),
              onPressed: () {
                // value = controller.text;
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
