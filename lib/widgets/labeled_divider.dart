import 'package:flutter/material.dart';

class LabeledDivider extends StatelessWidget {
  final Widget label;
  final Alignment alignment;

  LabeledDivider({Key key, @required this.label, this.alignment = Alignment.center}) :
        assert (alignment == Alignment.centerLeft
            || alignment == Alignment.centerRight
            || alignment == Alignment.center),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if(alignment == Alignment.centerLeft)
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Divider()),
          label
        ],
      );

    if(alignment == Alignment.centerRight)
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          label,
          Expanded(child: Divider())
      ],
    );

    else
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Divider()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: label,
          ),
          Expanded(child: Divider())
        ],
      );
  }
}
