// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../widgets/base_view_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BaseViewStateCWProxy {
  BaseViewState currentTabIndex(int? currentTabIndex);

  BaseViewState height(double height);

  BaseViewState isChangedAppBar(bool isChangedAppBar);

  BaseViewState isFloatingActionButtonExtended(
      bool isFloatingActionButtonExtended);

  BaseViewState isFloatingActionButtonVisible(
      bool isFloatingActionButtonVisible);

  BaseViewState isInitialized(bool isInitialized);

  BaseViewState isSkeletonLoadingApplied(bool isSkeletonLoadingApplied);

  BaseViewState isStickyingAppBar(bool isStickyingAppBar);

  BaseViewState needsInitialize(bool needsInitialize);

  BaseViewState scrollController(ScrollController? scrollController);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BaseViewState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BaseViewState(...).copyWith(id: 12, name: "My name")
  /// ````
  BaseViewState call({
    int? currentTabIndex,
    double? height,
    bool? isChangedAppBar,
    bool? isFloatingActionButtonExtended,
    bool? isFloatingActionButtonVisible,
    bool? isInitialized,
    bool? isSkeletonLoadingApplied,
    bool? isStickyingAppBar,
    bool? needsInitialize,
    ScrollController? scrollController,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBaseViewState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBaseViewState.copyWith.fieldName(...)`
class _$BaseViewStateCWProxyImpl implements _$BaseViewStateCWProxy {
  final BaseViewState _value;

  const _$BaseViewStateCWProxyImpl(this._value);

  @override
  BaseViewState currentTabIndex(int? currentTabIndex) =>
      this(currentTabIndex: currentTabIndex);

  @override
  BaseViewState height(double height) => this(height: height);

  @override
  BaseViewState isChangedAppBar(bool isChangedAppBar) =>
      this(isChangedAppBar: isChangedAppBar);

  @override
  BaseViewState isFloatingActionButtonExtended(
          bool isFloatingActionButtonExtended) =>
      this(isFloatingActionButtonExtended: isFloatingActionButtonExtended);

  @override
  BaseViewState isFloatingActionButtonVisible(
          bool isFloatingActionButtonVisible) =>
      this(isFloatingActionButtonVisible: isFloatingActionButtonVisible);

  @override
  BaseViewState isInitialized(bool isInitialized) =>
      this(isInitialized: isInitialized);

  @override
  BaseViewState isSkeletonLoadingApplied(bool isSkeletonLoadingApplied) =>
      this(isSkeletonLoadingApplied: isSkeletonLoadingApplied);

  @override
  BaseViewState isStickyingAppBar(bool isStickyingAppBar) =>
      this(isStickyingAppBar: isStickyingAppBar);

  @override
  BaseViewState needsInitialize(bool needsInitialize) =>
      this(needsInitialize: needsInitialize);

  @override
  BaseViewState scrollController(ScrollController? scrollController) =>
      this(scrollController: scrollController);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BaseViewState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BaseViewState(...).copyWith(id: 12, name: "My name")
  /// ````
  BaseViewState call({
    Object? currentTabIndex = const $CopyWithPlaceholder(),
    Object? height = const $CopyWithPlaceholder(),
    Object? isChangedAppBar = const $CopyWithPlaceholder(),
    Object? isFloatingActionButtonExtended = const $CopyWithPlaceholder(),
    Object? isFloatingActionButtonVisible = const $CopyWithPlaceholder(),
    Object? isInitialized = const $CopyWithPlaceholder(),
    Object? isSkeletonLoadingApplied = const $CopyWithPlaceholder(),
    Object? isStickyingAppBar = const $CopyWithPlaceholder(),
    Object? needsInitialize = const $CopyWithPlaceholder(),
    Object? scrollController = const $CopyWithPlaceholder(),
  }) {
    return BaseViewState(
      currentTabIndex: currentTabIndex == const $CopyWithPlaceholder()
          ? _value.currentTabIndex
          // ignore: cast_nullable_to_non_nullable
          : currentTabIndex as int?,
      height: height == const $CopyWithPlaceholder() || height == null
          ? _value.height
          // ignore: cast_nullable_to_non_nullable
          : height as double,
      isChangedAppBar: isChangedAppBar == const $CopyWithPlaceholder() ||
              isChangedAppBar == null
          ? _value.isChangedAppBar
          // ignore: cast_nullable_to_non_nullable
          : isChangedAppBar as bool,
      isFloatingActionButtonExtended:
          isFloatingActionButtonExtended == const $CopyWithPlaceholder() ||
                  isFloatingActionButtonExtended == null
              ? _value.isFloatingActionButtonExtended
              // ignore: cast_nullable_to_non_nullable
              : isFloatingActionButtonExtended as bool,
      isFloatingActionButtonVisible:
          isFloatingActionButtonVisible == const $CopyWithPlaceholder() ||
                  isFloatingActionButtonVisible == null
              ? _value.isFloatingActionButtonVisible
              // ignore: cast_nullable_to_non_nullable
              : isFloatingActionButtonVisible as bool,
      isInitialized:
          isInitialized == const $CopyWithPlaceholder() || isInitialized == null
              ? _value.isInitialized
              // ignore: cast_nullable_to_non_nullable
              : isInitialized as bool,
      isSkeletonLoadingApplied:
          isSkeletonLoadingApplied == const $CopyWithPlaceholder() ||
                  isSkeletonLoadingApplied == null
              ? _value.isSkeletonLoadingApplied
              // ignore: cast_nullable_to_non_nullable
              : isSkeletonLoadingApplied as bool,
      isStickyingAppBar: isStickyingAppBar == const $CopyWithPlaceholder() ||
              isStickyingAppBar == null
          ? _value.isStickyingAppBar
          // ignore: cast_nullable_to_non_nullable
          : isStickyingAppBar as bool,
      needsInitialize: needsInitialize == const $CopyWithPlaceholder() ||
              needsInitialize == null
          ? _value.needsInitialize
          // ignore: cast_nullable_to_non_nullable
          : needsInitialize as bool,
      scrollController: scrollController == const $CopyWithPlaceholder()
          ? _value.scrollController
          // ignore: cast_nullable_to_non_nullable
          : scrollController as ScrollController?,
    );
  }
}

extension $BaseViewStateCopyWith on BaseViewState {
  /// Returns a callable class that can be used as follows: `instanceOfBaseViewState.copyWith(...)` or like so:`instanceOfBaseViewState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BaseViewStateCWProxy get copyWith => _$BaseViewStateCWProxyImpl(this);
}
