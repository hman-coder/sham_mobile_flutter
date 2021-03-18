import 'package:flutter/material.dart';

const Color kcMaroon = const Color(0xff8C0000);

const Color kcFacebookBlue = const Color(0xFF29487D);

const Color kcWhatsappGreen = const Color(0xFF25D366);

const Color kcGmailRed = const Color(0xFFD44637);

const String ksMainFontFamily = 'Harmattan';

const TextStyle ktsSliverAppBarTextStyleWithShadow = TextStyle(
  shadows: [
    Shadow(color: Colors.black, offset: Offset(2.0, 2.0), blurRadius: 6.0)
  ],
  fontSize: 18,
);

const TextStyle ktsCommentTextStyle = TextStyle(
  fontSize: 18,
);

const TextStyle ktsCommentHeaderTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: const Color(0xff8C0000),
);

InputDecoration get ktsDefaultTextFieldInputDecoration => InputDecoration(
    labelStyle: TextStyle(fontSize: ktsMediumTextSize),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)));

const double ktsExtraLargeTextSize = 30;

const double ktsLargeTextSize = 24;

const double ktsMediumTextSize = 21;

const double ktsSmallTextSize = 18;

const double ktsExtraSmallTextSize = 16;

const BorderRadius kbrDefaultFieldBorderRadius =
    const BorderRadius.all(Radius.circular(5));

const Border kbDefaultFieldBorder = const Border(
  bottom: _defaultBorderSide,
  top: _defaultBorderSide,
  left: _defaultBorderSide,
  right: _defaultBorderSide,
);

const BorderSide _defaultBorderSide = BorderSide(color: Colors.grey, width: 1);
