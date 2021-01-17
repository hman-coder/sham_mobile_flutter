import 'dart:async';

import 'package:flutter/material.dart';

class DelayedAnimation extends StatefulWidget{
  final Widget child;

  final int delayInMilliseconds;

  const DelayedAnimation({Key key, this.delayInMilliseconds, @required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DelayedAnimationState();

}

class DelayedAnimationState extends State<DelayedAnimation> with
    TickerProviderStateMixin{
  AnimationController _controller;

  Animation<Offset> _offsetAnim;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this, duration: Duration(milliseconds: 800),
    );

    final curve = CurvedAnimation(curve: Curves.decelerate, parent: _controller);

    _offsetAnim = Tween<Offset>(
        begin: const Offset(0.00, 0.35), end: Offset.zero
    ).animate(curve);

    if (widget.delayInMilliseconds == null) {
      _controller.forward();
    } else {
      Timer(Duration(milliseconds: widget.delayInMilliseconds), () {
        _controller.forward();
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: _offsetAnim,
        child: widget.child,
      ),

    );
  }

}