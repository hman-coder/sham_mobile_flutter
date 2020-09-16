import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';
import 'package:sham_mobile/widgets/default_values.dart';
import 'package:sham_mobile/widgets/sham_custom_icons.dart';

class GoogleSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 300),
      child: MaterialButton(
        height: 50,
        onPressed: googleSignIn,
        color: Colors.grey.shade200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(ShamCustomIcons.gmail, color: Color(0xffD44638)),
            ),
            Text(ShamLocalizations.of(context).getValue("google_sign_in"),
              maxLines: 2,
              style: TextStyle(
                  fontSize: Provider.of<DefaultValues>(context).largeTextSize,
                  color: Colors.black,
                  fontFamily: "Harmattan"
              ),
            )
          ],
        ),
      ),
    );
  }

  void googleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          'email', 'https://www.googleapis.com/auth/userinfo.profile'
        ]
    );

    try {
      GoogleSignInAccount acc = await googleSignIn.signIn();
      print('display name: ${acc.displayName}');
      print(acc.email);
      print(acc.id);

      GoogleSignInAuthentication auth = await acc.authentication;

      final http.Response res = await http.get(
          'https://people.googleapis.com/v1/people/${acc.id}?personFields=birthdays&access_token=${auth.accessToken}',
          headers: await googleSignIn.currentUser.authHeaders
      );

      if(res.statusCode != 200) {
        print('People API ${res.statusCode} response: ${res.body}');
      } else {
        print(res.body);
      }

    } catch (error) {
      print("-----------------------------------------------");
      print(error);
      print("-----------------------------------------------");

    } finally {
      googleSignIn.signOut();
    }
  }
}
