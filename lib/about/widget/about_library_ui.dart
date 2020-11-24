import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';
import 'package:get/get_utils/get_utils.dart';

class AboutLibraryUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('about_sham'.tr),
        ),
        body: Center(child: Text('About Sham')));
  }

}