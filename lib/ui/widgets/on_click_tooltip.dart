import 'package:flutter/material.dart';

/// A tooltip that shows the message on tap instead of on long press
class OnClickToolTip extends StatelessWidget {
  final String message;

  final double height;

  final EdgeInsets padding;

  final EdgeInsets margin;

  final double verticalOffset;

  final bool preferBelow;

  final bool excludeFromSemantics;

  final Decoration decoration;

  final TextStyle textStyle;

  final Duration waitDuration;

  final Duration showDuration;

  final Widget child;

  OnClickToolTip(
      {Key key,
      @required this.message,
      this.height,
      this.padding,
      this.margin,
      this.verticalOffset,
      this.preferBelow,
      this.excludeFromSemantics,
      this.decoration,
      this.textStyle,
      this.waitDuration,
      this.showDuration,
      this.child})
      : super(key: key);

  final GlobalKey _tooltipKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        dynamic ttState = _tooltipKey.currentState;
        ttState.ensureTooltipVisible();
      },
      child: Tooltip(
        key: _tooltipKey,
        message: message,
        height: height,
        padding: padding,
        margin: margin,
        verticalOffset: verticalOffset,
        preferBelow: preferBelow,
        excludeFromSemantics: excludeFromSemantics,
        decoration: decoration,
        textStyle: textStyle,
        waitDuration: waitDuration,
        showDuration: showDuration,
        child: child,
      ),
    );
  }
}
