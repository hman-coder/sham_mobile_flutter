import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultValues {

  final Color maroon = const Color(0xff8C0000);

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

  final double extraLargeTextSize = 26;

  final double largeTextSize = 20;

  final double mediumTextSize = 18;
}