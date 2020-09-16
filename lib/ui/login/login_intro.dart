import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';
import 'package:sham_mobile/ui/main/main_ui.dart';
import 'package:sham_mobile/widgets/default_values.dart';
import 'package:sham_mobile/widgets/delayed_animation.dart';

import 'login_ui.dart';

class LoginIntroUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginIntroState();
}

class LoginIntroState extends State<LoginIntroUI> {
  int multiplier = 1;
  int delay = 800;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: ShamLocalizations.of(context).getDirection(),
        child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex:5,
                  child: Container(),
                ),

                Expanded(
                  flex: 30,
                  child: _buildLogoWidget()
                ),

                _buildAccountBenefitsDescriptionWidget(),

                Expanded(
                  flex: 7,
                  child: Container(),
                ),

                _buildUserHasAnAccountWidget(context),

                Expanded(
                  flex: 5,
                  child: Container(),
                ),

                _buildCancelWidget(context),

                Expanded(
                  flex: 5,
                  child: Container(),
                ),
              ],
            )
        )
    );
  }

  Widget _buildLogoWidget() {
    return Hero(
      tag: "sham_logo",
      child: Image.asset('assets/images/sham_logo.png',
          fit: BoxFit.cover),
    );
  }

  Widget _buildAccountBenefitsDescriptionWidget() {
    return DelayedAnimation(
      delayInMilliseconds: delay * multiplier++ - 400,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        child: Card(
          color: Provider.of<DefaultValues>(context).maroon,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
          child: DelayedAnimation(
            delayInMilliseconds: delay * multiplier - 800,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: AutoSizeText(
                ShamLocalizations.of(context).getValue('sign_in_description'),
                textAlign: TextAlign.center,
                minFontSize: Provider.of<DefaultValues>(context).largeTextSize,
                maxLines: 5,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Harmattan',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserHasAnAccountWidget(BuildContext context) {
    return DelayedAnimation(
        delayInMilliseconds: delay * multiplier++,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: 25),
          child: FlatButton(
            color: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18)
            ),
            child: DelayedAnimation(
                delayInMilliseconds: delay *  multiplier - 400,
                child: Text(ShamLocalizations.of(context).getValue('sign_in_or_create_new_account'),
                  style: TextStyle(
                    fontSize: Provider.of<DefaultValues>(context).mediumTextSize,
                    fontFamily: "Harmattan",
                    color: Colors.white
                  ),
                )
            ),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginUI())),
          ),
        )
    );
  }

  Widget _buildCancelWidget(BuildContext context) {
    return DelayedAnimation(
        delayInMilliseconds: delay * multiplier++,
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18)
          ),
          child: Text(ShamLocalizations.of(context).getValue('use_app_without_account'),
            style: TextStyle(
              fontSize: Provider.of<DefaultValues>(context).mediumTextSize,
              fontFamily: "Harmattan",
            ),
          ),
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainUI())),
        )
    );
  }

}