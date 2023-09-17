import 'package:syntonic_components/configs/constants/syntonic_color.dart';
import 'package:syntonic_components/services/localization_service.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SyntonicDropdownTextField extends StatelessWidget {
  bool hasPadding = false;
  Function(int? value) onTap;
  int? selectedItem;
  DropdownModel dropdown;
  bool isEnabled = true;
  final String? errorText;
  final String? label;
  int? itemKey;
  bool needsColor = false;
  FormFieldValidator<String>? validator;

  SyntonicDropdownTextField({
    required this.dropdown,
    required this.onTap,
    required this.selectedItem,
    this.isEnabled = true,
    this.label,
    this.hasPadding = true,
    this.errorText,
    this.itemKey,
    this.needsColor = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final textEditingController = new TextEditingController();
    textEditingController.text = this.selectedItem != null
        ? this.dropdown.items[this.selectedItem!]
        : '';
    EdgeInsetsGeometry padding = this.hasPadding
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
                decoration: InputDecoration(
                  border: needsColor ? InputBorder.none : null,
                  fillColor: isEnabled == false && needsColor && isDarkTheme
                      ? SyntonicColor.white4
                      : isEnabled == false && needsColor && isDarkTheme == false
                      ? SyntonicColor.black4
                  : isDarkTheme && needsColor ? Colors.black12 :  needsColor
                  ? Colors.white : null,
                  errorText: errorText,
                  filled: true,
                  labelText: label ?? dropdown.label,
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
                    onChanged: (DropdownItemModel? selectedItem) {
                      onTap((selectedItem?.index == 0)
                          ? null
                          : selectedItem?.index);
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
    for (int i = 0; i < this.dropdown.items.length; i++) {
      list.add(getDropDownMenuItem(context: context, index: i, value: this.dropdown.items[i]));
    }
    return list;
  }

  DropdownMenuItem<DropdownItemModel> getDropDownMenuItem(
      {required BuildContext context, required int index, required String value}) {
    return DropdownMenuItem<DropdownItemModel>(
      value: DropdownItemModel(index: index, value: value),
      child: Text(value,
          // ignore: unrelated_type_equality_checks
          style: index == selectedItem
              ? TextStyle(color: SyntonicColor.primary_color)
              : null),
    );
  }
}

class DropdownItemModel {
  int index;
  String value;

  DropdownItemModel({required this.index, required this.value});
}

class DropdownModel {
  List<String> items;
  String? label;
  final Widget? leading;
  final bool isQuantityDropdown;

  DropdownModel({required this.items, this.label, this.leading, this.isQuantityDropdown = false}) {
    if (!this.isQuantityDropdown) {
      // Must including the item that clear a dropdown.
      this.items.insert(0, 'Please select');
    }
  }
}
