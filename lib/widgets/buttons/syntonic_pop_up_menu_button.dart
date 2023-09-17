import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../services/localization_service.dart';
import '../dialogs/syntonic_dialog.dart';

class SyntonicPopupMenuButton extends StatelessWidget {
  /// Icon.
  final IconData icon;

  /// Whether [SyntonicPopupMenuButton] is enabled?
  final bool isEnabled;

  /// A color of [icon].
  final Color? color;

  /// Execute [onEditTap], when taped 'edit'.
  final VoidCallback? onEditTap;

  /// Execute [onDeleteTap], when taped 'delete'.
  final VoidCallback? onDeleteTap;

  /// Additional menus of [SyntonicPopupMenuButton].
  final List<PopUpMenuItem>? additionalMenus;

  @Deprecated(
      'Should use [onEdit], [onDelete], [additionalMenus] instead of this')
  final List<PopUpMenuItem>? popUpMenuItem;

  const SyntonicPopupMenuButton({
    this.icon = Icons.more_vert,
    this.color,
    this.isEnabled = true,
    this.onEditTap,
    this.onDeleteTap,
    this.additionalMenus,
    this.popUpMenuItem,
  });

  @override
  Widget build(BuildContext context) {
    VoidCallback? _onEditTap = onEditTap;
    VoidCallback? _onDeleteTap = onDeleteTap;

    if (_onEditTap == null && _onDeleteTap == null && additionalMenus == null && popUpMenuItem == null) {
      return const SizedBox();
    }

    return PopupMenuButton<String>(
      enabled: isEnabled,
      offset: Offset(-26, -20),
      icon: Icon(
        icon,
        color: color,
      ),
      onSelected: (value) {
        _menus(context, onDeleteTap: onDeleteTap, onEditTap: onEditTap,)
            .firstWhere((menuItem) => menuItem.title == value)
            .onTap();
      },
      itemBuilder: (context) => _menus(context, onDeleteTap: _onDeleteTap, onEditTap: _onEditTap,)
          .map((item) => PopupMenuItem<String>(
                value: item.title,
                child: Text(item.title),
              ))
          .toList(),
    );
  }

  /// Get menus.
  List<PopUpMenuItem> _menus(BuildContext context, {required VoidCallback? onDeleteTap, required VoidCallback? onEditTap}) {
    List<PopUpMenuItem> _menus = [];

    if (onEditTap != null) {
      _menus.add(PopUpMenuItem(
          title: 'Edit', onTap: onEditTap!));
    }

    if (onDeleteTap != null) {
      _menus.add(PopUpMenuItem(
          title: 'Delete',
          onTap: () {
            List<SyntonicDialogButtonInfoModel> _buttonList = [];
            _buttonList.add(SyntonicDialogButtonInfoModel(
                buttonTxt: 'Cancel',
                buttonAction: () {}));
            _buttonList.add(SyntonicDialogButtonInfoModel(
                buttonTxt: LocalizationService().localize.ok,
                buttonAction: onDeleteTap!));
            showDialog(
                context: context,
                builder: (context) => SyntonicDialog(
                      content: 'Can i delete?',
                      buttonInfoList: _buttonList,
                    ));
          }));
    }

    if (additionalMenus != null) {
      _menus.addAll(additionalMenus!);
    }

    if (popUpMenuItem != null) {
      _menus.addAll(popUpMenuItem!);
    }

    return _menus;
  }
}


/// An item of [SyntonicPopupMenuButton].
class PopUpMenuItem {
  /// A name of menu.
  String title;

  /// Execute [onTap], when the item is tapped.
  VoidCallback onTap;

  PopUpMenuItem({required this.onTap, required this.title});
}
