import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/helpers/get_extensions.dart';

class SignUpAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Get.direction,
      child: AlertDialog(
        title: Text("login_dialog_header".tr),

        content: Text("login_dialog_message".tr,
          maxLines: 10,
        ),

        actions: <Widget>[
          FlatButton(
            child: Text("cancel".tr),
            onPressed: () => Get.back(),
          ),
          FlatButton(
            child: Text("sign_in".tr),
            onPressed: () async {
              await Get.toNamed('/login');
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}


class ContactInfoAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Get.direction,
      child: AlertDialog(
        title: Text("contact_info_dialog_header".tr),

        content: Text("contact_info_dialog_message".tr,
          maxLines: 10,
        ),

        actions: <Widget>[
          FlatButton(
            child: Text("cancel".tr),
            onPressed: () => Get.back(),
          ),

          FlatButton(
            child: Text("contact_info".tr),
            onPressed: () async {
              await Get.toNamed('/login');
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}

