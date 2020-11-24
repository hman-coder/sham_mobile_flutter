import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class AccountInfoUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('account'.tr),
        ),
        body: Center(child: Text('Account Info'.tr)));
  }
}