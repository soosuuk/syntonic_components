
// ignore: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syntonic_components/configs/constants/syntonic_color.dart';

import '../../services/localization_service.dart';

enum TextPickerStyle {
  transparent,
  filled,
}

class SyntonicTextPicker extends StatelessWidget {
  bool needsPadding = false;
  Function(int? value) onTap;
  int? selectedIndex;
  List<String> items;
  bool isEnabled = true;
  final String? errorText;
  final String? label;
  int? itemKey;
  bool needsColor = false;
  FormFieldValidator<String>? validator;
  TextPickerStyle style;

  SyntonicTextPicker({
    required this.items,
    required this.onTap,
    required this.selectedIndex,
    this.isEnabled = true,
    this.label,
    this.needsPadding = true,
    this.errorText,
    this.itemKey,
    this.needsColor = false,
    this.validator,
    this.style = TextPickerStyle.transparent,
  });

  @override
  Widget build(BuildContext context) {
    final textEditingController = new TextEditingController();
    textEditingController.text = this.selectedIndex != null
        ? this.items[this.selectedIndex!]
        : '';
    EdgeInsetsGeometry padding = this.needsPadding
        ? EdgeInsets.only(left: 16, right: 16)
        : EdgeInsets.only(left: 0, right: 0);
    bool isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
        padding: padding,
        child: FormField<String>(
          builder: (FormFieldState<String> state) {
            return Stack(alignment: AlignmentDirectional.centerEnd, children: [
              TextFormField(
                key: PageStorageKey(itemKey),
                enabled: this.isEnabled,
                controller: textEditingController,
                readOnly: true,
                validator: validator,
                cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
                decoration: style == TextPickerStyle.transparent ? InputDecoration(border: InputBorder.none) : InputDecoration(
                  border: needsColor ? InputBorder.none : null,
                  fillColor: isEnabled == false && needsColor && isDarkTheme
                      ? SyntonicColor.white4
                      : isEnabled == false && needsColor && isDarkTheme == false
                      ? SyntonicColor.black4
                  : isDarkTheme && needsColor ? Colors.black12 :  needsColor
                  ? Colors.white : null,
                  errorText: errorText,
                  filled: true,
                  labelText: label,
                  helperText: null,
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
              ),
              this.isEnabled ? Container(
                  child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                    icon: Container(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(Icons.arrow_drop_down)),
                    isExpanded: true,
                    onChanged: (DropdownItemModel? selectedIndex) {
                      onTap((selectedIndex?.index == 0)
                          ? null
                          : selectedIndex?.index);
                    },
                    items:getDropdownButtonItems(context: context),
                  ),
                ),
              )) : SizedBox()
            ]);
          },
        ));
  }

  List<DropdownMenuItem<DropdownItemModel>> getDropdownButtonItems({required BuildContext context}) {
    List<DropdownMenuItem<DropdownItemModel>> list = [];
    for (int i = 0; i < this.items.length; i++) {
      list.add(getDropDownMenuItem(context: context, index: i, value: this.items[i]));
    }
    return list;
  }

  DropdownMenuItem<DropdownItemModel> getDropDownMenuItem(
      {required BuildContext context, required int index, required String value}) {
    return DropdownMenuItem<DropdownItemModel>(
      value: DropdownItemModel(index: index, value: value),
      child: Text(value,
          // ignore: unrelated_type_equality_checks
          style: index == selectedIndex
              ? TextStyle(color: Theme.of(context).colorScheme.primary)
              : null),
    );
  }
}

class DropdownItemModel {
  int index;
  String value;

  DropdownItemModel({required this.index, required this.value});
}
