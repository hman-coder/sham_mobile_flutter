import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/controllers/contact_info_controller.dart';
import 'package:sham_mobile/helpers/get_extensions.dart';
import 'package:sham_mobile/constants/default_values.dart';

class ContactInfoUI extends GetView<ContactInfoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(title: Text('contact_info'.tr)),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 20,
            ),
            child: ListTile(
              title: Text('contact_info_description'.tr,
                textDirection: Get.direction,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: ktsLargeTextSize
                ),
              ),

              subtitle: Text('* ' + 'contact_info_your_info_is_safe'.tr),
            ),
          ),

          TightDivider(),

          Expanded(
            child: Center(
              child: Obx(() =>
                  CheckboxListTile(
                    secondary: Icon(Icons.phone),
                    title: Text("phone_number".tr, style: TextStyle(fontSize: ktsMediumTextSize),),
                    subtitle: Text(controller.isPhoneNumberAuthenticated
                        ? "contact_info_change_phone_number".tr
                        : "contact_info_info_not_provided".tr),
                    value: controller.isPhoneNumberAuthenticated,
                    onChanged: (val) => controller.onPhoneNumberPressed(),
                  )
              ),
            ),
          ),

          TightDivider(),

          Expanded(
            child: Center(
              child: Obx(() => CheckboxListTile(
                  secondary: Icon(Icons.account_circle),
                  title: Text("personal_info".tr, style: TextStyle(fontSize: ktsMediumTextSize)),
                  subtitle: Text(controller.isPersonalInfoGiven
                      ? "contact_info_change_personal_info".tr
                      : "contact_info_info_not_provided".tr),
                  value: controller.isPersonalInfoGiven,
                  onChanged: (val) => controller.onPersonalInfoPressed(),
                ),
              ),
            ),
          ),

            Divider(thickness: 1),

          Expanded(
            child: Center(
              child: Obx(() => CheckboxListTile(
                  secondary: Icon(Icons.location_on),
                    title: Text("address".tr, style: TextStyle(fontSize: ktsMediumTextSize)),
                    subtitle: Text(controller.isAddressGiven
                        ? "contact_info_change_change_address".tr
                        : "contact_info_info_not_provided".tr),
                    value: controller.isAddressGiven,
                    onChanged: (val) => controller.onAddressPressed(),
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}

/// A horizontal divider without padding around it
class TightDivider extends StatelessWidget {
  final double width;

  final Color color;

  const TightDivider({Key key, this.width = 1, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: color ?? Colors.grey.shade300, width: width,))
      ),
    );
  }
}
