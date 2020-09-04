import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';

class SignUpAlertDialog extends StatefulWidget {

  @override
  _SignUpAlertDialogState createState() => _SignUpAlertDialogState();
}

class _SignUpAlertDialogState extends State<SignUpAlertDialog> {
  @override
  Widget build(BuildContext context) {
    ShamLocalizations localizations = ShamLocalizations.of(context);
    return Directionality(
      textDirection: localizations.getDirection(),
      child: AlertDialog(
        title: Text(localizations.getValue("get_book")),

        content: Text(localizations.getValue("account_needed_message"),
          maxLines: 10,
        ),

        actions: <Widget>[
          FlatButton(
            child: Text(localizations.getValue("cancel")),
            onPressed: () => Navigator.pop(context),
          ),
          FlatButton(
            child: Text(localizations.getValue("sign_in")),
            onPressed: () => null,
          ),
        ],
      ),
    );
  }
}
