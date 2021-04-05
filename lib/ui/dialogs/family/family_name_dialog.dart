import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/controllers/family_info_controller.dart';
import 'package:sham_mobile/ui/widgets/buttons/cancel_button.dart';
import 'package:sham_mobile/helpers/value_editor.dart';

/// A dialog that contains a text field, a back option, and a confirm option.
/// Used for editing a family name, or creating a new family
class FamilyNameDialog extends GetView<FamilyInfoController> {
  final ValueEditor<String> familyNameEditor;

  FamilyNameDialog({String initialFamilyName = '', Key key}) :
        familyNameEditor = ValueEditor<String>(initialFamilyName),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('edit_family'.tr),
      content: TextField(
        controller: TextEditingController(
          text: familyNameEditor.originalValue,
        ),
        onChanged: (text) => familyNameEditor.editedValue = text,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        CancelButton(),
        FlatButton(
          onPressed: () => Get.back(result: familyNameEditor.editedValue),
          child: Text('confirm'.tr),
        ),
      ],
    );
  }
}

