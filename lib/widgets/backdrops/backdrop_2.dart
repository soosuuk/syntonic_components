import 'package:flutter/material.dart';

const double _kFlingVelocity = 2.0;

class _FrontLayer extends AnimatedWidget {
  const _FrontLayer({
    Key? key,
    this.onTap,
    required this.child,
    required this.subHeader,
    required Animation<double> listenable,
  })  : _listenable = listenable,
        super(key: key, listenable: listenable);

  final VoidCallback? onTap;
  final Widget child;
  final Widget subHeader;
  final Animation<double> _listenable;


  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = _listenable;
    final AnimationStatus status = animation.status;
    bool isVisible = status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
    double radius = isVisible ? 0 : 16;

    return Material(
      color: Theme.of(context).colorScheme.surface,
      clipBehavior: Clip.antiAlias,
      elevation: isVisible ? 0 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(radius), topRight: Radius.circular(radius)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            // onTap: onTap,
            child: subHeader,
            // child: Row(children: [SizedBox(width: 16), Transform.rotate(
            //     angle: animation.value * 180 * pi / 180,
            //     child: Icon(
            //       Icons.expand_less,
            //     )), Flexible(child: subHeader)]),
          ),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}

class _BackdropTitle extends AnimatedWidget {
  final void Function() onPress;

  const _BackdropTitle({
    Key? key,
    required Animation<double> listenable,
    required this.onPress,
  })  : _listenable = listenable,
        super(key: key, listenable: listenable);

  final Animation<double> _listenable;

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = _listenable;

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline6!,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      child: Row(children: <Widget>[
        // branded icon
        SizedBox(
          width: 72.0,
          child: IconButton(
            padding: const EdgeInsets.only(right: 8.0),
            onPressed: onPress,
            icon: Stack(children: <Widget>[
              Opacity(
                opacity: animation.value,
                child: const ImageIcon(AssetImage('assets/slanted_menu.png')),
              ),
              FractionalTranslation(
                translation: Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(1.0, 0.0),
                ).evaluate(animation),
                child: const ImageIcon(AssetImage('assets/diamond.png')),
              )
            ]),
          ),
        ),
        // Here, we do a custom cross fade between backTitle and frontTitle.
        // This makes a smooth animation between the two texts.
        Stack(
          children: <Widget>[
            Opacity(
              opacity: CurvedAnimation(
                parent: ReverseAnimation(animation),
                curve: const Interval(0.5, 1.0),
              ).value,
              child: FractionalTranslation(
                translation: Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(0.5, 0.0),
                ).evaluate(animation),
                child: Semantics(
                    label: 'hide categories menu',
                    child: ExcludeSemantics(child: Text("aaa"))),
              ),
            ),
            Opacity(
              opacity: CurvedAnimation(
                parent: animation,
                curve: const Interval(0.5, 1.0),
              ).value,
              child: FractionalTranslation(
                translation: Tween<Offset>(
                  begin: const Offset(-0.25, 0.0),
                  end: Offset.zero,
                ).evaluate(animation),
                child: Semantics(
                    label: 'show categories menu',
                    child: ExcludeSemantics(child: Text("bbb"))),
              ),
            ),
          ],
        )
      ]),
    );
  }
}

/// Builds a Backdrop.
///
/// A Backdrop widget has two layers, front and back. The front layer is shown
/// by default, and slides down to show the back layer, from which a user
/// can make a selection. The user can also configure the titles for when the
/// front or back layer is showing.
abstract class Backdrop extends StatefulWidget {
  final Widget frontLayer;
  final Widget backLayer;
  // final Widget subHeader;
  final Function(bool isVisible) onSubHeaderStateChanged;

  const Backdrop({
    required this.frontLayer,
    required this.backLayer,
    required this.onSubHeaderStateChanged,
    // required this.subHeader,
    Key? key,
  }) : super(key: key);

  @override
  BackdropStatee createState();
}

abstract class BackdropStatee extends State<Backdrop>
    with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(Backdrop old) {
    super.didUpdateWidget(old);

    // if (widget.currentCategory != old.currentCategory) {
    //   _toggleBackdropLayerVisibility();
    // } else if (!_frontLayerVisible) {
    //   _controller.fling(velocity: _kFlingVelocity);
    // }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget subHeader({required Function() onTap});

  bool get frontLayerVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
    _controller.fling(
        velocity: frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity);
    widget.onSubHeaderStateChanged(frontLayerVisible);
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double layerTitleHeight = 72.0;
    final Size layerSize = constraints.biggest;
    final double layerTop = layerSize.height - layerTitleHeight;

    Animation<RelativeRect> layerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(
          0.0, layerTop, 0.0, layerTop - layerSize.height),
      end: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_controller.view);

    return Stack(
      key: _backdropKey,
      children: <Widget>[
        ExcludeSemantics(
          child: widget.backLayer,
          excluding: frontLayerVisible,
        ),
        PositionedTransition(
          rect: layerAnimation,
          child: _FrontLayer(
            onTap: _toggleBackdropLayerVisibility,
            child: widget.frontLayer,
            subHeader: subHeader(onTap: _toggleBackdropLayerVisibility),
            listenable: _controller.view,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // var appBar = AppBar(
    //   brightness: Brightness.light,
    //   elevation: 0.0,
    //   titleSpacing: 0.0,
    //   title: _BackdropTitle(
    //     listenable: _controller.view,
    //     onPress: _toggleBackdropLayerVisibility,
    //   ),
    //   actions: <Widget>[
    //     IconButton(
    //       icon: const Icon(
    //         Icons.search,
    //         semanticLabel: 'login',
    //       ),
    //       onPressed: () {
    //         // Navigator.push(
    //         //   context,
    //         //   MaterialPageRoute(
    //         //       builder: (BuildContext context) => const LoginPage()),
    //         // );
    //       },
    //     ),
    //     IconButton(
    //       icon: const Icon(
    //         Icons.tune,
    //         semanticLabel: 'login',
    //       ),
    //       onPressed: () {
    //         // Navigator.push(
    //         //   context,
    //         //   MaterialPageRoute(
    //         //       builder: (BuildContext context) => const LoginPage()),
    //         // );
    //       },
    //     ),
    //   ],
    // );
    return Scaffold(
      // appBar: appBar,
      body: LayoutBuilder(
        builder: _buildStack,
      ),
    );
  }
}