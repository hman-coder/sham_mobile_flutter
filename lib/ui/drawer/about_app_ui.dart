import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:sham_mobile/constants/sham_custom_icons.dart';
import 'package:sham_mobile/constants/default_values.dart';
import 'package:sham_mobile/ui/widgets/buttons/social_button.dart';
import 'package:sham_mobile/constants/paths.dart';

class AboutAppUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('about_app'.tr),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  '${kpAssetImages}swissknife_logo.png',
                  fit: BoxFit.fill,
                ),
                Text('SwissKnife Software',
                    style: TextStyle(
                      fontSize: ktsExtraLargeTextSize,
                    )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'about_app_description'.tr,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: kcMaroon,
                  ),
                ),

                SizedBox(
                  height: 75,
                  child: SocialButton(
                    color: kcFacebookBlue,
                    onPressed: () => print('facebook page'),
                    icon: Icon(ShamCustomIcons.facebook_square, color: Colors.white),
                    text: 'SwissKnife on Facebook',
                  ),
                ),

                SizedBox(
                  height: 75,
                  child: SocialButton(
                    marginColor: Colors.black,
                    color: Colors.white,
                    onPressed: () => print('facebook page'),
                    icon: Icon(Icons.language, color: Colors.black),
                    text: 'SwissKnife on the web',
                    textStyle: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black),
                  ),
                ),

                SizedBox(
                  height: 75,
                  child: SocialButton(
                    color: kcFacebookBlue,
                    onPressed: () => print('facebook page'),
                    icon: Icon(ShamCustomIcons.facebook_square, color: Colors.white),
                    text: 'SwissKnife on Facebook',
                  ),
                ),

                RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 25,),
                  onPressed: () => print(''),
                  child: Text('view_software_licenses'.tr,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
