import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syntonic_components/services/localization_service.dart';

class SyntonicSeeMore extends StatelessWidget {
  final List<Widget> widgets;
  final int initialListItemCount;

  SyntonicSeeMore({required this.widgets, this.initialListItemCount = 3});

  @override
  Widget build(BuildContext context) {
    bool needsSeeMoreButton = this.widgets.length > this.initialListItemCount;

    return ListenableProvider(
      create: (context) => SeeMoreState(),
      child: Consumer<SeeMoreState>(
        builder: (context, model, child) {
          return Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: !needsSeeMoreButton || model.isExpanded ? widgets : widgets.sublist(0, initialListItemCount)),
              needsSeeMoreButton
                  ? Container(
                      child: TextButton(
                        child: Text(model.isExpanded ? 'Close' : 'See more'),
                        onPressed: () {
                          model.changeExpandCollapseState();
                        },
                      ))
                  : SizedBox(height: 0),
            ],
          ));
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
