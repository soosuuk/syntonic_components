import 'package:syntonic_components/widgets/syntonic_base_view.dart';
import 'package:flutter/material.dart';

class SyntonicSearchBox extends StatelessWidget {
  final String? value;
  final VoidCallback? onTap;
  final Function(String searchWord) onSearchButtonTap;
  final TextEditingController? controller;
  final String? hintText;
  const SyntonicSearchBox(
      {Key? key,
      this.value,
      this.onTap,
      required this.onSearchButtonTap,
      this.controller,
      this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textEditingController =
        TextEditingController();
    _textEditingController.text = value ?? '';

    if (onTap == null) {
      _textEditingController.selection = TextSelection(
          baseOffset: 0, extentOffset: _textEditingController.text.length);
    }

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.toAlpha,
        // color: (MediaQuery.of(context).platformBrightness == Brightness.light)
        //     ? Colors.black12
        //     : Colors.white12,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: TextField(
          autofocus: onTap != null ? false : true,
          onTap: onTap,
          readOnly: onTap != null ? true : false,
          controller: controller ?? _textEditingController,
          onChanged: (text) {
            // model.viewModel(text);
          },
          onSubmitted: (value) {
            onSearchButtonTap(value);
          },
          cursorColor: Theme.of(context).colorScheme.primary,
          // style: TextStyle(fontSize: 16.0, color: Colors.black),
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search_sharp,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              suffixIcon:
                  onTap == null && _textEditingController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.cancel,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () => _textEditingController.clear())
                      : null,
              border: InputBorder.none,
              hintText: hintText ?? "Search event"),
          textInputAction: TextInputAction.search),
    );
  }
}
