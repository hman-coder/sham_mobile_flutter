import 'package:flutter/material.dart';

class LabeledDivider extends StatelessWidget {
  final Widget label;
  final Alignment alignment;
  final Color color;
  final double thickness;

  LabeledDivider({Key key, this.color = Colors.black, this.thickness = 0, @required this.label, this.alignment = Alignment.center}) :
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
          Expanded(child: _buildDivider()),
          label
        ],
      );

    if(alignment == Alignment.centerRight)
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          label,
          Expanded(child: _buildDivider())
      ],
    );

    else
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: _buildDivider()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: label,
          ),
          Expanded(child: _buildDivider())
        ],
      );
  }

  Divider _buildDivider() => Divider(
    thickness: thickness,
    color: color
  );
}
