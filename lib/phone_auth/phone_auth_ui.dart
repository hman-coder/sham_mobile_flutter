import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sham_mobile/widgets/default_values.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/helpers/get_extensions.dart';
import 'package:sham_mobile/phone_auth/phone_auth_controller.dart';

class PhoneAuthUI extends GetView<PhoneAuthController> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Get.direction,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('phone_number_authentication'.tr),
          leading: BackButton(
            color: Colors.white,
            onPressed: () => Get.back(result: '+963935464603'),
          ),
        ),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'please_enter_phone_number'.tr,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: DefaultValues.largeTextSize,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                  'please_enter_phone_number_guide'.tr + ".",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: DefaultValues.smallTextSize
                  )
              ),
            ),

            SizedBox(height: 40,),

            Center(child: _PhoneNumberField()),

            SizedBox(height: 30,),

            Center(child: _PhoneAuthSubmitButton()),

            SizedBox(height: 30,),

            Obx(() =>
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  child: controller.isSendingCode
                      ? Center(child: SizedBox(
                      height: 35, child: CircularProgressIndicator()))
                      : Container(),
                ),
            ),

            Obx(() =>
                Center(
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 400),
                    child: !controller.isSendingCode
                        ? Container()
                        : Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                          'a_text_will_be_sent'.tr,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: DefaultValues.smallTextSize
                          )
                      ),
                    ),
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhoneNumberField extends GetView<PhoneAuthController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _CountryPickerButton(),

            SizedBox(width: 10,),

            Container(
              constraints: BoxConstraints(maxWidth: 200),
              color: Colors.grey.shade200,
              child: TextField(
                  decoration: InputDecoration(
                    hintText: 'phone_number'.tr,
                    contentPadding: EdgeInsetsDirectional.only(start: 12),
                  ),
                  style: TextStyle(
                      fontSize: DefaultValues.smallTextSize
                  ),
                  keyboardType: TextInputType.phone,
                  onChanged: (text) => controller.phoneNumber = text
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CountryPickerButton extends GetView<PhoneAuthController> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide()),
        ),
        child: Obx(() => FlatButton.icon(
            color: Colors.grey.shade200,
              padding: EdgeInsets.all(8),
              onPressed: () => _showCountryPickerDialog(context),
              icon: CountryPickerUtils.getDefaultFlagImage(controller.country),
              label: Text('+${controller.country.phoneCode}',
                style: TextStyle(fontSize: DefaultValues.smallTextSize),
              )
          ),
        ),
      );
  }

  void _showCountryPickerDialog(BuildContext context) {
    showDialog<bool>(
        context: context,
        builder: (ctx) => CountryPickerDialog(
            onValuePicked: (country) => controller.country = country,
            title: Text('select_country'.tr),
            isSearchable: true,
            itemBuilder: (country) => _CountryDialogListItem(country),
        )
    );
  }
}

class _CountryDialogListItem extends StatelessWidget {
  final Country country;

  const _CountryDialogListItem(this.country, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black,
                    width: 1
                )
            ),
            child: CountryPickerUtils.getDefaultFlagImage(country)),
        SizedBox(width: 15),
        SizedBox(width: 50, child: Text('+${country.phoneCode}')),
        Flexible(child: Text(country.name, maxLines: 2,))
      ],
    );
  }
}

class _PhoneAuthSubmitButton extends GetView<PhoneAuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => FlatButton(
        splashColor: Colors.white.withOpacity(0.5),
        height: 40,
        minWidth: MediaQuery.of(context).size.width - 50,
        child: Text(
          'verify_number'.tr,
          style: TextStyle(
              color: Colors.white,
              fontSize: DefaultValues.mediumTextSize
          ),
        ),
        onPressed: controller.isSendingCode ? null : () {
          FocusScope.of(context).unfocus();
          controller.submitPhoneNumber();
        },
      disabledColor: Colors.grey,
      color: DefaultValues.maroon,
      ),
    );
  }
}