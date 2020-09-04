import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';
import 'package:sham_mobile/widgets/delayed_animation.dart';

class LoginIntroUI extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => LoginIntroState();
}

class LoginIntroState extends State<LoginIntroUI> {
  @override
  Widget build(BuildContext context) {
    int multiplier = 1;
    int delay = 800;
    return Directionality(
        textDirection: ShamLocalizations.of(context).getDirection(),
        child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex:5,
                  child: Container(),
                ),

                Expanded(
                  flex: 30,
                  child: Image.asset('assets/images/sham_logo.png',
                      fit: BoxFit.cover),
                ),

                DelayedAnimation(
                  delayInMilliseconds: delay * multiplier++ - 400,
                  child: Container(
                    margin: EdgeInsets.only(top: 15, bottom: 15, left: 25, right: 25),
                    child: Card(
                      child: DelayedAnimation(
                        delayInMilliseconds: delay * multiplier - 800,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: AutoSizeText(ShamLocalizations.of(context).getValue('login_description'),
                            textAlign: TextAlign.center,
                            maxLines: 5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  flex: 7,
                  child: Container(),
                ),

                DelayedAnimation(
                    delayInMilliseconds: delay * multiplier++,
                    child: FlatButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)
                      ),
                      child: DelayedAnimation(
                          delayInMilliseconds: delay *  multiplier - 400,
                          child: Text(ShamLocalizations.of(context).getValue('has_an_account'))
                      ),
                      onPressed: () => print("sign in"),
                    )
                ),

                Expanded(
                  flex: 5,
                  child: Container(),
                ),

                DelayedAnimation(
                    delayInMilliseconds: delay * multiplier++,
                    child: FlatButton(
                      child: Text(ShamLocalizations.of(context).getValue('create_new_account')),
                      onPressed: () => print("new account"),
                    )
                ),

                Expanded(
                  flex: 5,
                  child: Container(),
                ),
              ],
            )
        )
    );

  }

}