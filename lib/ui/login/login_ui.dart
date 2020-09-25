import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham_mobile/blocs/login.dart';
import 'package:provider/provider.dart';
import 'package:sham_mobile/ui/profile_edit/edit_names_ui.dart';
import 'package:sham_mobile/widgets/delayed_animation.dart';
import 'package:sham_mobile/widgets/linear_gradient_background.dart';
import 'package:sham_mobile/widgets/sham_custom_icons.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';
import 'package:sham_mobile/widgets/default_values.dart';
import 'package:sham_mobile/widgets/labeled_divider.dart';

import 'phone_auth.dart';

class LoginUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginUIState();
}

class LoginUIState extends State<LoginUI> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: BlocListener<LoginBloc, LoginState>(
        listenWhen: (context, state) => state is UserAuthenticatedState,
        listener: (context, state) {
          if(state is UserAuthenticatedState)
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditNamesUI(state.user))
            );
        },

        child: Directionality(
          textDirection: ShamLocalizations.of(context).getDirection(),
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                  title: Text(
                      ShamLocalizations.of(context).getValue('sign_in')
                  )
              ),

              body: Stack(
                children: [
                  _buildBackground(),

                  Column(
                    children: <Widget>[
                      _buildDescriptionWidget(),

                      DelayedAnimation(
                        delayInMilliseconds: _getNextDelayDuration(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LabeledDivider(
                            color: Colors.white,
                            thickness: 1,
                            label: Text(ShamLocalizations.of(context).getValue('sign_in_with'),
                              style: TextStyle(
                                fontSize: Provider.of<DefaultValues>(context).mediumTextSize,
                                color: Colors.white
                              ),
                            ),
                          )
                        ),
                      ),

                      Container(height: 15,),

                      DelayedAnimation(
                        delayInMilliseconds: _getNextDelayDuration(),
                        child: SignInButton(
                          color: Color(0xFFD44637),
                          icon: Icon(ShamCustomIcons.gmail, color: Colors.white.withOpacity(0.8)),
                          text: ShamLocalizations.of(context).getValue('google_sign_in'),
                          onPressed: (ctx) => ctx.bloc<LoginBloc>().add(GoogleSignInRequested())
                        ),
                      ),

                      DelayedAnimation(
                        delayInMilliseconds: _getNextDelayDuration(),
                        child: SignInButton(
                            color: Color(0xFF29487D),
                            icon: Icon(ShamCustomIcons.facebook, color: Colors.white),
                            text: ShamLocalizations.of(context).getValue('facebook_sign_in'),
                            onPressed: (ctx) => ctx.bloc<LoginBloc>().add(FacebookSignInRequested())
                        ),
                      ),

                      DelayedAnimation(
                        delayInMilliseconds: _getNextDelayDuration(),
                        child: SignInButton(
                            color: Color(0xFF25D366),
                            icon: Icon(Icons.phone, color: Colors.white),
                            text: ShamLocalizations.of(context).getValue('phone_number'),
                            onPressed: (ctx) => Navigator.push(context,
                                MaterialPageRoute(builder: (context) => PhoneAuthUI(),))
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }

  Widget _buildBackground() {
    return LinearGradientBackground(
      color: Colors.black54,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/sham_bag.jpg'),
                fit: BoxFit.fitHeight
            )
        ),
      ),
    );
  }

  Widget _buildDescriptionWidget() {
    return DelayedAnimation(
      delayInMilliseconds: _getNextDelayDuration(),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        child: Card(
          elevation: 10,
          color: Colors.white70,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
          child: DelayedAnimation(
            delayInMilliseconds: _getNextDelayDuration() - 200,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: AutoSizeText(
                ShamLocalizations.of(context).getValue('sign_in_description'),
                textAlign: TextAlign.center,
                minFontSize: Provider.of<DefaultValues>(context).largeTextSize,
                maxLines: 5,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  int _delay = 400;
  int _multiplier = 1;

  int _getNextDelayDuration() {
    return  _delay * _multiplier++;
  }
}

class SignInButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final Color color;
  final Function(BuildContext context) onPressed;

  const SignInButton({
    Key key,
    @required this.icon,
    @required this.color,
    @required this.text,
    @required this.onPressed})
      : assert (icon != null) ,
        assert (text != null),
        assert (onPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) => Consumer<DefaultValues>(
        builder: (context, values, child) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: MaterialButton(
            disabledColor: Colors.black.withOpacity(0.1),
            onPressed: state is LoadingState
                ? null
                : () => this.onPressed(context),

            color: color.withOpacity(0.5),

            shape: Border(
              top: BorderSide(color: Colors.white),
              bottom: BorderSide(color: Colors.white),
            ),

            child: IntrinsicHeight(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: icon,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: VerticalDivider(color: Colors.white, width: 2, thickness: 2,),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(text,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

