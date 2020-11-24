import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class RequiredContactInfoUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('required info'),

          CheckboxListTile(
            title: Text("phone_number".tr),
            subtitle: Text("phone_number_description".tr),
            value: true,
            onChanged: null
          ),

          CheckboxListTile(
            title: Text("personal_info".tr),
            subtitle: Text("personal_info_description".tr),
            value: true,
            onChanged: null,
          ),

          CheckboxListTile(
              title: Text("personal_info".tr),
              subtitle: Text("personal_info_description".tr),
              value: true,
              onChanged: null,
          ),
        ]
      ),
    );
  }
}
