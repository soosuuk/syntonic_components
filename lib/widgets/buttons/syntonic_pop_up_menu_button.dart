import 'package:flutter/material.dart';

import '../dialogs/syntonic_dialog.dart';

class SyntonicPopupMenuButton extends StatelessWidget {
  /// Icon.
  final IconData icon;

  /// Whether [SyntonicPopupMenuButton] is enabled?
  final bool isEnabled;

  final Color? backgroundColor;

  final Color? borderColor;

  final BoxShape? boxShape;

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
    Key? key,
    this.icon = Icons.more_vert,
    this.backgroundColor,
    this.borderColor,
    this.boxShape,
    this.color,
    this.isEnabled = true,
    this.onEditTap,
    this.onDeleteTap,
    this.additionalMenus,
    this.popUpMenuItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VoidCallback? _onEditTap = onEditTap;
    VoidCallback? _onDeleteTap = onDeleteTap;

    if (_onEditTap == null &&
        _onDeleteTap == null &&
        additionalMenus == null &&
        popUpMenuItem == null) {
      return const SizedBox();
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 32,
        minHeight: 32,
      ),
      child: Container(
      // width: IconSize.mini.size,
      // height: IconSize.mini.size,
      decoration: BoxDecoration(
        shape: boxShape ?? BoxShape.circle,
        borderRadius:
            boxShape == BoxShape.rectangle ? BorderRadius.circular(8) : null,
        border: borderColor != null
            ? Border.all(color: Theme.of(context).colorScheme.outlineVariant)
            : null,
        color: backgroundColor,
      ),
      child: PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        enabled: isEnabled,
        offset: const Offset(-26, -20),
        child: Icon(
          icon,
          color: color,
          // size: 18,
        ),
        onSelected: (value) {
          _menus(
            context,
            onDeleteTap: onDeleteTap,
            onEditTap: onEditTap,
          ).firstWhere((menuItem) => menuItem.title == value).onTap();
        },
        itemBuilder: (context) => _menus(
          context,
          onDeleteTap: _onDeleteTap,
          onEditTap: _onEditTap,
        )
            .map((item) => PopupMenuItem<String>(
                  value: item.title,
                  child: Text(item.title),
                ))
            .toList(),
      ),
    ));
    return PopupMenuButton<String>(
      enabled: isEnabled,
      offset: const Offset(-26, -20),
      icon: Icon(
        icon,
        color: color,
      ),
      onSelected: (value) {
        _menus(
          context,
          onDeleteTap: onDeleteTap,
          onEditTap: onEditTap,
        ).firstWhere((menuItem) => menuItem.title == value).onTap();
      },
      itemBuilder: (context) => _menus(
        context,
        onDeleteTap: _onDeleteTap,
        onEditTap: _onEditTap,
      )
          .map((item) => PopupMenuItem<String>(
                value: item.title,
                child: Text(item.title),
              ))
          .toList(),
    );
  }

  /// Get menus.
  List<PopUpMenuItem> _menus(BuildContext context,
      {required VoidCallback? onDeleteTap, required VoidCallback? onEditTap}) {
    List<PopUpMenuItem> _menus = [];

    if (onEditTap != null) {
      _menus.add(PopUpMenuItem(title: 'Edit', onTap: onEditTap));
    }

    if (onDeleteTap != null) {
      _menus.add(PopUpMenuItem(
          title: '削除',
          onTap: () {
            List<SyntonicDialogButtonInfoModel> _buttonList = [];
            _buttonList.add(SyntonicDialogButtonInfoModel(
                buttonTxt: 'キャンセル', buttonAction: () {}));
            _buttonList.add(SyntonicDialogButtonInfoModel(
                buttonTxt: '削除', buttonAction: onDeleteTap));
            showDialog(
                context: context,
                builder: (context) => SyntonicDialog(
                      title: '削除しますか？',
                      content: '削除した場合は元に戻せません。',
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
