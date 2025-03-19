import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syntonic_components/widgets/dividers/syntonic_divider.dart';
import 'package:syntonic_components/widgets/lists/syntonic_list_item.dart';
import 'package:syntonic_components/widgets/texts/body_1_text.dart';
import 'package:syntonic_components/widgets/texts/headline_6_text.dart';

import '../buttons/syntonic_button.dart';

abstract class SyntonicModalBottomSheet<
VM extends SyntonicModalBottomSheetViewModel<VS>,
VS extends SyntonicModalBottomSheetViewState> {
  SyntonicModalBottomSheet({Key? key, this.actionName, required this.vm, this.initialSize})
      : super();
  final VM vm;
  final double? initialSize;
  final String? actionName;
  final GlobalKey childKey = GlobalKey();
  final GlobalKey bottomBarKey = GlobalKey();
  final ValueNotifier<double> extentNotifier = ValueNotifier<double>(0.5);

  VM viewModel(WidgetRef ref) => ref.read(provider.notifier);
  StateNotifierProvider<VM, VS> get provider =>
      StateNotifierProvider<VM, VS>((ref) => vm);

  Widget bottomBar(
      {required BuildContext context, required WidgetRef ref, required double extent});
  Widget additionalSheetChild(
      {required BuildContext context, required WidgetRef ref, required double extent});
  List<String> covers(
      {required BuildContext context, required WidgetRef ref, required double extent});
  Widget appBar(
      {required BuildContext context, required WidgetRef ref, required double extent});
  Widget child(
      {required BuildContext context, required WidgetRef ref, required double extent});
  Function? onPop({required BuildContext context, required WidgetRef ref});

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
          return Consumer(builder: (context, ref, child) {
            return PopScope(
              onPopInvokedWithResult: (didPop, __) async {
                print('閉じる');
                // onPop(context: context, ref: ref);
                // Navigator.of(context).pop();
              }, child:  _contents<S>(context: context, ref: ref),
            );
          });
        });
  }

  Widget _contents<S>({
    required BuildContext context,
    required WidgetRef ref,
  }) {
    vm.pageController = PageController(initialPage: vm.state.currentPageIndex.toInt());

    bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    if (isKeyboardVisible) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        print('キーボード処理中');
        final RenderBox renderBox = childKey.currentContext!.findRenderObject() as RenderBox;
        final double childHeight = renderBox.size.height;
        final RenderBox renderBoxBottom = bottomBarKey.currentContext!.findRenderObject() as RenderBox;
        final double bottomHeight = renderBoxBottom.size.height;
        final bottomInset = MediaQuery.of(context).viewInsets.bottom;
        final _extent = (bottomHeight + childHeight + bottomInset + 34) / (MediaQuery.of(context).size.height - kToolbarHeight * 2);
        // viewModel(ref).updateMinExtent(_extent);
      });
    }

    double _minExtent = viewModel(ref).state.minExtent < 0.5 ? 0.5 : (viewModel(ref).state.minExtent > 1 ? 0.5 : viewModel(ref).state.minExtent);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Column(
        children: [
          ValueListenableBuilder<double>(
            valueListenable: extentNotifier,
            builder: (context, extent, child) {
              final double opacity = (extent - _minExtent) /
                  (vm.maxExtent - _minExtent);
              return Opacity(
                opacity: opacity.clamp(covers(context: context, ref: ref, extent: viewModel(ref).state.currentExtent).length > 0 ? 1 : 0.0, 1.0),
                child: Column(children: [Container(height: kToolbarHeight, color: Theme.of(context).colorScheme.surface,), appBar(context: context, ref: ref, extent: extent)],),
              );
            },
          ),
          PopScope(
            onPopInvokedWithResult: (didPop, __) async {
              // print('閉じる');
              // onPop(context: context, ref: ref);
              // Navigator.of(context).pop();
            },
            child: Expanded(
              child: NotificationListener<DraggableScrollableNotification>(
                onNotification: (notification) {
                  viewModel(ref).updateAdditionalSheetVisibility(false);
                  extentNotifier.value = notification.extent;
                  if (notification.maxExtent == notification.extent || viewModel(ref).state.minExtent == notification.extent) {
                    viewModel(ref).updateExtent(notification.extent);
                  }
                  return true;
                },
                child: GestureDetector(
                  onTap: () {
                    onPop(context: context, ref: ref);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Stack(alignment: AlignmentDirectional.bottomStart, children: [
                      covers(context: context, ref: ref, extent: viewModel(ref).state.currentExtent).length > 0 ? Positioned.fill(
                        bottom: (MediaQuery.of(context).size.height - kToolbarHeight * 2) * extentNotifier.value,
                        left: 0,
                        right: 0,
                        child: TweenAnimationBuilder(
                          tween: Tween<double>(begin: 1.2, end: 1.0),
                          duration: Duration(milliseconds: 1300),
                          curve: Curves.fastEaseInToSlowEaseOut,
                          builder: (context, double scale, child) {
                            return Transform.scale(
                              scale: scale,
                              child: child,
                            );
                          },
                          child: PageView(
                            children: covers(context: context, ref: ref, extent: viewModel(ref).state.currentExtent)
                                .map((coverUrl) => Image.network(
                              coverUrl,
                              fit: BoxFit.cover, // Covers the entire screen
                            ))
                                .toList(),
                          ),
                        ),
                      ) : SizedBox(),
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        bottom: ref.watch(provider.select((viewState) => viewState.isAdditionalSheetVisible))
                            ? (MediaQuery.of(context).size.height - kToolbarHeight * 2) * viewModel(ref).state.minExtent
                            : 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: Theme.of(context).colorScheme.surface,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: additionalSheetChild(context: context, ref: ref, extent: viewModel(ref).state.currentExtent),
                              ),
                              Divider(height: 0, thickness: 1),
                            ],
                          ),
                        ),
                      ),
                      DraggableScrollableSheet(
                      initialChildSize: _minExtent,
                      maxChildSize: vm.maxExtent,
                      minChildSize: _minExtent,
                      expand: false,
                      snap: true,
                      snapSizes: [
                        _minExtent,
                        1,
                      ],
                      controller: viewModel(ref).controller,
                      builder: (BuildContext context, ScrollController scrollController) {
                        return GestureDetector(
                          onTap: () {
                            // onPop(context: context, ref: ref);
                            // Navigator.of(context).pop();
                          },
                          child: Container(
                            // height: MediaQuery.of(context).size.height + MediaQuery.of(context).viewInsets.bottom,
                            color: Theme.of(context).colorScheme.surface,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ValueListenableBuilder<double>(
                                  valueListenable: extentNotifier,
                                  builder: (context, extent, child) {
                                    final double height = (1 - (extent - _minExtent) / (vm.maxExtent - _minExtent)) * 16; // Adjust the multiplier as needed
                                    final double width = (1 - (extent - _minExtent) / (vm.maxExtent - _minExtent)) * 56; // Adjust the multiplier as needed
                                    return Padding(
                                      padding: EdgeInsets.symmetric(vertical: height.clamp(0.0, 16.0),),
                                      child: Container(
                                        width: width.clamp(0.0, 56.0),
                                        height: 2, // Ensure height is within the desired range
                                        color: Theme.of(context).colorScheme.onSurface,
                                      ),
                                    );
                                  },
                                ),
                                Expanded(
                                  child: Navigator(
                                    onGenerateRoute: (context) => MaterialPageRoute(
                                      builder: (context) => Container(
                                        // color: Colors.purple,
                                        child: Stack(
                                          children: [SingleChildScrollView(
                                            controller: scrollController,
                                            physics: const ClampingScrollPhysics(),
                                            child: Container(
                                              // color: Colors.red,
                                              key: childKey,
                                              child: child(context: context, ref: ref, extent: ref.watch(provider.select((viewState) => viewState.currentExtent))),
                                            ),
                                          ),
                                            Positioned(
                                              bottom: MediaQuery.of(context).viewInsets.bottom,
                                              left: 0,
                                              right: 0,
                                              child: SizedBox(key: bottomBarKey, child: bottomBar(context: context, ref: ref, extent: viewModel(ref).state.currentExtent),),
                                            ),
                                          ],),),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),],)
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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

  void updateExtent(double extent) {
    state = state.copyWith(currentExtent: extent) as VS;
  }

  void updateMinExtent(double extent) {
    state = state.copyWith(minExtent: extent) as VS;
  }

  void updateAdditionalSheetVisibility(bool isVisible) {
    state = state.copyWith(isAdditionalSheetVisible: isVisible) as VS;
  }

  @override
  set state(VS value) {
    super.state = value;
  }

  @override
  VS get state => super.state;
}

class SyntonicModalBottomSheetViewState {
  SyntonicModalBottomSheetViewState({this.currentPageIndex = 0, required this.currentExtent, this.minExtent = 0.5, this.isAdditionalSheetVisible = false});
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
        currentPageIndex: currentPageIndex ?? this.currentPageIndex, currentExtent: currentExtent ?? this.currentExtent, minExtent: minExtent ?? this.minExtent, isAdditionalSheetVisible: isAdditionalSheetVisible ?? this.isAdditionalSheetVisible);
  }
}
