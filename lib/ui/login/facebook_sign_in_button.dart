import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';
import 'package:sham_mobile/widgets/default_values.dart';
import 'package:sham_mobile/widgets/sham_custom_icons.dart';

class FacebookSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 300),
      child: MaterialButton(
        height: 50,
        onPressed: _facebookSignIn,
        color: Color(0xFF3B5998),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(ShamCustomIcons.facebook, color: Colors.white),
            ),
            Text(ShamLocalizations.of(context).getValue("facebook_sign_in"),
              maxLines: 2,
              style: TextStyle(
                  fontSize: Provider.of<DefaultValues>(context).largeTextSize,
                  color: Colors.white,
                  fontFamily: "Harmattan"
              ),
            )
          ],
        ),
      ),
    );
  }

  void _facebookSignIn() async {

  }
}
