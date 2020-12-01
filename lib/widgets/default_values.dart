import 'package:flutter/material.dart';

class DefaultValues {
  static final Color maroon = const Color(0xff8C0000);

  static final String mainFontFamily = 'Harmattan';

  static final TextStyle sliverAppBarTextStyleWithShadow = TextStyle(
    shadows: [Shadow(
        color: Colors.black,
        offset: Offset(2.0, 2.0),
        blurRadius: 6.0)],
    fontSize: 18,
  );

  static final TextStyle commentTextStyle = TextStyle(
    fontSize: 18,
  );

  static final TextStyle commentHeaderTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: const Color(0xff8C0000),
  );

  static InputDecoration get defaultTextFieldInputDecoration =>
      InputDecoration(
          labelStyle: TextStyle(fontSize: DefaultValues.mediumTextSize),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15)
          )
      );

  static final double extraLargeTextSize = 30;

  static final double largeTextSize = 26;

  static final double mediumTextSize = 20;

  static final double smallTextSize = 18;

  static final double extraSmallTextSize = 16;
}