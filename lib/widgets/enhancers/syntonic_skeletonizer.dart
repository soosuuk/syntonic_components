import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../syntonic_base_view.dart';

class SyntonicSkeletonizer extends ConsumerWidget {
  final Widget child;


  SyntonicSkeletonizer(
      {required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Skeletonizer(child: child, enabled: false);
  }
}