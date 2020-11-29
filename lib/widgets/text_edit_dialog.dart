import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/helpers/get_extensions.dart';
import 'cancel_button.dart';

class TextEditDialog extends StatelessWidget {
  final String title;

  final String startingText;

  final String hintText;

  const TextEditDialog({Key key, @required this.title, @required this.startingText, this.hintText = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String returnedValue = startingText;
    return Directionality(
      textDirection: Get.direction,
      child: AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),

        content: TextField(
          decoration: InputDecoration(
            hintText: hintText,
          ),
          controller: TextEditingController(text: startingText),
          onChanged: (text) => returnedValue = text,
        ),

        actions: <Widget>[
          CancelButton(),
          FlatButton(
            child: Text('edit'.tr),
            onPressed: () => Navigator.pop(context, returnedValue),
          )
        ],
      ),
    );
  }
}
