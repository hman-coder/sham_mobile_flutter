import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:sham_mobile/widgets_functional/sham_custom_icons.dart';
import 'package:sham_mobile/widgets_ui/default_values.dart';

class AboutLibraryUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('about_sham'.tr),
      ),
      body: Column(
        children: [
          Expanded(
            child: Material(
              elevation: 6,
              child: Image.asset(
                'assets/images/sham_facade.jpg',
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Text(
                  'sham_description'.tr + ':',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: goToWebsite,
                child: CircleIcon(
                  icon: ShamCustomIcons.facebook_letter_only,
                  backgroundColor: kcFacebookBlue,
                  iconColor: Colors.white,
                ),
              ),

              GestureDetector(
                onTap: goToWebsite,
                child: CircleIcon(
                  icon: ShamCustomIcons.link,
                  backgroundColor: Colors.grey,
                  iconColor: Colors.white,
                ),
              ),
            ],
          ),

          SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('facebook'.tr),
              Text('website'.tr),
            ],
          ),

          SizedBox(height: 12),
        ],

      ),
    );
  }

  void goToFacebookPage() {

  }

  void goToWebsite() {

  }
}

class CircleIcon extends StatelessWidget {
  final double size;

  final IconData icon;

  final Color iconColor;

  final Color backgroundColor;

  CircleIcon({
    this.backgroundColor = Colors.black,
    this.iconColor = Colors.white,
    @required this.icon,
    this.size = 35,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(size),
      elevation: 10,
      child: CircleAvatar(
        backgroundColor: backgroundColor,
        radius: size,
        child: Icon(icon, color: iconColor, size: size),
      ),
    );
  }
}
