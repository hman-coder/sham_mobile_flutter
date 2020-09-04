import 'package:flutter/material.dart';
import 'package:sham_mobile/models/user.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';

class SignUpUI extends StatelessWidget {
  User user;

  Widget build(BuildContext context) {
    ShamLocalizations localizations = ShamLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(title: Text(localizations.getValue("sign_up"))),

        body: ListView(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: localizations.getValue("username"),
              ),
            ),

            TextField(
              decoration: InputDecoration(
                labelText: localizations.getValue("password"),
              ),
            ),

            TextField(
              decoration: InputDecoration(
                helperText: localizations.getValue("address_helper_text"),
                labelText: localizations.getValue("address"),
              ),
            ),

            TextField(

            ),

          ],
        )
    );
  }
}