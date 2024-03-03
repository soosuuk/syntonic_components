import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

class BaseViewState {
  final bool isChangedAppBar;
  final bool isFloatingActionButtonExtended;
  final double? height;
  final double? tabBarHeight;
  final bool isFloatingActionButtonVisible;
  // late ScrollController? scrollController = ScrollController();
  // // ..addListener(scrollListener);
  final bool isStickyingAppBar;
  // final GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  final int? currentTabIndex;

  /// Use this variable as check whether number of build is one (initialize)
  /// or two and more(rebuild), when execute [initialize] function.
  final bool isInitialized;

  final bool needsInitialize;

  final bool isSkeletonLoadingApplied;

  BaseViewState({
    this.isChangedAppBar = false,
    this.isFloatingActionButtonExtended = true,
    this.height,
    this.tabBarHeight,
    this.isFloatingActionButtonVisible = true,
    // this.scrollController,
    this.isStickyingAppBar = false,
    // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    this.currentTabIndex = 0,
    this.isInitialized = false,
    required this.needsInitialize,
    required this.isSkeletonLoadingApplied,
  });

  BaseViewState._({
    required this.isChangedAppBar,
    required this.isFloatingActionButtonExtended,
    required this.height,
    required this.tabBarHeight,
    required this.isFloatingActionButtonVisible,
    // required this.scrollController,
    required this.isStickyingAppBar,
    // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    required this.currentTabIndex,
    required this.isInitialized,
    required this.needsInitialize,
    required this.isSkeletonLoadingApplied,
  });

  BaseViewState copyWith({
    bool isChangedAppBar = false,
    bool isFloatingActionButtonExtended = false,
    double? height,
    double? tabBarHeight,
    bool isFloatingActionButtonVisible = true,
    ScrollController? scrollController,
    bool isStickyingAppBar = false,
    // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    int? currentTabIndex = 0,
    bool isInitialized = false,
    bool needsInitialize = false,
    bool isSkeletonLoadingApplied = false,
  }) {
    return BaseViewState._(
        isChangedAppBar: isChangedAppBar,
        isFloatingActionButtonExtended: isFloatingActionButtonExtended,
        height: height,
        tabBarHeight: tabBarHeight,
        isFloatingActionButtonVisible: isFloatingActionButtonVisible,
        isStickyingAppBar: isStickyingAppBar,
        currentTabIndex: currentTabIndex,
        isInitialized: isInitialized,
        needsInitialize: needsInitialize,
        isSkeletonLoadingApplied: isSkeletonLoadingApplied);
  }
}
