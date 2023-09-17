import 'package:flutter/cupertino.dart';

class SyntonicKeepAliveView extends StatefulWidget {
  final Widget child;

  const SyntonicKeepAliveView({required this.child});

  @override
  __KeepAliveWrapperState createState() => __KeepAliveWrapperState();
}

class __KeepAliveWrapperState extends State<SyntonicKeepAliveView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
