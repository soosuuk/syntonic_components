
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:flutter/widgets.dart';
part '../gen/models/widgets/base_view_state.g.dart';

@CopyWith()
class BaseViewState {
  final bool isChangedAppBar;
  final bool isFloatingActionButtonExtended;
  final double height;
  final bool isFloatingActionButtonVisible;
  late ScrollController scrollController = ScrollController();
  // ..addListener(scrollListener);
  final bool isStickyingAppBar;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final int? currentTabIndex;

  /// Use this variable as check whether number of build is one (initialize)
  /// or two and more(rebuild), when execute [initialize] function.
  bool isInitialized;

  final bool needsInitialize;

  final bool isSkeletonLoadingApplied;

  BaseViewState(
  {this.isChangedAppBar = false,
  this.isFloatingActionButtonExtended = false,
  this.height = 0,
  this.isFloatingActionButtonVisible = true,
    ScrollController? scrollController,
  this.isStickyingAppBar = false,
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  this.currentTabIndex = 0,
  this.isInitialized = false,
  required this.needsInitialize,
  required this.isSkeletonLoadingApplied,
  }) {
    this.scrollController = scrollController ?? ScrollController();
  }
}