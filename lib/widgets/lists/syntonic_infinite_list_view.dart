import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SyntonicInfiniteListView<T> extends StatefulWidget {
  final List<T> data;
  final bool isLoading;
  final bool canLoadMore;
  final Function? onLoadMore;
  final Widget Function(BuildContext, T) itemBuilder;
  final int numberOfItemsInPage;

  const SyntonicInfiniteListView({
    super.key,
    required this.data,
    required this.isLoading,
    required this.canLoadMore,
    required this.onLoadMore,
    required this.itemBuilder,
    this.numberOfItemsInPage = 10,
  });

  @override
  _SyntonicInfiniteListViewState<T> createState() =>
      _SyntonicInfiniteListViewState<T>();
}

class _SyntonicInfiniteListViewState<T> extends State<SyntonicInfiniteListView<T>> {
  static const _additionalItems = ['CircularProgressIndicator'];
  static const double _visibilityThreshold = 0.5;
  bool _isLoadMoreIndicatorVisible = false;

  @override
  Widget build(BuildContext context) {
    // return Container(height: 100, color: Colors.red,);
    return ListView.builder(
      padding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height * 0.4),
      itemCount: widget.data.length + _additionalItems.length,
      itemBuilder: (context, index) {
        if (index < widget.data.length) {
          return widget.itemBuilder(context, widget.data[index]);
        } else {
          return VisibilityDetector(
            key: const Key('load_more_indicator'),
            onVisibilityChanged: (VisibilityInfo info) {
              setState(() {
                _isLoadMoreIndicatorVisible =
                    info.visibleFraction > _visibilityThreshold;
              });
              if (_isLoadMoreIndicatorVisible &&
                  !widget.isLoading &&
                  widget.canLoadMore) {
                widget.onLoadMore?.call();
              }
            },
            child: widget.canLoadMore &&
                    (widget.data.length >= widget.numberOfItemsInPage)
                ? const Center(child: CircularProgressIndicator())
                : const SizedBox(),
          );
        }
      },
    );
  }

  @override
  void didUpdateWidget(covariant SyntonicInfiniteListView<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isLoadMoreIndicatorVisible) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!widget.isLoading && widget.canLoadMore) {
          widget.onLoadMore?.call();
        }
      });
    }
  }
}
