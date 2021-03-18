import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// This widget is used to make a certain text more apparent
/// such as using it in a [FlexibleSpaceBar] with a
/// background image as its child.
///
/// The [child] is placed behind the gradient.
class LinearGradientBackground extends StatelessWidget {
  final Widget child;

  final Color color;

  const LinearGradientBackground({Key key,@required this.child, @required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        child ?? Container(),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    color,
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter
              )
          ),
        ),
      ],
    );
  }
}
