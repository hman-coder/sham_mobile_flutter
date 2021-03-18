import 'package:flutter/material.dart';
import 'package:sham_mobile/widgets_ui/default_values.dart';
import 'package:get/get_utils/get_utils.dart';

/// A button that almost fills the screen width
class ShamScreenWidthButton extends StatelessWidget {
  final VoidCallback onPressed;

  final VoidCallback onLongPress;

  final String text;

  final double height;

  final ShapeBorder shape;

  final Color color;

  final Color textColor;

  final Color splashColor;

  final Color disabledColor;

  const ShamScreenWidthButton({
    Key key,
    this.onPressed,
    this.onLongPress,
    this.text,
    this.shape,
    this.color,
    this.textColor,
    this.splashColor,
    this.disabledColor,
    this.height = 40}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      splashColor: splashColor ?? Colors.white.withOpacity(0.5),
      height: height,
      shape: shape,
      minWidth: MediaQuery.of(context).size.width - 50,
      child: Text(
        text,
        style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: ktsMediumTextSize
        ),
      ),
      onPressed: onPressed,
      onLongPress: onLongPress,
      disabledColor: disabledColor ?? Colors.grey,
      color: color ?? kcMaroon,
    );
  }
}
