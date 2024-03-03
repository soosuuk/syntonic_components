import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SyntonicSeeMore extends StatelessWidget {
  final List<Widget> widgets;
  final int initialListItemCount;

  const SyntonicSeeMore({required this.widgets, this.initialListItemCount = 3});

  @override
  Widget build(BuildContext context) {
    bool needsSeeMoreButton = widgets.length > initialListItemCount;

    return ListenableProvider(
      create: (context) => SeeMoreState(),
      child: Consumer<SeeMoreState>(
        builder: (context, model, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: !needsSeeMoreButton || model.isExpanded
                      ? widgets
                      : widgets.sublist(0, initialListItemCount)),
              needsSeeMoreButton
                  ? TextButton(
                      child: Text(model.isExpanded ? 'Close' : 'See more'),
                      onPressed: () {
                        model.changeExpandCollapseState();
                      },
                    )
                  : const SizedBox(height: 0),
            ],
          );
        }, // a
      ),
    );
  }
}

class SeeMoreState extends ChangeNotifier {
  bool isExpanded = false;

  /// Change expand/collapse state.
  void changeExpandCollapseState() {
    isExpanded = !isExpanded;
    notifyListeners();
  }
}
