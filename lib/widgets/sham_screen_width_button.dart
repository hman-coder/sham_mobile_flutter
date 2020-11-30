import 'package:flutter/material.dart';
import 'default_values.dart';
import 'package:get/get_utils/get_utils.dart';

/// A button that almost fills the screen width
class ShamScreenWidthButton extends StatelessWidget {
  final VoidCallback onPressed;

  final VoidCallback onLongPress;

  final String text;

  final double height;

  const ShamScreenWidthButton({
    Key key,
    this.onPressed,
    this.onLongPress,
    this.text,
    this.height = 40}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      splashColor: Colors.white.withOpacity(0.5),
      height: height,
      minWidth: MediaQuery.of(context).size.width - 50,
      child: Text(
        text,
        style: TextStyle(
            color: Colors.white,
            fontSize: DefaultValues.mediumTextSize
        ),
      ),
      onPressed: onPressed,
      onLongPress: onLongPress,
      disabledColor: Colors.grey,
      color: DefaultValues.maroon,
    );
  }
}
