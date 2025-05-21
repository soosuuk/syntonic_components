import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syntonic_components/services/navigation_service.dart';

abstract class SyntonicModalBottomSheet<
    VM extends SyntonicModalBottomSheetViewModel<VS>,
    VS extends SyntonicModalBottomSheetViewState> {
  SyntonicModalBottomSheet(
      {Key? key,
      this.actionName,
      required this.vm,
      this.initialSize,
      this.shouldAdjustExtentToChild = false})
      : super();
  final VM vm;
  final double? initialSize;
  final String? actionName;
  final bool shouldAdjustExtentToChild;
  // final GlobalKey childKey = GlobalKey();
  // final GlobalKey bottomBarKey = GlobalKey();
  // final ValueNotifier<double> extentNotifier = ValueNotifier<double>(0.5);

  VM viewModel(WidgetRef ref) => ref.read(provider.notifier);
  StateNotifierProvider<VM, VS> get provider =>
      StateNotifierProvider<VM, VS>((ref) => vm);

  Widget bottomBar(
      {required BuildContext context,
      required WidgetRef ref,
      required double extent});
  Widget additionalSheetChild(
      {required BuildContext context,
      required WidgetRef ref,
      required double extent});
  List<String> covers(
      {required BuildContext context,
      required WidgetRef ref,
      required double extent});
  Widget appBar(
      {required BuildContext context,
      required WidgetRef ref,
      required double extent});
  Widget child(
      {required BuildContext context,
      required WidgetRef ref,
      required double extent});
  Future<bool> Function()? onPop(
      {required BuildContext context, required WidgetRef ref});

  onFocusChange({required BuildContext context, required WidgetRef ref}) {
    // final RenderBox renderBox = childKey.currentContext!.findRenderObject() as RenderBox;
    // final double childHeight = renderBox.size.height;
    // final RenderBox renderBoxBottom = bottomBarKey.currentContext!.findRenderObject() as RenderBox;
    // final double bottomHeight = renderBoxBottom.size.height;
    // final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    // viewModel(ref).updateMinExtent((bottomHeight + childHeight + bottomInset + 34) / (MediaQuery.of(context).size.height - kToolbarHeight * 2));
  }

  /// Open modal bottom sheet.
  openModalBottomSheet<S>({
    required BuildContext context,
  }) {
    showModalBottomSheet(
        enableDrag: true,
        useSafeArea: false,
        isScrollControlled: true,
        clipBehavior: Clip.hardEdge,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Consumer(builder: (context, ref, _) {
            return LayoutBuilder(builder: (_, constraints) {
              return Padding(
                padding: const EdgeInsets.only(
                  top: 0,
                ),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  // appBar: appBar(
                  //     context: context,
                  //     ref: ref,
                  //     extent: viewModel(ref).state.currentExtent) as PreferredSizeWidget?,
                  // resizeToAvoidBottomInset: false,
                  bottomSheet: bottomBar(
                      context: context,
                      ref: ref,
                      extent: viewModel(ref).state.currentExtent),
                  body: ContentsWidget(
                    context: context,
                    ref: ref,
                    constraints: constraints,
                    onPop: onPop(context: context, ref: ref),
                    covers: covers(
                        context: context,
                        ref: ref,
                        extent: viewModel(ref).state.currentExtent),
                    appBar: appBar(
                        context: context,
                        ref: ref,
                        extent: viewModel(ref).state.currentExtent),
                    bottomBar: bottomBar(
                        context: context,
                        ref: ref,
                        extent: viewModel(ref).state.currentExtent),
                    additionalSheetChild: additionalSheetChild(
                        context: context,
                        ref: ref,
                        extent: viewModel(ref).state.currentExtent),
                    viewModel: vm,
                    provider: provider,
                    shouldAdjustExtentToChild: shouldAdjustExtentToChild,
                    child: child(
                        context: context,
                        ref: ref,
                        extent: viewModel(ref).state.currentExtent),
                  ),
                ),
              );
            });
          });
        });
  }
}

abstract class SyntonicModalBottomSheetViewModel<
    VS extends SyntonicModalBottomSheetViewState> extends StateNotifier<VS> {
  SyntonicModalBottomSheetViewModel({required VS viewState})
      : super(viewState) {
    pageController.addListener(() {
      if (pageController.positions.isNotEmpty) {
        state = state.copyWith(currentPageIndex: pageController.page!) as VS;
      }
    });
  }

  final double maxExtent = 1.0;
  final DraggableScrollableController controller =
      DraggableScrollableController();
  PageController pageController = PageController();

  void scrollToMaxExtent() {
    controller.animateTo(
      1.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void updateExtent(double extent) {
    state = state.copyWith(currentExtent: extent) as VS;
  }

  void updateMinExtent(double extent) {
    state = state.copyWith(minExtent: extent) as VS;
  }

  // void updateAdditionalSheetVisibility(bool isVisible) {
  //   state = state.copyWith(isAdditionalSheetVisible: isVisible) as VS;
  // }

  @override
  set state(VS value) {
    super.state = value;
  }

  @override
  VS get state => super.state;
}

class SyntonicModalBottomSheetViewState {
  SyntonicModalBottomSheetViewState(
      {this.currentPageIndex = 0,
      required this.currentExtent,
      this.minExtent = 0.5,
      this.isAdditionalSheetVisible = false});
  final double currentPageIndex;
  final double currentExtent;
  final double minExtent;
  final bool isAdditionalSheetVisible;

  SyntonicModalBottomSheetViewState copyWith({
    double? currentPageIndex,
    double? currentExtent,
    double? minExtent,
    bool? isAdditionalSheetVisible,
  }) {
    return SyntonicModalBottomSheetViewState(
        currentPageIndex: currentPageIndex ?? this.currentPageIndex,
        currentExtent: currentExtent ?? this.currentExtent,
        minExtent: minExtent ?? this.minExtent,
        isAdditionalSheetVisible:
            isAdditionalSheetVisible ?? this.isAdditionalSheetVisible);
  }
}

class ContentsWidget<VM extends SyntonicModalBottomSheetViewModel<VS>,
    VS extends SyntonicModalBottomSheetViewState> extends StatefulWidget {
  final BuildContext context;
  final WidgetRef ref;
  final BoxConstraints constraints;
  final Widget child;
  final Future<bool> Function()? onPop;
  final List<String> covers;
  final Widget appBar;
  final Widget bottomBar;
  final Widget additionalSheetChild;
  final String? actionName;
  final VM viewModel;
  final StateNotifierProvider<VM, VS> provider;
  final bool shouldAdjustExtentToChild;

  const ContentsWidget({
    required this.context,
    required this.ref,
    required this.constraints,
    required this.child,
    required this.onPop,
    required this.covers,
    required this.appBar,
    required this.bottomBar,
    required this.additionalSheetChild,
    this.actionName,
    required this.viewModel,
    required this.provider,
    required this.shouldAdjustExtentToChild,
  });

  @override
  _ContentsWidgetState createState() => _ContentsWidgetState();
}

class _ContentsWidgetState extends State<ContentsWidget> {
  late PageController pageController;
  late ValueNotifier<double> extentNotifier;
  late GlobalKey childKey;
  double _contentHeight = 0.5;
  final double _previousExtent = 0.0;
  double height = 0.0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
        initialPage: widget.viewModel.state.currentPageIndex.toInt());
    extentNotifier = ValueNotifier<double>(_contentHeight);
    childKey = GlobalKey();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final double childHeight =
          (childKey.currentContext!.findRenderObject() as RenderBox)
              .size
              .height;
      final _extent = childHeight /
          (widget.constraints.maxHeight -
              kToolbarHeight -
              MediaQuery.of(
                      NavigationService().navigatorKey.currentState!.context)
                  .viewPadding
                  .top);
      print('キーボード処理中');
      print('childHeight: $childHeight');
      print('extent: $_extent');

      setState(() {
        height = childHeight;
        extentNotifier = ValueNotifier<double>(_extent);
        _contentHeight = _extent;
      });
    });
    // }
  }

  @override
  Widget build(BuildContext context) {
    double adjustedMinChildSize = (kToolbarHeight +
            MediaQuery.of(
                    NavigationService().navigatorKey.currentState!.context)
                .viewPadding
                .top) /
        widget.constraints.maxHeight;
    print('adjustedMinChildSize: $adjustedMinChildSize');
    print('contentHeight: $_contentHeight');
    print('m: ${_contentHeight + adjustedMinChildSize}');
    double _m = _contentHeight + adjustedMinChildSize;

    double _minExtent = widget.shouldAdjustExtentToChild ? _m : 0.5;
    print('final minExtent: $_minExtent');
    double actualHeight = _minExtent *
        (widget.constraints.maxHeight - MediaQuery.of(NavigationService()
            .navigatorKey
            .currentState!
            .context).viewInsets.bottom -
            (MediaQuery.of(NavigationService()
                .navigatorKey
                .currentState!
                .context)
                .viewPadding
                .top +
                kToolbarHeight));
    print('actualHeight: $actualHeight');
    print('height: $height');
    // double actualHeight = _minExtent *
    //     (widget.constraints.maxHeight -
    //         (kToolbarHeight));
    // double _minExtent = _m < 0.5 ? 0.5 : (_m > 1 ? 0.5 : _m);

    // bool _isAdditionalSheetVisible = widget.ref.watch(widget.provider.select(
    //     (viewState) => viewState.isAdditionalSheetVisible));
    // if (_isAdditionalSheetVisible) {
    //   AnimatedBottomSheet.show();
    // } else {
    //   AnimatedBottomSheet.hide();
    // }

    return Column(
      children: [
        ValueListenableBuilder<double>(
          valueListenable: extentNotifier,
          builder: (context, extent, child) {
            print('extent: $extent');
            print('minExtent: $_minExtent');
            final double opacity = extent > _minExtent
                ? (extent - _minExtent) /
                    (widget.viewModel.maxExtent - _minExtent)
                : 0;
            return Opacity(
              opacity: opacity.clamp(widget.covers.isNotEmpty ? 1 : 0.0, 1.0),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(NavigationService()
                            .navigatorKey
                            .currentState!
                            .context)
                        .viewPadding
                        .top,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  widget.appBar
                ],
              ),
            );
          },
        ),
        Expanded(
          child: NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              print('きた');
              print('extent: ${notification.extent}');
              print('minExtent: ${widget.viewModel.state.minExtent}');
              print('maxExtent: ${widget.viewModel.maxExtent}');
              AnimatedBottomSheet.hide();
              // widget.viewModel.updateAdditionalSheetVisibility(false);
              extentNotifier.value = notification.extent;
              if (notification.maxExtent == notification.extent ||
                  widget.viewModel.state.minExtent == notification.extent) {
                widget.viewModel.updateExtent(notification.extent);
              }
              return true;
            },
            child: Container(
                  color: Colors.transparent,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      GestureDetector(
                          onTap: () async {
                            AnimatedBottomSheet.hide();
                            bool canPop = await widget.onPop!();
                            if (canPop) {
                              Navigator.of(context).pop();
                            }
                          },),
                      widget.covers.isNotEmpty
                          ? Positioned.fill(
                              bottom: actualHeight,
                              left: 0,
                              right: 0,
                              child: TweenAnimationBuilder(
                                tween: Tween<double>(begin: 1.2, end: 1.0),
                                duration: const Duration(milliseconds: 1300),
                                curve: Curves.fastEaseInToSlowEaseOut,
                                builder: (context, double scale, child) {
                                  return Transform.scale(
                                    scale: scale,
                                    child: child,
                                  );
                                },
                                child: PageView(
                                  children: widget.covers
                                      .map((coverUrl) => Image.network(
                                            coverUrl,
                                            fit: BoxFit
                                                .cover, // Covers the entire screen
                                          ))
                                      .toList(),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      Padding(
                        padding: EdgeInsets.only(bottom: actualHeight),
                        child: AnimatedBottomSheet(
                            additionalSheetChild: widget.additionalSheetChild),
                      ),
                      DraggableScrollableSheet(
                        initialChildSize: _minExtent,
                        maxChildSize: widget.viewModel.maxExtent,
                        minChildSize: _minExtent,
                        expand: false,
                        snap: true,
                        snapSizes: [
                          _minExtent,
                          1,
                        ],
                        controller: widget.viewModel.controller,
                        builder: (BuildContext context,
                            ScrollController scrollController) {
                          return ColoredBox(
                                  color: Theme.of(context).colorScheme.surface,
                                  // color: Colors.purple,
                                  child: Navigator(
                                    onGenerateRoute: (context) =>
                                        MaterialPageRoute(
                                      builder: (context) =>
                                          SingleChildScrollView(
                                              controller: scrollController,
                                              physics:
                                                  const ClampingScrollPhysics(),
                                              child: Container(
                                                key: childKey,
                                                // color: Colors.blue,
                                                child: Column(
                                                  children: [
                                                    ValueListenableBuilder<
                                                        double>(
                                                      valueListenable:
                                                          extentNotifier,
                                                      builder: (context, extent,
                                                          child) {
                                                        final double height = (1 -
                                                                (extent -
                                                                        _minExtent) /
                                                                    (widget.viewModel
                                                                            .maxExtent -
                                                                        _minExtent)) *
                                                            16; // Adjust the multiplier as needed
                                                        final double width = (1 -
                                                                (extent -
                                                                        _minExtent) /
                                                                    (widget.viewModel
                                                                            .maxExtent -
                                                                        _minExtent)) *
                                                            32; // Adjust the multiplier as needed
                                                        return SizedBox(
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              vertical:
                                                                  height.clamp(
                                                                      0.0,
                                                                      16.0),
                                                            ),
                                                            child: Container(
                                                              width:
                                                                  width.clamp(
                                                                      0.0,
                                                                      32.0),
                                                              decoration: BoxDecoration(
                                                                color: Theme.of(context).colorScheme.outlineVariant,
                                                                borderRadius: BorderRadius.circular(3), // Adjust the radius as needed
                                                              ),
                                                              height:
                                                                  3, // Ensure height is within the desired range
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    widget.child,
                                                    Opacity(
                                                      opacity: 0,
                                                      child: SizedBox(
                                                        child: widget.bottomBar,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )),
                                    ),
                                  ),
                                );
                        },
                      ),
                      // Container(
                      //   color: Colors.red,
                      //   width: MediaQuery.of(context).size.width,
                      //   height: 100,
                      // ),
                    ],
                  )),
          ),
        ),
      ],
    );
  }
}

class AnimatedBottomSheet extends StatefulWidget {
  final Widget additionalSheetChild;

  const AnimatedBottomSheet({Key? key, required this.additionalSheetChild})
      : super(key: key);

  static final _controller = _AnimatedBottomSheetController();

  static void show() => _controller.show();
  static void hide() => _controller.hide();
  static void toggle() => _controller.toggle();
  static bool? get isVisible => _controller._state?._isAdditionalSheetVisible;

  @override
  State<AnimatedBottomSheet> createState() => _AnimatedBottomSheetState();
}

class _AnimatedBottomSheetState extends State<AnimatedBottomSheet>
    with SingleTickerProviderStateMixin {
  bool _isAdditionalSheetVisible = false;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    AnimatedBottomSheet._controller._bindState(this);

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _show() {
    if (mounted) {
      setState(() {
        _isAdditionalSheetVisible = true;
        _animationController.forward();
      });
    }
  }

  void _hide() {
    if (!_isAdditionalSheetVisible) {
      return;
    }

    if (mounted) {
      _animationController.reverse().then((_) {
        if (mounted) {
          setState(() {
            _isAdditionalSheetVisible = false;
          });
        }
      });
    }
  }

  void _toggle() {
    if (mounted) {
      if (_isAdditionalSheetVisible) {
        _animationController.reverse().then((_) {
          if (mounted) {
            setState(() {
              _isAdditionalSheetVisible = false;
            });
          }
        });
      } else {
        setState(() {
          _isAdditionalSheetVisible = true;
        });
        _animationController.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _isAdditionalSheetVisible,
      child: SlideTransition(
        position: _slideAnimation,
        child: SizedBox(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ColoredBox(
                  color: Theme.of(context).colorScheme.surface,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: widget.additionalSheetChild,
                      ),
                      const Divider(height: 0, thickness: 1),
                    ],
                  ));
            },
          ),
        ),
      ),
    );
  }
}

// コントローラーでシートの制御
class _AnimatedBottomSheetController {
  _AnimatedBottomSheetState? _state;

  void _bindState(_AnimatedBottomSheetState state) {
    _state = state;
  }

  void show() {
    if (_state != null) {
      _state?._show();
    } else {
      print('Error: _state is null.');
    }
  }

  void hide() {
    if (_state != null) {
      _state?._hide();
    } else {
      print('Error: _state is null.');
    }
  }

  void toggle() {
    if (_state != null) {
      _state?._toggle();
    } else {
      print('Error: _state is null.');
    }
  }
}

// class AnimatedBottomSheet extends StatefulWidget {
//   final Widget additionalSheetChild;
//
//   const AnimatedBottomSheet({Key? key, required this.additionalSheetChild})
//       : super(key: key);
//
//   static final _controller = _AnimatedBottomSheetController();
//
//   static void show() => _controller.show();
//   static void hide() => _controller.hide();
//   static void toggle() => _controller.toggle();
//
//   @override
//   State<AnimatedBottomSheet> createState() => _AnimatedBottomSheetState();
// }
//
// class _AnimatedBottomSheetState extends State<AnimatedBottomSheet> {
//   bool _isAdditionalSheetVisible = false;
//   double _childHeight = 0;
//
//   // `GlobalKey`を使って高さを取得
//   final GlobalKey _childKey = GlobalKey();
//
//   @override
//   void initState() {
//     super.initState();
//     AnimatedBottomSheet._controller._bindState(this);
//
//     // ウィジェットが描画された後に高さを取得
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final renderBox = _childKey.currentContext?.findRenderObject() as RenderBox?;
//       if (renderBox != null) {
//         setState(() {
//           _childHeight = renderBox.size.height;
//         });
//       }
//     });
//   }
//
//   void _show() {
//     if (mounted) {
//       setState(() {
//         _isAdditionalSheetVisible = true;
//       });
//     }
//   }
//
//   void _hide() {
//     if (mounted) {
//       setState(() {
//         _isAdditionalSheetVisible = false;
//       });
//     }
//   }
//
//   void _toggle() {
//     if (mounted) {
//       setState(() {
//         _isAdditionalSheetVisible = !_isAdditionalSheetVisible;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // もしシートが非表示なら、childの高さ分だけ負の値を設定
//     double bottomValue = _isAdditionalSheetVisible ? 0 : -_childHeight;
//
//     return AnimatedPositioned(
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//       bottom: bottomValue,
//       left: 0,
//       right: 0,
//       child: GestureDetector(
//         onVerticalDragUpdate: (details) {
//           // ユーザーがドラッグしている間、bottomValueを更新
//           setState(() {
//             double dragPosition = details.primaryDelta ?? 0;
//             double newBottomValue = bottomValue + dragPosition;
//             // 最大値はheightより大きくならないようにする
//             _isAdditionalSheetVisible = newBottomValue >= -_childHeight;
//             bottomValue = newBottomValue.clamp(-_childHeight, double.infinity);
//           });
//         },
//         onVerticalDragEnd: (details) {
//           // ドラッグが終了したときに、シートを閉じるか表示するか決める
//           if (bottomValue < -_childHeight / 2) {
//             _hide();
//           } else {
//             _show();
//           }
//         },
//         child: Container(
//           color: Theme.of(context).colorScheme.surface,
//           child: Column(
//             key: _childKey,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 20),
//                 child: SizedBox(
//                   child: widget.additionalSheetChild,
//                 ),
//               ),
//               const Divider(height: 0, thickness: 1),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // コントローラーでシートの制御
// class _AnimatedBottomSheetController {
//   _AnimatedBottomSheetState? _state;
//
//   void _bindState(_AnimatedBottomSheetState state) {
//     _state = state;
//   }
//
//   void show() => _state?._show();
//   void hide() => _state?._hide();
//   void toggle() => _state?._toggle();
// }
