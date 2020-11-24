import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class OffersUI extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('offers'.tr),
        ),
        body: Center(child: Text('offers')));
  }
}