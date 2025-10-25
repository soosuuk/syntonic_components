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
      this.shouldAdjustExtentToChild = false,
      this.canDrag = true
      })
      : super();
  final VM vm;
  final double? initialSize;
  final String? actionName;
  final bool shouldAdjustExtentToChild;
  final bool canDrag;
  // final GlobalKey childKey = GlobalKey();
  // final GlobalKey bottomBarKey = GlobalKey();
  // final ValueNotifier<double> extentNotifier = ValueNotifier<double>(0.5);

  VM viewModel(WidgetRef ref) => ref.read(provider.notifier);
  StateNotifierProvider<VM, VS> get provider =>
      StateNotifierProvider<VM, VS>((ref) => vm);

  Widget? bottomBar(
      {required BuildContext context,
      required WidgetRef ref,
      required double extent}) => null;
  Widget? additionalSheetChild(
      {required BuildContext context,
      required WidgetRef ref,
      required double extent}) => null;
  List<String>? covers(
      {required BuildContext context,
      required WidgetRef ref,
      required double extent}) => null;
  Widget? appBar(
      {required BuildContext context,
      required WidgetRef ref,
      required double extent}) => null;
  Widget child(
      {required BuildContext context,
      required WidgetRef ref,
      required double extent});
  Future<bool>? Function()? onPop(
      {required BuildContext context, required WidgetRef ref}) => null;

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
          return Padding(padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(NavigationService().navigatorKey.currentState!.context).bottom), child: Consumer(builder: (context, ref, _) {
            return LayoutBuilder(builder: (_, constraints) {
              return Scaffold(
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomInset: false,
                bottomNavigationBar: bottomBar(
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
                  canDrag: canDrag,
                  child: child(
                      context: context,
                      ref: ref,
                      extent: viewModel(ref).state.currentExtent),
                ),
              );
            });
          }),);
        });
  }
}

abstract class SyntonicModalBottomSheetViewModel<
    VS extends SyntonicModalBottomSheetViewState> extends StateNotifier<VS> {
  SyntonicModalBottomSheetViewModel({required VS viewState, this.shouldAdjustExtentToChild = false, this.canDrag = true})
      : super(viewState) {
    pageController.addListener(() {
      if (pageController.positions.isNotEmpty) {
        state = state.copyWith(currentPageIndex: pageController.page!) as VS;
      }
    });
  }

  final bool canDrag;
  final bool shouldAdjustExtentToChild;
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
  final Future<bool>? Function()? onPop;
  final List<String>? covers;
  final Widget? appBar;
  final Widget? bottomBar;
  final Widget? additionalSheetChild;
  final String? actionName;
  final VM viewModel;
  final StateNotifierProvider<VM, VS> provider;
  final bool shouldAdjustExtentToChild;
  final bool canDrag;

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
    required this.canDrag,
  });

  @override
  _ContentsWidgetState createState() => _ContentsWidgetState();
}

class _ContentsWidgetState extends State<ContentsWidget> {
  late PageController pageController;
  late ValueNotifier<double> extentNotifier;
  late GlobalKey childKey;
  final GlobalKey handleKey = GlobalKey();
  final GlobalKey bottomBarKey = GlobalKey();
  double _contentHeight = 0.5;
  double _contentHeightJustice = 0.0;
  double _handleHeight = 0.0;
  double _bottomBarHeight = 0.0;
  double height = 0.0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
        initialPage: widget.viewModel.state.currentPageIndex.toInt());
    extentNotifier = ValueNotifier<double>(_contentHeight);
    childKey = GlobalKey();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      double handleHeight = 0.0;
      if (widget.canDrag) {
        handleHeight = 34;
        // handleHeight =
        //    (handleKey.currentContext!.findRenderObject() as RenderBox)
        //        .size
        //        .height;
     }
      print('handleHeighttt: $handleHeight');

      final double childHeight =
          (childKey.currentContext!.findRenderObject() as RenderBox)
              .size
              .height;
      print('childHeightttt: $childHeight');
      // final double bottomBarHeight =
      //     (bottomBarKey.currentContext!.findRenderObject() as RenderBox)
      //         .size
      //         .height;
      // print('bottomBarHeight: $bottomBarHeight');
      final _handleExtent = handleHeight /
          (widget.constraints.maxHeight -
              kToolbarHeight -
              MediaQuery.viewPaddingOf(
                      NavigationService().navigatorKey.currentState!.context)
                  .top);
      final _extent = childHeight /
          (widget.constraints.maxHeight -
              kToolbarHeight -
              MediaQuery.viewPaddingOf(
                      NavigationService().navigatorKey.currentState!.context)
                  .top);
      // final _bottomBarExtent = bottomBarHeight /
      //     (widget.constraints.maxHeight -
      //         kToolbarHeight -
      //         MediaQuery.viewPaddingOf(
      //                 NavigationService().navigatorKey.currentState!.context)
      //             .top);
      print('キーボード処理中');
      print('childHeight: $childHeight');
      print('extent: $_extent');

      setState(() {
        print('ステートセット1');
        height = childHeight;
        extentNotifier.value = _extent + _handleExtent;
        _contentHeight = _extent;
        _handleHeight = handleHeight;
        _contentHeightJustice = childHeight;
        // _bottomBarHeight = bottomBarHeight;
      });
    });
    // }
  }

  @override
  Widget build(BuildContext context) {
    // double adjustedMinChildSize = (kToolbarHeight +
    //         MediaQuery.viewPaddingOf(
    //                 NavigationService().navigatorKey.currentState!.context)
    //             .top) /
    //     widget.constraints.maxHeight;
    // double adjustedMinChildSize = _bottomBarHeight;
    // print('adjustedMinChildSize: $adjustedMinChildSize');
    return LayoutBuilder(builder: (con, constraints) {
      print('contentHeight: $_contentHeight');
      print('bottom:: ${MediaQuery.viewInsetsOf(NavigationService().navigatorKey.currentState!.context).bottom}');
      final _bottomExtent = MediaQuery.viewInsetsOf(NavigationService()
          .navigatorKey
          .currentState!
          .context)
          .bottom /
          (widget.constraints.maxHeight -
              kToolbarHeight -
              MediaQuery.viewInsetsOf(
                  NavigationService().navigatorKey.currentState!.context)
                  .top);
      // print('m: ${_contentHeight + adjustedMinChildSize}');
      print('contentHeightJustice: $_contentHeightJustice');
      print('handleHeight: $_handleHeight');
      print('bottomBarHeight: $_bottomBarHeight');
      print("root height: ${MediaQuery.sizeOf(NavigationService().navigatorKey.currentState!.context).height}");
      print("local height: ${MediaQuery.sizeOf(context).height}");
      print('高さ : ${constraints.maxHeight}');
      // double _m = (_contentHeightJustice + (widget.canDrag ? _handleHeight : 0)) / (MediaQuery.sizeOf(context).height - MediaQuery.viewInsetsOf(NavigationService()
      //     .navigatorKey
      //     .currentState!
      //     .context).bottom - kToolbarHeight - MediaQuery.viewPaddingOf(
      //     NavigationService().navigatorKey.currentState!.context)
      //     .top);

      double _m = (_contentHeightJustice + (widget.canDrag ? _handleHeight : 0)) / (constraints.maxHeight - kToolbarHeight - MediaQuery.viewPaddingOf(
          NavigationService().navigatorKey.currentState!.context)
          .top);


      double _minExtent = widget.shouldAdjustExtentToChild ? _m : 0.5;
      // double _minExtent = 0.1745049504950495;
      print('final minExtent: $_minExtent');
      double actualHeight = _minExtent *
          (widget.constraints.maxHeight - MediaQuery.viewInsetsOf(NavigationService()
              .navigatorKey
              .currentState!
              .context).bottom -
              (MediaQuery.viewPaddingOf(NavigationService()
                  .navigatorKey
                  .currentState!
                  .context)
                  .top +
                  kToolbarHeight));

      actualHeight = _contentHeightJustice + (widget.canDrag ? _handleHeight : 0);
      print('actualHeight: $actualHeight');
      print('height: $height');

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
                opacity: opacity.clamp(widget.covers?.isNotEmpty == true ? 1 : 0.0, 1.0),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.viewPaddingOf(NavigationService()
                          .navigatorKey
                          .currentState!
                          .context)
                          .top,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    widget.appBar ?? SizedBox()
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
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  GestureDetector(
                    onTap: () async {
                      AnimatedBottomSheet.hide();
                      bool canPop = await widget.onPop?.call() ?? true;
                      if (canPop) {
                        Navigator.of(context).pop();
                      }
                    },),
                  widget.covers?.isNotEmpty == true
                      ? Positioned.fill(
                    bottom: height,
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
                        children: widget.covers!
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
                  if (widget.additionalSheetChild != null) Padding(
                    padding: EdgeInsets.only(bottom: actualHeight),
                    child: AnimatedBottomSheet(
                        additionalSheetChild: widget.additionalSheetChild!),
                  ),
                  DraggableScrollableSheet(
                    initialChildSize: _minExtent,
                    maxChildSize: widget.viewModel.maxExtent,
                    minChildSize: _minExtent,
                    expand: false,
                    snap: true,
                    snapSizes: [
                      _minExtent,
                      widget.viewModel.maxExtent,
                    ],
                    controller: widget.viewModel.controller,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return GestureDetector(
                          onTap:
                          widget.shouldAdjustExtentToChild ? null :
                              () {
                            FocusManager.instance.primaryFocus!.unfocus();
                          },
                          child: ColoredBox(
                            color: Theme.of(context).colorScheme.surface,
                            // color: Colors.purple,
                            child: Navigator(
                              onGenerateRoute: (context) =>
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SingleChildScrollView(
                                            controller: scrollController,
                                            physics:
                                            !widget.canDrag ? NeverScrollableScrollPhysics() : ClampingScrollPhysics(),
                                            child: Stack(children: [Container(
                                              // key: childKey,
                                              // color: Colors.blue,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  if (widget.canDrag) ValueListenableBuilder<
                                                      double>(
                                                    valueListenable:
                                                    extentNotifier,
                                                    builder: (context, extent,
                                                        child) {
                                                      extent = _minExtent;
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
                                                        key: handleKey,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .only(
                                                            top:
                                                            height.clamp(
                                                                16.0,
                                                                16.0),
                                                            bottom:
                                                              height.clamp(8, 8),
                                                          ),
                                                          child: Container(
                                                            width:
                                                            width.clamp(56.0,
                                                                56.0),
                                                            decoration: BoxDecoration(
                                                              color: Theme.of(context).colorScheme.onSurface,
                                                              borderRadius: BorderRadius.circular(0), // Adjust the radius as needed
                                                            ),
                                                            height:
                                                            2, // Ensure height is within the desired range
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  KeyedSubtree(key: childKey, child: widget.child),
                                                ],
                                              ),
                                            ),
                                              // Opacity(
                                              //   opacity: 0,
                                              //   child: KeyedSubtree(key: bottomBarKey, child: widget.bottomBar ?? SizedBox()),
                                              // )
                                            ],)),
                                  ),
                            ),
                          ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
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
        print('ステートセット2');
        _isAdditionalSheetVisible = true;
        _animationController.forward();
      });
    }
  }

  void _hide() {
    print('ステートセット3');
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
    print('ステートセット4');
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
