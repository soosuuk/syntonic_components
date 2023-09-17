import 'package:syntonic_components/configs/constants/syntonic_color.dart';
import 'package:syntonic_components/widgets/syntonic_base_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../services/localization_service.dart';

class SyntonicSearchBox extends StatelessWidget {
  final String? value;
  final VoidCallback? onTap;
  final Function(String searchWord) onSearchButtonTap;
  SyntonicSearchBox({this.value, this.onTap, required this.onSearchButtonTap});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textEditingController =
        TextEditingController();
    _textEditingController.text = this.value ?? '';

    if (this.onTap == null) {
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
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: TextField(
          autofocus: this.onTap != null ? false : true,
          onTap: this.onTap,
          readOnly: this.onTap != null ? true : false,
          controller: _textEditingController,
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
                  this.onTap == null && _textEditingController.text.length > 0
                      ? IconButton(
                          icon: Icon(Icons.cancel, color: Theme.of(context).colorScheme.primary,),
                          onPressed: () => _textEditingController.clear())
                      : null,
              border: InputBorder.none,
              hintText: "Search event"
          ),
          textInputAction: TextInputAction.search),
    );
  }
}