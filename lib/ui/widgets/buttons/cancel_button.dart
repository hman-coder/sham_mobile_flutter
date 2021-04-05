import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';

class CancelButton extends StatelessWidget {
  final TextStyle style;

  final ButtonTextTheme textTheme;

  const CancelButton({Key key, this.style, this.textTheme = ButtonTextTheme.primary }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      textTheme: textTheme,
      child: Text(
        'cancel'.tr,
        style: style,
      ),
      onPressed: () => Get.back(),
    );
  }
}