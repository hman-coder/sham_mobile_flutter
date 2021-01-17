import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class ActivitiesUI extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('activities'.tr),
        ),
        body: Center(child: Text('Activities')));
  }
}