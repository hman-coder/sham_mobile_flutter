import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';

class PhoneAuthUI extends StatefulWidget {
  @override
  _PhoneAuthUIState createState() => _PhoneAuthUIState();
}

class _PhoneAuthUIState extends State<PhoneAuthUI> {
  String _number;

  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ShamLocalizations.of(context).getValue('phone_number'))
      ),

      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 200),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    onChanged: (text) => _number = text,
                  ),
                ),

                CountryCodePicker(
                  onChanged: (code) => print(code.toString()),
                )
              ],
            ),

            FlatButton(
              child: Text("Confirm"),
              onPressed: authenticate,
            ),

            codeSent ? Text("Code sent") : Container()
          ],
        ),
    );
  }

  void authenticate() async {
    await Firebase.initializeApp();
    var firebaseAuth = FirebaseAuth.instance;
    firebaseAuth.verifyPhoneNumber(
        phoneNumber: _number,
        timeout: Duration(seconds: 60),
        verificationCompleted: (firebaseUser) {
          print(firebaseUser);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        codeSent: (verificationId, [forceResendingToken]) => setState(() => codeSent = true),
        verificationFailed: (error) => print (error)
    );
  }
}
