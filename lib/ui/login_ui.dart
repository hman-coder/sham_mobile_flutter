import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/helpers/get_extensions.dart';
import 'package:sham_mobile/widgets_ui/delayed_animation.dart';
import 'package:sham_mobile/widgets_ui/linear_gradient_background.dart';
import 'package:sham_mobile/widgets_functional/sham_custom_icons.dart';
import 'package:sham_mobile/widgets_ui/default_values.dart';
import 'package:sham_mobile/widgets_ui/labeled_divider.dart';

import 'package:sham_mobile/controllers/login_controller.dart';
import 'package:sham_mobile/widgets_ui/social_button.dart';

class LoginUI extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Get.direction,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
              title: Text('sign_in'.tr,
                style: TextStyle(
                    fontSize: DefaultValues.largeTextSize
                ),
              ),
          ),

          body: Stack(
            children: [
              _buildBackground(),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            fontSize: DefaultValues.smallTextSize,
                            color: Colors.white
                          ),
                        ),
                      )
                    ),
                  ),

                  Container(height: 15,),

                  DelayedAnimation(
                    delayInMilliseconds: _getNextDelayDuration(),
                    child: Obx(() => SocialButton(
                      disabled: controller.isProcessing,
                      color: DefaultValues.gmail_red,
                      icon: Icon(ShamCustomIcons.gmail, color: Colors.white.withOpacity(0.8)),
                      text: 'google_sign_in'.tr,
                      onPressed: controller.performGoogleSignIn
                      ),
                    ),
                  ),

                  DelayedAnimation(
                    delayInMilliseconds: _getNextDelayDuration(),
                    child: Obx(() => SocialButton(
                      disabled: controller.isProcessing,
                      color: DefaultValues.facebook_blue,
                      icon: Icon(ShamCustomIcons.facebook, color: Colors.white),
                      text: 'facebook_sign_in'.tr,
                      onPressed: controller.performFacebookSignIn
                      ),
                    ),
                  ),

                  DelayedAnimation(
                    delayInMilliseconds: _getNextDelayDuration(),
                    child: Obx(() => SocialButton(
                      color: DefaultValues.whatsapp_green,
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
                minFontSize: DefaultValues.mediumTextSize,
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