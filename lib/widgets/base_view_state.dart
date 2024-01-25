
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:flutter/widgets.dart';

class BaseViewState {
  final bool isChangedAppBar;
  final bool isFloatingActionButtonExtended;
  final double height;
  final bool isFloatingActionButtonVisible;
  late ScrollController? scrollController = ScrollController();
  // ..addListener(scrollListener);
  final bool isStickyingAppBar;
  final GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  final int? currentTabIndex;

  /// Use this variable as check whether number of build is one (initialize)
  /// or two and more(rebuild), when execute [initialize] function.
  final bool isInitialized;

  final bool needsInitialize;

  final bool isSkeletonLoadingApplied;

  BaseViewState(
      {this.isChangedAppBar = false,
        this.isFloatingActionButtonExtended = false,
        this.height = 0,
        this.isFloatingActionButtonVisible = true,
        this.scrollController,
        this.isStickyingAppBar = false,
        // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
        this.currentTabIndex = 0,
        this.isInitialized = false,
        required this.needsInitialize,
        required this.isSkeletonLoadingApplied,
      }) {
    this.scrollController = scrollController ?? ScrollController();
  }

  BaseViewState._(
      {required this.isChangedAppBar,
        required this.isFloatingActionButtonExtended,
        required this.height,
        required this.isFloatingActionButtonVisible,
        required this.scrollController,
        required this.isStickyingAppBar,
        // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
        required this.currentTabIndex,
        required this.isInitialized,
        required this.needsInitialize,
        required this.isSkeletonLoadingApplied,
      }) {
    this.scrollController = scrollController ?? ScrollController();
  }

  // BaseViewState get copyWithh;

  BaseViewState copyWith(
      {bool isChangedAppBar = false,
        bool isFloatingActionButtonExtended = false,
        double height = 0,
        bool isFloatingActionButtonVisible = true,
        ScrollController? scrollController,
        bool isStickyingAppBar = false,
        // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
        int? currentTabIndex = 0,
        bool isInitialized = false,
        bool needsInitialize = false,
        bool isSkeletonLoadingApplied = false,
      }) {
    return BaseViewState._(isChangedAppBar: isChangedAppBar, isFloatingActionButtonExtended: isFloatingActionButtonExtended, height: height, isFloatingActionButtonVisible: isFloatingActionButtonVisible, scrollController: scrollController ?? ScrollController(), isStickyingAppBar: isStickyingAppBar, currentTabIndex: currentTabIndex, isInitialized: isInitialized, needsInitialize: needsInitialize, isSkeletonLoadingApplied: isSkeletonLoadingApplied);}
}



// import 'package:copy_with_extension/copy_with_extension.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
//
// import 'package:flutter/widgets.dart';
//
// abstract class BaseViewState {
//   bool get isChangedAppBar;
//   bool get isFloatingActionButtonExtended;
//   double get height;
//   bool get isFloatingActionButtonVisible;
//   ScrollController? get scrollController;
//   bool get isStickyingAppBar;
//   int? get currentTabIndex;
//   bool get isInitialized;
//   bool get needsInitialize;
//   bool get isSkeletonLoadingApplied;
//
//   // BaseViewState copyWith(
//   // event: event,
//   // needsInitialize: this.needsInitialize,
//   // isSkeletonLoadingApplied: isSkeletonLoadingApplied,
//   // isChangedEvent: isChangedEvent,
//   // isChangedAppBar: isChangedAppBar,
//   // isFloatingActionButtonExtended: isFloatingActionButtonExtended,
//   // height: height,
//   // isFloatingActionButtonVisible: isFloatingActionButtonVisible,
//   // scrollController: scrollController,
//   // isStickyingAppBar: isStickyingAppBar,
//   // currentTabIndex: currentTabIndex,
//   // isInitialized: isInitialized,
//   // );
//
//
//   // final bool isChangedAppBar;
//   // final bool isFloatingActionButtonExtended;
//   // final double height;
//   // final bool isFloatingActionButtonVisible;
//   // late ScrollController scrollController = ScrollController();
//   // // ..addListener(scrollListener);
//   // final bool isStickyingAppBar;
//   // final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   // final int? currentTabIndex;
//   //
//   // /// Use this variable as check whether number of build is one (initialize)
//   // /// or two and more(rebuild), when execute [initialize] function.
//   // bool isInitialized;
//   //
//   // final bool needsInitialize;
//   //
//   // final bool isSkeletonLoadingApplied;
//
//   // const factory BaseViewState(
//   // {@Default(false) bool isChangedAppBar,
//   //   @Default(false) bool isFloatingActionButtonExtended,
//   // @Default(0) double height,
//   //   @Default(true) bool isFloatingActionButtonVisible,
//   //   required ScrollController? scrollController,
//   //   @Default(false) bool isStickyingAppBar,
//   // // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   // @Default(0) int? currentTabIndex,
//   //   @Default(false) bool isInitialized,
//   //   @Default(false) bool needsInitialize,
//   //   @Default(false) bool isSkeletonLoadingApplied,
//   // }) = _BaseViewState;
//
// // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   // {
//   //   this.scrollController = scrollController ?? ScrollController();
//   // }
// }