import 'package:flutter/material.dart';

class DefaultValues {
  static const  Color kcMaroon = const Color(0xff8C0000);

  static const Color kcFacebookBlue = const Color(0xFF29487D);

  static const Color kcWhatsappGreen = const Color(0xFF25D366);

  static const Color kcGmailRed = const Color(0xFFD44637);

  static const String ksMainFontFamily = 'Harmattan';

  static const TextStyle ktsSliverAppBarTextStyleWithShadow = TextStyle(
    shadows: [Shadow(
        color: Colors.black,
        offset: Offset(2.0, 2.0),
        blurRadius: 6.0)],
    fontSize: 18,
  );

  static const TextStyle ktsCommentTextStyle = TextStyle(
    fontSize: 18,
  );

  static const TextStyle ktsCommentHeaderTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: const Color(0xff8C0000),
  );

  static InputDecoration get ktsDefaultTextFieldInputDecoration =>
      InputDecoration(
          labelStyle: TextStyle(fontSize: DefaultValues.ktsMediumTextSize),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15)
          )
      );

  static const double ktsExtraLargeTextSize = 30;

  static const double ktsLargeTextSize = 24;

  static const double ktsMediumTextSize = 21;

  static const double ktsSmallTextSize = 18;

  static const double ktsExtraSmallTextSize = 16;

  static const BorderRadius kbrDefaultFieldBorderRadius =
  const BorderRadius.all(Radius.circular(5));

  static const Border kbDefaultFieldBorder = const Border(
    bottom: _defaultBorderSide,
    top: _defaultBorderSide,
    left: _defaultBorderSide,
    right: _defaultBorderSide,
  );

  static const BorderSide _defaultBorderSide = BorderSide(color: Colors.grey, width: 1);
}