import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sham_mobile/models/user.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';
import 'package:sham_mobile/ui/login/facebook_sign_in_button.dart';
import 'package:sham_mobile/ui/login/password_field.dart';
import 'package:sham_mobile/widgets/labeled_divider.dart';

import 'google_sign_in_button.dart';

class LoginUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginUIState();
}

class LoginUIState extends State<LoginUI> {
  User user = User();

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ShamLocalizations.of(context).getDirection(),
      child: Scaffold(
        appBar: AppBar(
            title: Text(
                ShamLocalizations.of(context).getValue('sign_in')
            )
        ),

        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildLogoWidget(),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LabeledDivider(
                      label: Text(ShamLocalizations.of(context).getValue('social_sign_in')),
                    )
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          child: GoogleSignInButton(),
                        margin: EdgeInsets.symmetric(vertical: 12),
                      ),

                      Container(
                        child: FacebookSignInButton(),
                        margin: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ],
                  ),



                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LabeledDivider(
                        label: Text(ShamLocalizations.of(context).getValue('sham_sign_in')),
                      )
                  ),

                  _buildUsernameField(),

                  _buildPasswordField(),

                  _buildSignInButton(),

                  _buildCancelButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoWidget() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Hero(
        tag: "sham_logo",
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            constraints: BoxConstraints(maxHeight: 150),
            margin: EdgeInsets.all(10),
            child: Image.asset(
              'assets/images/sham_logo.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUsernameField() {
    return  Container(
      margin: EdgeInsets.all(10),
      child: TextFormField(
        textDirection: TextDirection.ltr,
        decoration: InputDecoration(
            labelText: ShamLocalizations.of(context).getValue('username'),
            border: OutlineInputBorder()
        ),
        onChanged: (username) => user.username = username,
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
        margin: EdgeInsets.all(10),
        child: PasswordField(
          textDirection: TextDirection.ltr,
          decoration: InputDecoration(
            labelText: ShamLocalizations.of(context).getValue('password'),
            border: OutlineInputBorder()
          ),
          onChanged: (password) => user.password = password,
        ),
      );
  }

  Widget _buildSignInButton() {
    return FlatButton(
      child: Text(ShamLocalizations.of(context).getValue("sign_in")),
      onPressed: () => print("sign_in"),
    );
  }

  Widget _buildCancelButton() {
    return FlatButton(
      child: Text(ShamLocalizations.of(context).getValue("sign_up")),
      onPressed: () => print("sign_up"),
    );
  }
}