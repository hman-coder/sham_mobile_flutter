import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/helpers/get_extensions.dart';
import 'package:sham_mobile/widgets/default_values.dart';
import 'package:sham_mobile/widgets/sham_screen_width_button.dart';

// TODO: HANDLE FIELDS NOT FILLED

class PersonalInfoUI extends StatelessWidget {
  final String firstName;

  final String lastName;

  PersonalInfoUI({Key key,
    this.firstName,
    this.lastName}) : super(key: key);

  String editedFirstName = '';

  String editedLastName = '';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Get.direction,
      child: Scaffold(
        appBar: AppBar(title: Text('personal_info'.tr)),

        body: ListView(
          children: [
            _PersonalInfoTextField(
              labelText: 'first_name'.tr,
              inputAction: TextInputAction.next,
              text: firstName,
              onTextChanged: (text) => editedFirstName = text
              ),

                _PersonalInfoTextField(
                labelText: 'last_name'.tr,
                text: lastName,
                inputAction: TextInputAction.done,
                onTextChanged: (text) => editedLastName = text,
                ),

                SizedBox(height: 25,),

                Center(
                  child: ShamScreenWidthButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    text: 'save'.tr,
                    height: 60,
                    onPressed: () => Get.back(result: [editedFirstName, editedLastName]),
              ),
            )
          ],
        ),
      ),
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
