import 'package:flutter/material.dart';
import 'package:sham_mobile/constants/default_values.dart';

class ElevatingTitle extends StatelessWidget {
  final Color color;

  final double height;

  final Widget child;

  final BorderRadius borderRadius;

  const ElevatingTitle({Key key,
    this.color = kcMaroon,
    this.height = double.infinity,
    @required this.child,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: child,
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: borderRadius,
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 1.5),
            ),
            BoxShadow(
              color: Colors.black54,
              offset: Offset(0, 2),
            ),
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2.5),
            ),
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 3),
            ),
          ],
        ));
  }
}
