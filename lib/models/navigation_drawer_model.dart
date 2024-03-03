import 'package:flutter/cupertino.dart';
import 'package:syntonic_components/models/navigation_drawer_item_model.dart';

class NavigationDrawerModel {
  Widget? header;
  Map<String, NavigationDrawerItemModel> items;

  NavigationDrawerModel({required this.header, required this.items});
}
