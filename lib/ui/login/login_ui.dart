import 'package:flutter/material.dart';
import 'package:sham_mobile/models/user.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';

class LoginUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginUIState();
}

class LoginUIState extends State<LoginUI> {
  User user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              ShamLocalizations.of(context).getValue('login')
          )
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/images/sham_logo.png',
            fit: BoxFit.cover,
          ),

          TextField(
            onChanged: (username) => user.username = username,
          ),

          TextField(
            obscureText: true,
            onChanged: (password) => user.password= password,
          ),

          FlatButton(
            child: Text(ShamLocalizations.of(context).getValue("login")),
            onPressed: () => print("sign_in"),
          ),

          FlatButton(
            child: Text(ShamLocalizations.of(context).getValue("sign_up")),
            onPressed: () => print("sign_up"),
          )
        ],
      ),
    );
  }
}