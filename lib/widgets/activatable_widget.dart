import 'package:flutter/material.dart';

/// A simple widget that activates or deactivates its
/// children.
class ActivatableWidget extends StatelessWidget {
  final bool isActive;

  final double opacity;

  final Widget child;

  const ActivatableWidget({
    Key key,
    @required this.isActive,
    this.opacity = 0.5,
    @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(isActive) return child;

    return IgnorePointer(
      child: Opacity(
        opacity: opacity,
        child: child,
      ),
    );
  }
}
