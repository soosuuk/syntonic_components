import 'package:syntonic_components/widgets/enhancers/syntonic_animation_enhancer.dart';
import 'package:syntonic_components/widgets/icons/syntonic_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:syntonic_components/widgets/lists/syntonic_list_item.dart';
import 'package:syntonic_components/widgets/texts/body_2_text.dart';
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

const TextStyle _kStepStyle = TextStyle(
  fontSize: 12.0,
  color: Colors.white,
);
const Color _kErrorLight = Colors.red;
final Color _kErrorDark = Colors.red.shade400;
const Color _kCircleActiveLight = Colors.white;
const Color _kCircleActiveDark = Colors.black87;
const Color _kDisabledLight = Colors.black38;
const Color _kDisabledDark = Colors.white38;
const double _kStepSize = 24.0;
const double _kTriangleHeight = _kStepSize * 0.866025; // T

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

  final Widget? Function(int index)? stepIcon;

  /// Execute [onReordered] when an item has been reordered.
  final Function(int newIndex, int oldIndex)? onReordered;

  /// Enable the [buildDefaultDragHandles], when the [isReorderMode] is true.
  final bool isReorderMode;

  /// An [itemScrollController] of a [BasicListView].
  final ItemScrollController? itemScrollController;

  /// Whether [BasicListView] is nested?
  /// In case of nested, change [shrinkWrap], [physics] for give priority to
  /// parent [List] or [ScrollView].
  final bool isNested;

  final bool hasStepper;

  /// A [scrollDirection] of [List].
  final Axis? scrollDirection;

  /// A state of [BasicListView].
  final _BasicListViewState state;

  /// Number of row in [listItem] of [BasicListView.gallery].
  final int numberOfRow;

  /// Number of column in [listItem] of [BasicListView.gallery].
  final int numberOfColumn;

  final Function(int index, bool isBefore)? onAdded;

  final Function()? onTimeButtonTapped;


  // ScrollController? scrollController;

  /// A [BasicListView] is a redirect constructor (private) from other named
  /// constructor.
  const SyntonicListView._({
    this.listItem,
    this.gridItem,
    this.stepIcon,
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
    this.hasStepper = false,
    this.scrollDirection = Axis.vertical,
    this.state = _BasicListViewState.normal,
    this.numberOfRow = 3,
    this.numberOfColumn = 3,
    this.onAdded,
    this.onTimeButtonTapped,
  });

  /// Create a [BasicListView] without any events.
  const SyntonicListView({
    required Widget Function(int index) listItem,
    required int numberOfItems,
    required int numberOfItemsTotal,
    bool isNested = false,
    ItemScrollController? itemScrollController,
    Axis? scrollDirection,
  }) : this._(
            listItem: listItem,
            numberOfItems: numberOfItems,
            numberOfItemsTotal: numberOfItemsTotal,
            isNested: isNested,
            itemScrollController: itemScrollController,
            scrollDirection: scrollDirection,
            state: _BasicListViewState.normal);

  /// Create a [BasicListView] without any events.
  const SyntonicListView.gallery({
    required Widget Function(int index, double? width) listItem,
    required int numberOfItems,
    int numberOfRow = 3,
    int numberOfColumn = 3,
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
  const SyntonicListView.infinite({
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
  const SyntonicListView.reorderable({
    required Widget Function(int index) listItem,
    required int numberOfItems,
    required Function(int newIndex, int oldIndex)? onReordered,
    required Function(int index, bool isBefore)? onAdded,
    required Function()? onTimeButtonTapped,
    required bool isReorderMode,
    Widget? Function(int index)? stepIcon,
    bool isNested = false,
    bool isReverse = false,
    ItemScrollController? itemScrollController,
    Axis? scrollDirection,
    bool hasStepper = false,

  }) : this._(
            listItem: listItem,
            numberOfItems: numberOfItems,
            onReordered: onReordered,
            onAdded: onAdded,
      onTimeButtonTapped: onTimeButtonTapped,
            isReorderMode: isReorderMode,
            stepIcon: stepIcon,
            isNested: isNested,
            isReverse: isReverse,
            hasStepper: hasStepper,
            itemScrollController: itemScrollController,
            scrollDirection: scrollDirection,
            state: _BasicListViewState.reorderable);

  /// Create a [BasicListView] whose it can specify an index of item, and can
  /// scroll to a scroll position of an index.
  const SyntonicListView.specifiable({
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

  final _circularProgressIndicatorCount = 1;
  int get _itemCount =>
      numberOfItems! +
      numberOfAdditionalItems! +
      _circularProgressIndicatorCount;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => InfiniteLoadingListViewModel(
                  context: context, currentMax: numberToLoad ?? 0)),
        ],
        child: Consumer<InfiniteLoadingListViewModel>(
            builder: (context, model, child) {
          switch (state) {
            case _BasicListViewState.normal:
            case _BasicListViewState.infinite:
              return ListView.builder(
                  controller: isNested ? ScrollController() : null,
                  padding: const EdgeInsets.only(bottom: 200),
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
                        child: const SyntonicProgressIndicator(
                            iShowProgress: true),
                      );
                    }
                    if (index < numberOfItems! + numberOfAdditionalItems!) {
                      // return listItem!(index);
                      return Padding(
                        padding: EdgeInsets.only(
                            top: index == 0 ? 16 : 8,
                            left: 16,
                            right: 16,
                            bottom: index == (numberOfItems! - 1) ? 16 : 8),
                        child: listItem!(index),
                      );
                    }
                    return const SizedBox();
                  });
            case _BasicListViewState.specifiable:
              return ScrollablePositionedList.builder(
                  padding: const EdgeInsets.only(bottom: 200),
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
                        child: const SyntonicProgressIndicator(
                            iShowProgress: true),
                      );
                    }
                    if (index < numberOfItems! + numberOfAdditionalItems!) {
                      return listItem!(index);
                    }
                    return const SizedBox();
                  });
            case _BasicListViewState.reorderable:
              return ReorderableListView.builder(
                  padding: const EdgeInsets.only(bottom: 200),
                  // scrollController: ScrollController(),
                  shrinkWrap: true,
                  // physics:
                  // const NeverScrollableScrollPhysics(),
                  itemCount: numberOfItems!,
                  itemBuilder: (_, int index) {
                    final isFirst = index == 0;
                    final isLast = index == numberOfItems! - 1;
                    final timelineTile = <Widget>[
                      SizedBox(
                        height: double.infinity / 2,
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const SizedBox(
                                  height: 56,
                                ),
                                CustomPaint(
                                    painter: DottedLinePainter(
                                  color: Theme.of(context).colorScheme.tertiary,
                                )),
                              ],
                            ),
                            SizedBox(
                              height: double.infinity,
                              // width: 60,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        isFirst ? SizedBox(
                                                height: 16,
                                              )
                                            : SizedBox(
                                          height: 16,
                                          child: CustomPaint(
                                              painter: DottedLinePainter(
                                                height: 16,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary,
                                              )),
                                        ),
                                        isFirst
                                            ? Padding(
                    padding: EdgeInsets.only(
                    top: isFirst ? 0 : 0),
                    child: stepIcon!(index)!,
                    )
                                            : const SizedBox(),
                                        isFirst
                                            ? SizedBox(
                                          height: 16,
                                          child: CustomPaint(
                                              painter: DottedLinePainter(
                                                height: 16,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary,
                                              )),
                                        )
                                            : const SizedBox(),
                                        SyntonicIcon(
                                          hasBorder: true,
                                          icon: Icons.add,
                                          padding: 0,
                                          onPressed: () =>
                                              onAdded!(index, true),
                                        ),
                                        SizedBox(
                                          height: 16,
                                          child: CustomPaint(
                                              painter: DottedLinePainter(
                                                height: 16,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary,
                                              )),
                                        ),
                                        !isFirst ? Padding(
                                          padding: EdgeInsets.only(
                                              top: isFirst ? 0 : 0),
                                          child: stepIcon!(index)!,
                                        ) : const SizedBox(),
                                      ],
                                    ),
                                    // Expanded(child: DottedLinePainter(
                                    //   color: Theme.of(context)
                                    //       .colorScheme
                                    //       .tertiary,
                                    // )),
                                    Expanded(
                                        child: CustomPaint(
                                      painter: DottedLinePainter(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary),
                                    )),
                                    // Padding(
                                    //   padding: EdgeInsets.only(
                                    //       bottom: isLast ? 0 : 0),
                                    //   child: SyntonicIcon(
                                    //     hasBorder: true,
                                    //     icon: Icons.add,
                                    //     padding: 0,
                                    //     onPressed: () => onAdded!(index, false),
                                    //   ),
                                    // ),
                                    // !isLast
                                    //     ? SizedBox(
                                    //         height: 16,
                                    //         child: CustomPaint(
                                    //             painter: DottedLinePainter(
                                    //           height: 16,
                                    //           color: Theme.of(context)
                                    //               .colorScheme
                                    //               .tertiary,
                                    //         )),
                                    //       )
                                    //     : const SizedBox(),
                                    isLast
                                        ? SyntonicIcon(
                                      hasBorder: true,
                                      icon: Icons.add,
                                      padding: 0,
                                      onPressed: () =>
                                          onAdded!(index, true),
                                    )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(width: 4),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.zero,
                          child: Column(
                            children: [
                              // isFirst
                              //     ? Container(
                              //   alignment: Alignment.centerLeft,
                              //   padding: EdgeInsets.only(top: 24),
                              //   height: 56,
                              //   child: Body2Text(
                              //     text: 'Add start time',
                              //     textColor: Theme.of(context)
                              //         .colorScheme
                              //         .primary
                              //         .withOpacity(0.72),
                              //   ),
                              // )
                              //     : const SizedBox(),
                              // isFirst
                              //     ? Container(
                              //         alignment: Alignment.centerLeft,
                              //         height: 70,
                              //         child: Body2Text(
                              //           text: 'Add step',
                              //           textColor: Theme.of(context)
                              //               .colorScheme
                              //               .primary
                              //               .withOpacity(0.72),
                              //         ),
                              //       )
                              //     : const SizedBox(),
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: SyntonicAnimationEnhancer(
                                  child: listItem!(index),
                                ),
                              ),
                              // Container(
                              //   alignment: Alignment.centerLeft,
                              //   height: 56,
                              //   child: Body2Text(
                              //       text: 'Add step',
                              //       textColor: Theme.of(context)
                              //           .colorScheme
                              //           .primary
                              //           .withOpacity(0.72)),
                              // )
                            ],
                          ),
                        ),
                      ),
                    ];

                    return RepaintBoundary(
                      key: ValueKey(index),
                      child: IntrinsicHeight(
                        child: hasStepper
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: timelineTile,
                                // isLeftAligned ? timelineTile : timelineTile.reversed.toList(),
                              )
                            : SyntonicAnimationEnhancer(
                                child: listItem!(index),
                              ),
                      ),
                    );
                  },
                  scrollDirection: scrollDirection ?? Axis.vertical,
                  // shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  buildDefaultDragHandles: isReorderMode,
                  onReorder: (oldIndex, newIndex) {
                    // Removing the item at oldIndex will shorten the list by 1.
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    onReordered!(newIndex, oldIndex);
                  });
            case _BasicListViewState.gallery:
              // Container(height: 200, width: 200, child:    gridItem!(0, 200),)
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0;
                        i < (numberOfItems! / numberOfRow).ceil();
                        i++)
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Container(width: 700, height:50, color: i == 0 ? Colors.red : Colors.blue)
                            for (var j = 0;
                                j <
                                    (numberOfItems! -
                                                _index(i, j, numberOfRow) <
                                            0
                                        ? _index(i, j, numberOfRow) * -1
                                        : numberOfRow);
                                j++)
                              Container(
                                  alignment: Alignment.topLeft,
                                  width: MediaQuery.of(context).size.width *
                                          (1 / numberOfColumn) +
                                      (MediaQuery.of(context).size.width *
                                          (1 / numberOfColumn) /
                                          numberOfColumn),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: (numberOfItems! -
                                                        (numberOfItems! -
                                                            i * numberOfRow)) +
                                                    j ==
                                                0
                                            ? 16
                                            : 4,
                                        right: (numberOfItems! -
                                                        (numberOfItems! -
                                                            i * numberOfRow)) +
                                                    j ==
                                                numberOfItems
                                            ? 16
                                            : 4),
                                    child: gridItem!(
                                        (numberOfItems! -
                                                (numberOfItems! -
                                                    i * numberOfRow)) +
                                            j,
                                        MediaQuery.of(context).size.width *
                                                (1 / numberOfColumn) +
                                            (MediaQuery.of(context).size.width *
                                                (1 / numberOfColumn) /
                                                numberOfColumn)),
                                  )),

                            //   Container(width: MediaQuery.of(context).size.width - 56, child: Expanded(child: listItem(((numberOfItems! - (numberOfItems! - i * _numberOfItemsInColumn)) + j)),)),
                          ])
                  ],
                ),
              );
          }
        }));
  }

  /// Index.
  int _index(int i, int j, int _numberOfItemsInColumn) {
    return (((numberOfItems! - (numberOfItems! - i * _numberOfItemsInColumn)) +
        j +
        1));
  }
}

class InfiniteLoadingListViewModel extends ChangeNotifier {
  BuildContext context;
  // int max = 20;
  int currentMax = 20; // 一回に表示されるリストカウント
  bool hasMoreData = true;

  void getMoreDataCount(int currentMax) {
    print("get more data");
    // notifyListeners();
  }

  InfiniteLoadingListViewModel(
      {required this.context, required this.currentMax}) {
    // createSyntonicerModel();
  }

  void changeMoreDataStatus(bool hasMoreData) {
    // notifyListeners();
  }
}

class _TimelinePainter extends CustomPainter {
  _TimelinePainter({
    required this.hideDefaultIndicator,
    required this.indicatorColor,
    required this.indicatorStyle,
    required this.indicatorSize,
    required this.lineGap,
    required this.strokeCap,
    required this.strokeWidth,
    required this.style,
    required this.lineColor,
    required this.isFirst,
    required this.isLast,
    required this.itemGap,
  })  : linePaint = Paint()
          ..color = lineColor
          ..strokeCap = strokeCap
          ..strokeWidth = strokeWidth
          ..style = style,
        circlePaint = Paint()
          ..color = indicatorColor
          ..style = indicatorStyle;

  final bool hideDefaultIndicator;
  final Color indicatorColor;
  final PaintingStyle indicatorStyle;
  final double indicatorSize;
  final double lineGap;
  final StrokeCap strokeCap;
  final double strokeWidth;
  final PaintingStyle style;
  final Color lineColor;
  final Paint linePaint;
  final Paint circlePaint;
  final bool isFirst;
  final bool isLast;
  final double itemGap;

  @override
  void paint(Canvas canvas, Size size) {
    final indicatorRadius = indicatorSize / 2;
    final halfItemGap = itemGap / 2;
    final indicatorMargin = indicatorRadius + lineGap;

    final top = size.topLeft(Offset(indicatorRadius, 0.0 - halfItemGap));
    final centerTop = size.centerLeft(
      Offset(indicatorRadius, -indicatorMargin),
    );

    final bottom = size.bottomLeft(Offset(indicatorRadius, 0.0 + halfItemGap));
    final centerBottom = size.centerLeft(
      Offset(indicatorRadius, indicatorMargin),
    );

    if (!isFirst) canvas.drawLine(top, centerTop, linePaint);
    if (!isLast) canvas.drawLine(centerBottom, bottom, linePaint);

    if (!hideDefaultIndicator) {
      final Offset offsetCenter = size.centerLeft(Offset(indicatorRadius, 0));

      canvas.drawCircle(offsetCenter, indicatorRadius, circlePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DottedLinePainter extends CustomPainter {
  DottedLinePainter({this.color, this.height});
  final Color? color;
  final double? height;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color ?? Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const double dashWidth = 2;
    const double dashSpace = 2;
    double startY = 0;

    while (startY < (height ?? size.height)) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class RoundedRectDiamondPainter extends CustomPainter {
  final Color? color;
  final double? borderRadius;

  RoundedRectDiamondPainter({this.color, this.borderRadius});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color ?? Colors.black;
    Path path = Path();

    path.moveTo(size.width / 2, 0); // 上部の頂点
    path.lineTo(size.width, size.height / 2); // 右側の点
    path.lineTo(size.width / 2, size.height); // 下部の点
    path.lineTo(0, size.height / 2); // 左側の点
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(RoundedRectDiamondPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(RoundedRectDiamondPainter oldDelegate) => false;
}
