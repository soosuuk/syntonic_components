import 'dart:math';

import 'package:syntonic_components/configs/constants/syntonic_color.dart';
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

class SyntonicTextField extends StatefulWidget {
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
  final Function? onEditingComplete;
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
  final TextStyle? hintStyle;
  final bool hasBorder;
  final FocusNode? focusNode;
  final Function(bool)? onFocusChanged;
  final bool isScalable;

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
    this.onEditingComplete,
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
    this.hintStyle,
    this.hasBorder = true,
    this.focusNode,
    this.onFocusChanged,
    this.isScalable = false,
  });

  const SyntonicTextField.outlined({
    String? label,
    Function? onFocused,
    Function? onEditingComplete,
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
    TextStyle? hintStyle,
    bool hasBorder = true,
    FocusNode? focusNode,
    Function(bool)? onFocusChanged,
    bool isScalable = false,
  }) : this._(
            label: label,
            onFocused: onFocused,
            onEditingComplete: onEditingComplete,
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
            hintText: hintText,
            hintStyle: hintStyle,
            hasBorder: hasBorder,
            focusNode: focusNode,
            onFocusChanged: onFocusChanged,
            isScalable: isScalable);

  @override
  _SyntonicTextFieldState createState() => _SyntonicTextFieldState();
}

class _SyntonicTextFieldState extends State<SyntonicTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
    widget.controller.addListener(_updateScale);

    if (widget.controller.text.isEmpty && widget.value != null) {
      widget.controller.text = widget.value!;
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    widget.controller.removeListener(_updateScale);
    super.dispose();
  }

  void _handleFocusChange() {
    if (widget.onFocusChanged != null) {
      print('onFocusChanged: ${widget.controller.text}');
      widget.onFocusChanged!(_focusNode.hasFocus);
    }
  }

  void _updateScale() {
    setState(() {});
  }

  int _countLineWraps(String text, double maxWidth, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: null,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    return textPainter.computeLineMetrics().length - 1;
  }

  @override
  Widget build(BuildContext context) {
    final double maxWidth =
        MediaQuery.of(context).size.width - 32; // Adjust for padding
    final TextStyle baseStyle = widget.textStyle ??
        const TextStyle(
            fontFamily: 'swiss721',
            fontWeight: FontWeight.w400,
            fontSize: 16,
            height: 1.25,
            letterSpacing: -0.2);
    int lineWrapCount =
        _countLineWraps(widget.controller.text, maxWidth, baseStyle);
    double scale = 1.0;
    if (widget.isScalable) {
      int lineWrapCount =
          _countLineWraps(widget.controller.text, maxWidth, baseStyle);
      scale = 1.0 - (lineWrapCount * 0.1).clamp(0.0, 0.3);
    }
    final TextStyle scaledStyle =
        baseStyle.copyWith(fontSize: baseStyle.fontSize ?? 15 * scale);

    return RepaintBoundary(
      child: Padding(
        padding: widget.hasPadding
            ? const EdgeInsets.symmetric(vertical: 8, horizontal: 16)
            : EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              key: PageStorageKey(widget.itemKey),
              autofocus: widget.isFocusRequired,
              enabled: widget.isEnabled,
              controller: widget.controller,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              validator: widget.validator,
              decoration: InputDecoration(
                hintStyle: widget.hintStyle ?? scaledStyle.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.38)),
                hintText: widget.hintText,
                labelText: widget.label,
                errorText: widget.errorMessage,
                helperText: widget.helperText,
                border: widget.theme == TextFieldTheme.outlined
                    ? const OutlineInputBorder()
                    : InputBorder.none,
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
              focusNode: _focusNode,
              onChanged: (text) {
                print('onChanged: $text');
                if (widget.onTextChanged != null) {
                  widget.onTextChanged!(text);
                }
              },
              onEditingComplete: () {
                print('onEditingComplete: ${widget.controller.text}');
                widget.onEditingComplete;},
              onTap: () {
                if (widget.onFocused != null) {
                  widget.onFocused!();
                }
              },
              style: scaledStyle,
            ),
            // const SizedBox(
            //   height: 2,
            // ),
          ],
        ),
      ),
    );
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

    TextSpan tss = TextSpan(
        style: style,
        text: widget.controller.text.isNotEmpty
            ? widget.controller.text
            : widget.hintText);
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
            // inputFormatters: [
            //   _UpperCaseTextFormatter(),
            // ],
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
            // inputFormatters: widget.inputFormatters,
            // onChanged: (text) {
            //   if (onTextChanged != null) {
            //     onTextChanged!(text.isEmpty ? null : text);
            //   }
            // },
            // onSaved: (text) => onTextChanged(controller.text),
            // style: textStyle,
          ),
          // const SizedBox(
          //   height: 2,
          // ),
          // SyntonicDivider(
          //   hasDotted: true,
          // )
        ],
      ),
    );
  }
}

// class _UpperCaseTextFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
//     return TextEditingValue(
//       text: newValue.text.toUpperCase(),
//       selection: newValue.selection,
//     );
//   }
// }

class ScaledTextField extends StatefulWidget {
  final TextEditingController controller;

  const ScaledTextField({Key? key, required this.controller}) : super(key: key);

  @override
  _ScaledTextFieldState createState() => _ScaledTextFieldState();
}

class _ScaledTextFieldState extends State<ScaledTextField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateScale);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateScale);
    super.dispose();
  }

  void _updateScale() {
    setState(() {});
  }

  int _countLineWraps(String text, double maxWidth, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: null,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    return textPainter.computeLineMetrics().length - 1;
  }

  @override
  Widget build(BuildContext context) {
    final double maxWidth =
        MediaQuery.of(context).size.width - 32; // Adjust for padding
    final TextStyle style = Theme.of(context).textTheme.bodyMedium!;
    int lineWrapCount =
        _countLineWraps(widget.controller.text, maxWidth, style);
    double scale = 1.0 - (lineWrapCount * 0.1).clamp(0.0, 0.5);

    return Transform.scale(
      scale: scale,
      child: TextFormField(
        controller: widget.controller,
        maxLines: null, // Allow multiple lines
        decoration: const InputDecoration(
          labelText: 'Enter text',
        ),
        style: style,
      ),
    );
  }
}
