import 'package:syntonic_components/configs/constants/syntonic_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'syntonic_bottom_navigation_item.dart';

// ignore: must_be_immutable
class SyntonicBottomNavigation extends StatelessWidget {

  final List<SyntonicBottomNavigationItem> items;
  Function(int idx)? onTap;

  SyntonicBottomNavigation({
    required this.items,
    this.onTap,
  });

  Widget _bottomNavigationItemIconWithBadge(Icon icon, int badgeVal) {
    print('_bottomNavigationItemIconWithBadge badgeVal==$badgeVal');

    return Stack(
      children: <Widget>[
        icon,
        new Positioned(
            right: -0,
            top: 0,
            child: Container(
              alignment: Alignment.center,
              padding: (badgeVal > 99) ? EdgeInsets.fromLTRB(3, 0, 3, 0) : EdgeInsets.fromLTRB(0, 0, 0, 0),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(15),
              ),
              constraints: BoxConstraints(
                minWidth: (badgeVal == 0) ? 14 : 18,
                minHeight: (badgeVal == 0) ? 14 : 18,
              ),
              child: Text(
                (badgeVal > 99) ? '99+' : ((badgeVal == 0) ? '' : badgeVal.toString()),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            )
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SyntonicBottomNavigationViewModel>(
      create: (context) => SyntonicBottomNavigationViewModel(0),
      child: Consumer<SyntonicBottomNavigationViewModel>(
        builder: (context, model, child) => Container(
          child: Scaffold(
            body: IndexedStack(
              index: model.getCurrentIdx,
              children: [
                for (final item in this.items) item.screen,
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed, // この属性を指定しないとitem 4 個以上の場合正常に表示されない！
              currentIndex: model.getCurrentIdx,
              selectedItemColor: SyntonicColor.primary_color64,
              iconSize: 30,
              onTap: (int idx) {
                model.setCurrentIdx(idx);
                if (this.onTap != null) {
                  this.onTap!(idx);
                }
              },
              items: [
                for (final item in this.items)
                  BottomNavigationBarItem(
                    icon: (item.hasBadge) ? _bottomNavigationItemIconWithBadge(item.icon, item.badgeVal) : item.icon,
                    label: item.label,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

}

class SyntonicBottomNavigationViewModel with ChangeNotifier {
  late int _currentIdx;

  int get getCurrentIdx => _currentIdx;

  SyntonicBottomNavigationViewModel(int idx) {
    this._currentIdx = idx;
    notifyListeners();
  }

  void setCurrentIdx(int idx) {
    this._currentIdx = idx;
    notifyListeners();
  }

}
