import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../syntonic_base_view.dart';

class SyntonicSkeletonizer extends ConsumerWidget {
  final Widget child;
  final bool isEnabled;


  SyntonicSkeletonizer(
      {required this.child, this.isEnabled = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Skeletonizer(child: child, enabled: isEnabled, containersColor: Theme.of(context).colorScheme.secondaryContainer,);
  }
}