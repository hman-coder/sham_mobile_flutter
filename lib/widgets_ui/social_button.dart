import 'package:flutter/material.dart';
import 'package:sham_mobile/widgets_ui/default_values.dart';

class SocialButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final Color color;
  final bool disabled;
  final Function onPressed;
  final double opacity;
  final TextStyle textStyle;
  final Color marginColor;

  const SocialButton({
    Key key,
    this.marginColor = Colors.white,
    this.opacity = 1.00,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: DefaultValues.ktsLargeTextSize,
    ),
    @required this.icon,
    @required this.color,
    @required this.text,
    @required this.onPressed,
    this.disabled = false})
      : assert (icon != null) ,
        assert (text != null),
        assert (onPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: MaterialButton(
        disabledColor: Colors.black.withOpacity(0.1),
        disabledTextColor: Colors.grey,
        onPressed: disabled ? null : this.onPressed,
        color: color.withOpacity(opacity),

        shape: Border(
          top: BorderSide(color: marginColor),
          bottom: BorderSide(color: marginColor),
        ),

        child: IntrinsicHeight(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: icon,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: VerticalDivider(color: marginColor, width: 2, thickness: 2,),
              ),
              Expanded(
                child: Center(
                  child: Text(text,
                    style: textStyle,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

