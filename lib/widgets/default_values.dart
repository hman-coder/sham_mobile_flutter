import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultValues {

  final Color maroon = const Color(0xff8C0000);

  final String mainFontFamily = 'Harmattan';

  final TextStyle sliverAppBarTextStyleWithShadow = TextStyle(
    shadows: [Shadow(
        color: Colors.black,
        offset: Offset(2.0, 2.0),
        blurRadius: 6.0)],
    fontSize: 18,
  );

  final TextStyle commentTextStyle = TextStyle(
    fontSize: 18,
  );

  final TextStyle commentHeaderTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: const Color(0xff8C0000),
  );

  final double extraLargeTextSize = 30;

  final double largeTextSize = 26;

  final double mediumTextSize = 20;

  final double smallTextSize = 18;

  final double extraSmallTextSize = 16;
}