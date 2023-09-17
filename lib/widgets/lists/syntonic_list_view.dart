import 'package:syntonic_components/widgets/lists/syntonic_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../syntonic_base_view.dart';
import '../indicators/syntonic_progress_indicator.dart';

/// A state of [BasicListView].
enum _BasicListViewState {
  gallery,
  normal,
  infinite,
  reorderable,
  specifiable,
}

/// A basic list view.
/// [BasicListView] is a general-purpose [List] that can use any situation of
/// [list] architecture.
class SyntonicListView extends ExtendedStatelessWidget {
  /// Index of an item to initially align within the viewport.
  final int? initialScrollIndex;

  /// Number of items.
  final int? numberOfItems;

  /// Total number of items (Expecting).
  final int? numberOfItemsTotal;

  /// Loaded number of items.
  final int? numberToLoad;

  /// Additional number of items.
  /// Typically a title of this list and more.
  final int? numberOfAdditionalItems;

  /// Execute the function when reach to bottom of the screen.
  final Function()? onReachBottom;

  /// Padding.
  final EdgeInsetsGeometry? padding;

  /// Start scrolling at bottom.
  final bool isReverse;

  /// Get list item.
  final Widget Function(int index)? listItem;

  final Widget Function(int index, double width)? gridItem;

  /// Execute [onReordered] when an item has been reordered.
  late Function(int newIndex, int oldIndex)? onReordered;

  /// Enable the [buildDefaultDragHandles], when the [isReorderMode] is true.
  final bool isReorderMode;

  /// An [itemScrollController] of a [BasicListView].
  final ItemScrollController? itemScrollController;

  /// Whether [BasicListView] is nested?
  /// In case of nested, change [shrinkWrap], [physics] for give priority to
  /// parent [List] or [ScrollView].
  final bool isNested;

  /// A [scrollDirection] of [List].
  final Axis? scrollDirection;

  /// A state of [BasicListView].
  late _BasicListViewState _state = _BasicListViewState.normal;

  /// Number of row in [listItem] of [BasicListView.gallery].
  late int _numberOfRow = 3;

  /// Number of column in [listItem] of [BasicListView.gallery].
  late int _numberOfColumn = 3;

  // ScrollController? scrollController;

  /// A [BasicListView] is a redirect constructor (private) from other named
  /// constructor.
  SyntonicListView._({
    this.listItem,
    required _BasicListViewState state,
    this.gridItem,
    this.initialScrollIndex,
    this.isNested = false,
    this.itemScrollController,
    this.numberOfItems,
    this.numberOfItemsTotal,
    this.numberToLoad,
    this.numberOfAdditionalItems = 0,
    this.onReachBottom,
    this.onReordered,
    this.padding,
    this.isReverse = false,
    this.isReorderMode = false,
    this.scrollDirection = Axis.vertical,
    int? numberOfRow,
    int? numberOfColumn,
  }) {
    _state = state;
    _numberOfRow = numberOfRow ?? 3;
    _numberOfColumn = numberOfColumn ?? 3;
  }

  /// Create a [BasicListView] without any events.
  SyntonicListView({
    required Widget Function(int index) listItem,
    required int numberOfItems,
    bool isNested = false,
    ItemScrollController? itemScrollController,
    Axis? scrollDirection,
  }) : this._(
            listItem: listItem,
            numberOfItems: numberOfItems,
            isNested: isNested,
            itemScrollController: itemScrollController,
            scrollDirection: scrollDirection,
            state: _BasicListViewState.normal);

  /// Create a [BasicListView] without any events.
  SyntonicListView.gallery({
    required Widget Function(int index, double? width) listItem,
    required int numberOfItems,
    int? numberOfRow,
    int? numberOfColumn,
    bool isNested = false,
    ItemScrollController? itemScrollController,
    Axis? scrollDirection,
  }) : this._(
      gridItem: listItem,
      numberOfItems: numberOfItems,
    numberOfRow: numberOfRow,
      numberOfColumn: numberOfColumn,
      isNested: isNested,
      itemScrollController: itemScrollController,
      scrollDirection: scrollDirection,
      state: _BasicListViewState.gallery,
  );

  /// Create a [BasicListView] whose it's load more items, when scroll to
  /// bottom (when showed progress indicator).
  ///
  /// The constructor that [BasicListView.infinite] is include the parameters
  /// of [BasicListView.specifiable].
  /// Typically use for a [BasicListView] that has these features (Search
  /// messages and load more messages).
  SyntonicListView.infinite({
    required Widget Function(int index) listItem,
    required int numberOfItems,
    required int numberOfItemsTotal,
    int numberOfAdditionalItems = 0,
    int numberToLoad = 10,
    Function()? onReachBottom,
    EdgeInsetsGeometry? padding,
    int initialScrollIndex = 0,
    bool isNested = false,
    bool isReverse = false,
    ItemScrollController? itemScrollController,
    Axis? scrollDirection,
  }) : this._(
            listItem: listItem,
            numberOfItems: numberOfItems,
            numberOfItemsTotal: numberOfItemsTotal,
            numberOfAdditionalItems: numberOfAdditionalItems,
            numberToLoad: numberToLoad,
            onReachBottom: onReachBottom,
            padding: padding,
            initialScrollIndex: initialScrollIndex,
            isNested: isNested,
            isReverse: isReverse,
            itemScrollController: itemScrollController,
            scrollDirection: scrollDirection,
            state: _BasicListViewState.infinite);

  /// Create a [BasicListView] whose it can reorder items.
  SyntonicListView.reorderable({
    required Widget Function(int index) listItem,
    required int numberOfItems,
    required Function(int newIndex, int oldIndex)? onReordered,
    required bool isReorderMode,
    bool isNested = false,
    bool isReverse = false,
    ItemScrollController? itemScrollController,
    Axis? scrollDirection,
  }) : this._(
            listItem: listItem,
            numberOfItems: numberOfItems,
            onReordered: onReordered,
            isReorderMode: isReorderMode,
            isNested: isNested,
            isReverse: isReverse,
            itemScrollController: itemScrollController,
            scrollDirection: scrollDirection,
            state: _BasicListViewState.reorderable);

  /// Create a [BasicListView] whose it can specify an index of item, and can
  /// scroll to a scroll position of an index.
  SyntonicListView.specifiable({
    required Widget Function(int index, {double width, double height}) listItem,
    required int numberOfItems,
    int initialScrollIndex = 0,
    bool isNested = false,
    ItemScrollController? itemScrollController,
    Axis? scrollDirection,
  }) : this._(
            listItem: listItem,
            numberOfItems: numberOfItems,
            initialScrollIndex: initialScrollIndex,
            isNested: isNested,
            itemScrollController: itemScrollController,
            scrollDirection: scrollDirection,
            state: _BasicListViewState.specifiable);

  @override
  Widget build(BuildContext context) {
    int _circularProgressIndicatorCount = 1;
    int _itemCount = numberOfItems! +
        numberOfAdditionalItems! +
        _circularProgressIndicatorCount;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => InfiniteLoadingListViewModel(
                  context: context, currentMax: numberToLoad ?? 0)),
        ],
        child: Consumer<InfiniteLoadingListViewModel>(
            builder: (context, model, child) {
          switch (_state) {
            case _BasicListViewState.normal:
            case _BasicListViewState.infinite:
              return ListView.builder(
                controller: isNested ? ScrollController() : null,
                  padding: EdgeInsets.zero,
                  reverse: isReverse,
                  scrollDirection: scrollDirection ?? Axis.vertical,
                  // shrinkWrap: isNested ? true : false,
                  // physics: isNested ? const NeverScrollableScrollPhysics() : null,
                  itemCount: _itemCount,
                  itemBuilder: (BuildContext context, int index) {
                    bool _isMaxIndex = index == _itemCount - 1;
                    if (_isMaxIndex && numberOfItems! < numberOfItemsTotal!) {
                      return VisibilityDetector(
                        key: const Key("Progress indicator"),
                        onVisibilityChanged: (info) {
                          if (info.visibleFraction > 0.1 &&
                              onReachBottom != null) {
                            onReachBottom!();
                          }
                        },
                        child:
                        const SyntonicProgressIndicator(iShowProgress: true),
                      );
                    }
                    if (index < numberOfItems! + numberOfAdditionalItems!) {
                      return listItem!(index);
                    }
                    return SizedBox();
                  });
            case _BasicListViewState.specifiable:
              return ScrollablePositionedList.builder(
                  initialScrollIndex: initialScrollIndex ?? 0,
                  reverse: isReverse,
                  scrollDirection: scrollDirection ?? Axis.vertical,
                  itemScrollController: itemScrollController,
                  shrinkWrap: isNested ? true : false,
                  physics:
                      isNested ? const NeverScrollableScrollPhysics() : null,
                  itemCount: _itemCount,
                  itemBuilder: (BuildContext context, int index) {
                    bool _isMaxIndex = index == _itemCount - 1;
                    if (_isMaxIndex && numberOfItems! < numberOfItemsTotal!) {
                      return VisibilityDetector(
                        key: const Key("Progress indicator"),
                        onVisibilityChanged: (info) {
                          if (info.visibleFraction > 0.1 &&
                              onReachBottom != null) {
                            onReachBottom!();
                          }
                        },
                        child:
                            const SyntonicProgressIndicator(iShowProgress: true),
                      );
                    }
                    if (index < numberOfItems! + numberOfAdditionalItems!) {
                      return listItem!(index);
                    }
                    return SizedBox();
                  });
            case _BasicListViewState.reorderable:
              return ReorderableListView.builder(
                  itemCount: numberOfItems!,
                  itemBuilder: (BuildContext context, int index) {
                    return listItem!(index);
                  },
                  scrollDirection: scrollDirection ?? Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  buildDefaultDragHandles: isReorderMode,
                  onReorder: (oldIndex, newIndex) {
                    // Removing the item at oldIndex will shorten the list by 1.
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    onReordered!(newIndex, oldIndex);
                  });
            case _BasicListViewState.gallery:
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < (numberOfItems! / _numberOfRow).ceil(); i++)
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Container(width: 700, height:50, color: i == 0 ? Colors.red : Colors.blue)
                            for (var j = 0; j < (numberOfItems! - _index(i, j, _numberOfRow) < 0 ? _index(i, j, _numberOfRow) * - 1 : _numberOfRow); j++)
                              Container(alignment: Alignment.topLeft, width: MediaQuery.of(context).size.width * (1 / _numberOfColumn) + (MediaQuery.of(context).size.width * (1 / _numberOfColumn) / _numberOfColumn), child: gridItem!(((numberOfItems! - (numberOfItems! - i * _numberOfRow)) + j), MediaQuery.of(context).size.width * (1 / _numberOfColumn) + (MediaQuery.of(context).size.width * (1 / _numberOfColumn) / _numberOfColumn))),

                            //   Container(width: MediaQuery.of(context).size.width - 56, child: Expanded(child: listItem(((numberOfItems! - (numberOfItems! - i * _numberOfItemsInColumn)) + j)),)),
                          ]
                      )
                  ],),
              );
          }
        }));
  }

  /// Index.
  int _index(int i, int j, int _numberOfItemsInColumn) {
    return (((numberOfItems! - (numberOfItems! - i * _numberOfItemsInColumn)) + j + 1));
  }
}

class InfiniteLoadingListViewModel extends ChangeNotifier {
  BuildContext context;
  // int max = 20;
  int currentMax = 20; // 一回に表示されるリストカウント
  bool hasMoreData = true;

  void getMoreDataCount(int currentMax){
    print("get more data");
    // notifyListeners();
  }

  InfiniteLoadingListViewModel({required this.context, required this.currentMax}) {
    // createSyntonicerModel();
  }

  void changeMoreDataStatus(bool hasMoreData){
    // notifyListeners();
  }
}
