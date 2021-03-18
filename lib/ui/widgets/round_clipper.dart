import 'package:flutter/material.dart';

/// A widget that clips its child into a circle
class RoundClipper extends StatelessWidget {
  final double radius;

  final Widget child;

  const RoundClipper({Key key, this.radius, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        height: radius,
        width: radius,
        child: child,
      ),
    );
  }
}