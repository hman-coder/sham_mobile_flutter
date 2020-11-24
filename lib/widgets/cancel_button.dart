import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

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
      onPressed: () => Navigator.pop(context, null),
    );
  }
}