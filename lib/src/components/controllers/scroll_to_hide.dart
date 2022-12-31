import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollToHideController extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final Duration duration;

  const ScrollToHideController({
    Key? key,
    required this.child,
    required this.controller,
    this.duration = const Duration(milliseconds: 200),
  }) : super(key: key);

  @override
  _ScrollToHideControllerState createState() => _ScrollToHideControllerState();
}

class _ScrollToHideControllerState extends State<ScrollToHideController> {
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listen);
  }

  @override
  void dispose() {
    widget.controller.removeListener(listen);
    super.dispose();
  }

  void show() {
    if (!isVisible) {
      setState(() {
        isVisible = true;
      });
    }
  }

  void hide() {
    if (isVisible) {
      setState(() {
        isVisible = false;
      });
    }
  }

  void listen() {
    final pos = widget.controller.position;
    if (pos.pixels > 64) {
      hide();
    } else {
      show();
    }

    // final dir = widget.controller.position.userScrollDirection;

    // if (dir == ScrollDirection.reverse) {
    //   hide();
    // } else if (widget.controller.position.userScrollDirection ==
    //     ScrollDirection.forward) {
    //   show();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration,
      height: isVisible ? kBottomNavigationBarHeight : 0,
      child: widget.child,
    );
  }
}
