import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final Color color;
  final bool disabled;
  final Function onPressed;

  const SocialButton({
    Key key,
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
        color: color.withOpacity(0.6),

        shape: Border(
          top: BorderSide(color: Colors.white),
          bottom: BorderSide(color: Colors.white),
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
                child: VerticalDivider(color: Colors.white, width: 2, thickness: 2,),
              ),
              Expanded(
                child: Center(
                  child: Text(text,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35
                    ),
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

