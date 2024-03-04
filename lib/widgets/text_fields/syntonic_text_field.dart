import 'dart:ffi';
import 'dart:math';

import 'package:syntonic_components/configs/constants/syntonic_color.dart';
import 'package:syntonic_components/widgets/dividers/syntonic_divider.dart';
import 'package:syntonic_components/widgets/icons/syntonic_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final Function? onFocused;
  final Function(String? text)? onTextChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController controller;
  final bool isEnabled;
  final bool isFocusRequired;
  final bool needsMasking;
  final int? itemKey;
  final TextFieldTheme? theme;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final String? hintText;
  final bool hasBorder;

  TextInputAction? get _textInputAction =>
      textInputAction ??
      ((minLines > 1) ? TextInputAction.newline : TextInputAction.done);
  OutlinedTextFieldType get outlinedTextFieldType => needsMasking
      ? OutlinedTextFieldType.Obscure
      : OutlinedTextFieldType.Normal;

  /// Normal.
  const SyntonicTextField._({
    required this.label,
    this.onFocused,
    this.onTextChanged,
    this.value,
    this.errorMessage,
    this.maxLines,
    this.minLines = 1,
    this.hasPadding = true,
    this.helperText,
    this.validator,
    this.textInputAction = TextInputAction.done,
    this.keyboardType,
    this.inputFormatters,
    required this.controller,
    this.isEnabled = true,
    this.isFocusRequired = false,
    this.needsMasking = false,
    this.itemKey,
    this.theme = TextFieldTheme.outlined,
    this.textAlign,
    this.textStyle,
    this.hintText,this.hasBorder = true,
  });

  const SyntonicTextField.outlined({
    String? label,
    Function? onFocused,
    Function(String? text)? onTextChanged,
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
    required TextEditingController controller,
    bool isEnabled = true,
    bool isFocusRequired = false,
    bool needsMasking = false,
    int? itemKey,
    TextFieldTheme? theme,
    TextAlign? textAlign,
    TextStyle? textStyle,
    String? hintText,
    bool hasBorder = true,
  }) : this._(
            label: label,
            onFocused: onFocused,
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
            isFocusRequired: isFocusRequired,
            needsMasking: needsMasking,
            itemKey: itemKey,
            theme: theme,
            textAlign: textAlign,
            textStyle: textStyle,
            hintText: hintText, hasBorder: hasBorder);

  // static final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TextEditingController _controller = TextEditingController();
    // set value of the text fields.
    if (controller.text.isEmpty && value != null) {
      controller.text = value!;
    }
    //
    // set cursor position at the end of the value.
    // controller.selection = TextSelection.fromPosition(
    //     TextPosition(offset: controller.text.length));

    return RepaintBoundary(
      child: Padding(
        padding: hasPadding
            ? const EdgeInsets.symmetric(vertical: 8, horizontal: 16)
            : EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              key: PageStorageKey(itemKey),
              // initialValue: value,
              autofocus: isFocusRequired,
              enabled: isEnabled,
              controller: controller,
              maxLines: maxLines,
              minLines: minLines,
              validator: validator,
              decoration: InputDecoration(
                hintText: hintText,
                labelText: label,
                errorText: errorMessage,
                helperText: helperText,
                border: theme == TextFieldTheme.outlined
                    ? const OutlineInputBorder()
                    : InputBorder.none,
                suffixIcon: errorMessage != null
                    ? const SyntonicIcon(
                        icon: Icons.error, color: SyntonicColor.torch_red)
                    : null,
                contentPadding: theme == TextFieldTheme.underline
                    ? const EdgeInsets.all(0)
                    : null,
                isDense: theme == TextFieldTheme.underline,
              ),
              textInputAction: _textInputAction,
              textAlign: textAlign ?? TextAlign.start,
              keyboardType:
                  maxLines != null ? TextInputType.multiline : keyboardType,
              inputFormatters: inputFormatters,
              onChanged: (text) {
                if (onTextChanged != null) {
                  onTextChanged!(text.isEmpty ? null : text);
                }
              },
              onTap: onFocused?.call(),
              // onSaved: (text) => onTextChanged(controller.text),
              style: textStyle,
            ),
            const SizedBox(
              height: 2,
            ),
            hasBorder ? SyntonicDivider(
              hasDotted: true,
            ) : SizedBox()
          ],
        ),
      ),
    );

    // return ListenableProvider(
    //     create: (context) => OutlinedTextFieldManager(),
    //     child: Consumer<OutlinedTextFieldManager>(
    //         builder: (context, model, child) {
    //           return Padding(padding: hasPadding ? const EdgeInsets.only(left: 16, right: 16) : EdgeInsets.zero, child: getTextFormField(context, model),);
    //     }));
  }

  // /// Get text form field depends on [outlinedTextFieldType].
  // Widget getTextFormField(
  //     BuildContext context, OutlinedTextFieldManager outlinedTextFieldManager) {
  //
  //   // set value of the text fields.
  //   _controller.text = value ?? '';
  //
  //   // set cursor position at the end of the value.
  //   _controller.selection = TextSelection.fromPosition(
  //       TextPosition(offset: _controller.text.length));
  //
  //   switch (outlinedTextFieldType) {
  //     case OutlinedTextFieldType.Normal:
  //       return TextFormField(
  //         key: PageStorageKey(itemKey),
  //         enabled: isEnabled,
  //         controller: controller ?? _controller,
  //         maxLines: maxLines,
  //         minLines: minLines,
  //         validator: validator,
  //         decoration: InputDecoration(
  //           hintText: hintText,
  //           labelText: label,
  //           errorText: errorMessage,
  //           helperText: helperText,
  //           border: theme == TextFieldTheme.outlined ? const OutlineInputBorder() : InputBorder.none,
  //           suffixIcon: errorMessage != null
  //               ? const SyntonicIcon(icon: Icons.error, color: SyntonicColor.torch_red)
  //               : null,
  //         ),
  //         textInputAction: _textInputAction,
  //         keyboardType: keyboardType,
  //         inputFormatters: inputFormatters,
  //         onFieldSubmitted: (text) {
  //           onTextChanged(text);
  //         },
  //         onChanged: (text) {
  //           onTextChanged(text);
  //         },
  //         style: textStyle,
  //       );
  //     case OutlinedTextFieldType.Obscure:
  //       return Stack(alignment: Alignment.centerRight, children: [
  //         TextFormField(
  //           key: PageStorageKey(itemKey),
  //           controller: controller,
  //           validator: validator,
  //           obscureText: !outlinedTextFieldManager.isVisible,
  //           decoration: InputDecoration(
  //             hintText: hintText,
  //             labelText: label,
  //             errorText: errorMessage,
  //             border: theme == TextFieldTheme.outlined ? const OutlineInputBorder() : InputBorder.none,
  //           ),
  //           textInputAction: TextInputAction.done,
  //           onFieldSubmitted: (text) {
  //             onTextChanged(text);
  //           },
  //           onChanged: (text) {
  //             onTextChanged(text);
  //           },
  //           style: textStyle,
  //         ),
  //         Positioned(
  //           top: 6,
  //           right: 0,
  //           child: IconButton(
  //             icon: Icon(!outlinedTextFieldManager.isVisible
  //                 ? Icons.visibility_off
  //                 : Icons.visibility),
  //             onPressed: () {
  //               // value = controller.text;
  //               outlinedTextFieldManager.changeTextVisibilityState();
  //             },
  //           ),
  //         ),
  //       ]);
  //   }
  // }
}

class OutlinedTextFieldManager extends ChangeNotifier {
  bool isVisible = false;

  /// Change visibility state.
  void changeTextVisibilityState() {
    isVisible = !isVisible;
    notifyListeners();
  }
}

class FitTextField extends StatefulWidget {
  final String? initialValue;
  final double minWidth;

  final String? errorMessage;
  final String? helperText;
  final String? label;
  final String? value;
  final int? maxLines;
  final int minLines;
  final bool hasPadding;
  final Function? onFocused;
  final Function(String? text)? onTextChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController controller;
  final bool isEnabled;
  final bool isFocusRequired;
  final bool needsMasking;
  final int? itemKey;
  final TextFieldTheme? theme;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final String? hintText;

  TextInputAction? get _textInputAction =>
      textInputAction ??
      ((minLines > 1) ? TextInputAction.newline : TextInputAction.done);
  OutlinedTextFieldType get outlinedTextFieldType => needsMasking
      ? OutlinedTextFieldType.Obscure
      : OutlinedTextFieldType.Normal;

  const FitTextField({
    Key? key,
    this.initialValue,
    this.minWidth = 30,
    this.label,
    this.onFocused,
    this.onTextChanged,
    this.value,
    this.errorMessage,
    this.maxLines,
    this.minLines = 1,
    this.hasPadding = true,
    this.helperText,
    this.validator,
    this.textInputAction = TextInputAction.done,
    this.keyboardType,
    this.inputFormatters,
    required this.controller,
    this.isEnabled = true,
    this.isFocusRequired = false,
    this.needsMasking = false,
    this.itemKey,
    this.theme = TextFieldTheme.outlined,
    this.textAlign,
    this.textStyle,
    this.hintText,
  }) : super(key: key);

  // const FitTextField({
  //   Key? key,
  //   this.initialValue,
  //   this.minWidth: 30,
  // }) : super(key: key);

  @override
  State<StatefulWidget> createState() => FitTextFieldState();
}

class FitTextFieldState extends State<FitTextField> {
  // 2.0 is the default from TextField class
  static const _CURSOR_WIDTH = 2.0;

  // TextEditingController txt = TextEditingController();

  // We will use this text style for the TextPainter used to calculate the width
  // and for the TextField so that we calculate the correct size for the text
  // we are actually displaying
  // TextStyle textStyle = TextStyle(
  //   color: Colors.grey[600],
  //   fontSize: 16,
  // );

  @override
  initState() {
    super.initState();
    // Set the text in the TextField to our initialValue
    if (widget.initialValue != null) {
      widget.controller.text = widget.initialValue!;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TextField merges given textStyle with text style from current theme
    // Do the same to get final TextStyle
    final ThemeData themeData = Theme.of(context);
    final TextStyle style = widget.textStyle!;

    if (widget.controller.text.isEmpty && widget.value != null) {
      widget.controller.text = widget.value!;
    }

    // Use TextPainter to calculate the width of our text
    TextSpan ts = TextSpan(style: style, text: widget.controller.text);
    TextPainter tp = TextPainter(
      text: ts,
      textDirection: TextDirection.ltr,
    );
    tp.layout();

    TextSpan tss = TextSpan(style: style, text: widget.controller.text.length > 0 ? widget.controller.text : widget.hintText);
    TextPainter tpp = TextPainter(
      text: tss,
      textDirection: TextDirection.ltr,
    );
    tpp.layout();

    // Enforce a minimum width
    final textWidth = max(tpp.width + 10, tp.width + _CURSOR_WIDTH + 10);

    return SizedBox(
      width: textWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            cursorWidth: _CURSOR_WIDTH,
            style: style,
            controller: widget.controller,
            onChanged: (text) {
              // Redraw the widget
              setState(() {});
            },
            onTap: widget.onFocused?.call(),
            key: PageStorageKey(widget.itemKey),
            // initialValue: value,
            autofocus: widget.isFocusRequired,
            enabled: widget.isEnabled,
            // controller: controller,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            validator: widget.validator,
            decoration: InputDecoration(
              hintText: widget.hintText,
              labelText: widget.label,
              errorText: widget.errorMessage,
              helperText: widget.helperText,
              border: InputBorder.none,
              // border: widget.theme == TextFieldTheme.outlined ? const OutlineInputBorder() : InputBorder.none,
              suffixIcon: widget.errorMessage != null
                  ? const SyntonicIcon(
                      icon: Icons.error, color: SyntonicColor.torch_red)
                  : null,
              contentPadding: widget.theme == TextFieldTheme.underline
                  ? const EdgeInsets.all(0)
                  : null,
              isDense: widget.theme == TextFieldTheme.underline,
            ),
            textInputAction: widget._textInputAction,
            textAlign: widget.textAlign ?? TextAlign.start,
            keyboardType: widget.maxLines != null
                ? TextInputType.multiline
                : widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            // onChanged: (text) {
            //   if (onTextChanged != null) {
            //     onTextChanged!(text.isEmpty ? null : text);
            //   }
            // },
            // onSaved: (text) => onTextChanged(controller.text),
            // style: textStyle,
          ),
          const SizedBox(
            height: 2,
          ),
          SyntonicDivider(
            hasDotted: true,
          )
        ],
      ),
    );
  }
}
