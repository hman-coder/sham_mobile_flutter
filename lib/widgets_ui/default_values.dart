import 'package:flutter/material.dart';

class DefaultValues {
  static const  Color maroon = const Color(0xff8C0000);

  static const Color facebook_blue = const Color(0xFF29487D);

  static const Color whatsapp_green = const Color(0xFF25D366);

  static const Color gmail_red = const Color(0xFFD44637);

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

  static final double largeTextSize = 24;

  static final double mediumTextSize = 21;

  static final double smallTextSize = 18;

  static final double extraSmallTextSize = 16;
}