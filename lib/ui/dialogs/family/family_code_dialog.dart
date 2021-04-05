import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/controllers/family_info_controller.dart';
import 'package:sham_mobile/constants/default_widgets.dart';
import 'package:sham_mobile/ui/widgets/buttons/cancel_button.dart';

/// The dialog used when wanting to join a pre-existing family
class FamilyCodeDialog extends GetView<FamilyInfoController> {
  final TextEditingController familyCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('enter_family_code'.tr),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: TextField(
            keyboardType: TextInputType.number,
            controller: familyCodeController,
          ),
        ),
        verticalLargeSpacer,
        FlatButton(
          child: Text('submit'.tr),
          textTheme: ButtonTextTheme.primary,
          onPressed: () =>
              controller.joinFamilyWithCode(familyCodeController.text),
        ),
        verticalSmallSpacer,
        CancelButton(),
      ],
    );
  }
}
