import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/controllers/error_controller.dart';
import 'package:sham_mobile/helpers/get_extensions.dart';
import 'package:sham_mobile/widgets_ui/default_values.dart';
import 'package:sham_mobile/widgets_ui/sham_screen_width_button.dart';

// ignore: must_be_immutable
class PersonalInfoUI extends StatelessWidget {
  final String firstName;

  final String lastName;

  PersonalInfoUI({Key key,
    this.firstName,
    this.lastName}) :
        modifiedFirstName = firstName ?? '',
        modifiedLastName = lastName ?? '',
        super(key: key);

  String modifiedFirstName;

  String modifiedLastName;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Get.direction,
      child: Scaffold(
        appBar: AppBar(title: Text('personal_info'.tr)),

        body: ListView(
          children: [
            _PersonalInfoTextField(
              labelText: 'first_name'.tr + ' *',
              inputAction: TextInputAction.next,
              text: firstName,
              onTextChanged: (text) => modifiedFirstName = text
              ),

                _PersonalInfoTextField(
                labelText: 'last_name'.tr+ ' *',
                text: lastName,
                inputAction: TextInputAction.done,
                onTextChanged: (text) => modifiedLastName = text,
                ),

                SizedBox(height: 25,),

                Center(
                  child: ShamScreenWidthButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    text: 'save'.tr,
                    height: 60,
                    onPressed: onSubmit,
              ),
            )
          ],
        ),
      ),
    );
  }

  onSubmit() {
    if(_allFieldsAreFilled()) Get.back(result: [modifiedFirstName, modifiedLastName]);

    else _showFillFieldsError();
  }

  bool _allFieldsAreFilled() {
    return modifiedFirstName.isNotEmpty
        && modifiedLastName.isNotEmpty;
  }

  _showFillFieldsError() {
    Get.find<ShamMessageController>().showMessage(
      ShamMessage(
          displayType: MessageDisplayType.snackbar,
          severity: MessageSeverity.mild,
          message: 'please_fill_fields_with_star'.tr
      )
    );
  }
}

class _PersonalInfoTextField extends StatelessWidget {
  final String labelText;

  final String text;

  final TextInputAction inputAction;

  final ValueChanged<String> onTextChanged;

  const _PersonalInfoTextField({Key key,
    this.labelText,
    this.text,
    this.inputAction = TextInputAction.next,
    @required this.onTextChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        style: TextStyle(fontSize: DefaultValues.mediumTextSize),
        controller: TextEditingController(text: this.text),
        textInputAction: inputAction,
        decoration: DefaultValues.defaultTextFieldInputDecoration.copyWith(
            labelText: labelText,
        ),

        onChanged: onTextChanged,
      ),
    );
  }
}
