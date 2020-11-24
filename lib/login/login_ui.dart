import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sham_mobile/widgets/delayed_animation.dart';
import 'package:sham_mobile/widgets/linear_gradient_background.dart';
import 'package:sham_mobile/widgets/sham_custom_icons.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';
import 'package:sham_mobile/widgets/default_values.dart';
import 'package:sham_mobile/widgets/labeled_divider.dart';
import 'package:get/get_utils/get_utils.dart';

import 'login_controller.dart';

class LoginUI extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ShamLocalizations.of(context).getDirection(),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
              title: Text('sign_in'.tr,
                style: TextStyle(
                    fontSize: Provider.of<DefaultValues>(context).largeTextSize
                ),
              ),
          ),

          body: Stack(
            children: [
              _buildBackground(),

              Column(
                children: <Widget>[
                  _buildDescriptionWidget(context),

                  DelayedAnimation(
                    delayInMilliseconds: _getNextDelayDuration(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LabeledDivider(
                        color: Colors.white,
                        thickness: 1,
                        label: Text('sign_in_with'.tr,
                          style: TextStyle(
                            fontSize: Provider.of<DefaultValues>(context).smallTextSize,
                            color: Colors.white
                          ),
                        ),
                      )
                    ),
                  ),

                  Container(height: 15,),

                  DelayedAnimation(
                    delayInMilliseconds: _getNextDelayDuration(),
                    child: Obx(() => SignInButton(
                      disabled: controller.isProcessing,
                      color: Color(0xFFD44637),
                      icon: Icon(ShamCustomIcons.gmail, color: Colors.white.withOpacity(0.8)),
                      text: 'google_sign_in'.tr,
                      onPressed: controller.performGoogleSignIn
                      ),
                    ),
                  ),

                  DelayedAnimation(
                    delayInMilliseconds: _getNextDelayDuration(),
                    child: Obx(() => SignInButton(
                      disabled: controller.isProcessing,
                      color: Color(0xFF29487D),
                      icon: Icon(ShamCustomIcons.facebook, color: Colors.white),
                      text: 'facebook_sign_in'.tr,
                      onPressed: controller.performFacebookSignIn
                      ),
                    ),
                  ),

                  DelayedAnimation(
                    delayInMilliseconds: _getNextDelayDuration(),
                    child: Obx(() => SignInButton(
                      color: Color(0xFF25D366),
                      icon: Icon(Icons.phone, color: Colors.white),
                      text: 'phone_number'.tr,
                      onPressed: controller.performPhoneSignIn,
                      disabled: controller.isProcessing,
                      ),
                    ),
                  ),
                ],
              ),
            ],
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

  Widget _buildDescriptionWidget(BuildContext context) {
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
                'sign_in_description'.tr,
                textAlign: TextAlign.center,
                minFontSize: Provider.of<DefaultValues>(context).mediumTextSize,
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
  final bool disabled;
  final Function onPressed;

  const SignInButton({
    Key key,
    @required this.icon,
    @required this.color,
    @required this.text,
    @required this.onPressed,
    this.disabled = false})
      : assert (icon != null) ,
        assert (text != null),
        assert (onPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: MaterialButton(
            disabledColor: Colors.black.withOpacity(0.1),
            disabledTextColor: Colors.grey,
            onPressed: disabled ? null : this.onPressed,

            color: color.withOpacity(0.6),

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
        );
  }
}

