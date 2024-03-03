import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';


class SyntonicSkeletonizer extends ConsumerWidget {
  final Widget child;
  final bool isEnabled;

  const SyntonicSkeletonizer(
      {Key? key, required this.child, this.isEnabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Skeletonizer(
      enabled: isEnabled,
      containersColor: Theme.of(context).colorScheme.secondaryContainer,
      child: child,
    );
  }
}
