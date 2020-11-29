import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/helpers/get_extensions.dart';

class SignUpAlertDialog extends StatefulWidget {

  @override
  _SignUpAlertDialogState createState() => _SignUpAlertDialogState();
}

class _SignUpAlertDialogState extends State<SignUpAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Get.direction,
      child: AlertDialog(
        title: Text("get_book".tr),

        content: Text("account_needed_message".tr,
          maxLines: 10,
        ),

        actions: <Widget>[
          FlatButton(
            child: Text("cancel".tr),
            onPressed: () => Navigator.pop(context),
          ),
          FlatButton(
            child: Text("sign_in".tr),
            onPressed: () => null,
          ),
        ],
      ),
    );
  }
}
