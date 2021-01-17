import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class FamilyInfoUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('family_info'.tr),
        ),
        body: Center(child: Text('Family Info'.tr)));
  }
}