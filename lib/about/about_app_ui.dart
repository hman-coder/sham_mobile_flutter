import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class AboutAppUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('about_app'.tr),
        ),
        body: Center(child: Text('About App')));
  }

}