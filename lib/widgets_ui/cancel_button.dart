import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';

class CancelButton extends StatelessWidget {
  final TextStyle style;

  const CancelButton({Key key, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        'cancel'.tr,
        style: style ?? DefaultTextStyle.of(context).style,
      ),
      onPressed: () => Get.back(),
    );
  }
}