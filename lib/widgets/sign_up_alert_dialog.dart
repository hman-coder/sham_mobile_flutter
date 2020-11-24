import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';
import 'package:get/get_utils/get_utils.dart';

class SignUpAlertDialog extends StatefulWidget {

  @override
  _SignUpAlertDialogState createState() => _SignUpAlertDialogState();
}

class _SignUpAlertDialogState extends State<SignUpAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ShamLocalizations.of(context).getDirection(),
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
