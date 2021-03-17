import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/helpers/get_extensions.dart';
import 'package:sham_mobile/models/address.dart';
import 'package:sham_mobile/widgets_ui/default_values.dart';
import 'package:sham_mobile/widgets_ui/sham_screen_width_button.dart';
import 'package:sham_mobile/controllers/error_controller.dart';

// ignore: must_be_immutable
class AddressUI extends StatelessWidget {
  final Address address;

  Address _modifiedAddress;

  AddressUI({Key key, Address address}) :
        address = address,
        _modifiedAddress = Address(
            city: address?.city ?? '',
            district: address?.district ?? '',
            street: address?.street ?? '',
            others: address?.others ?? ''
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Get.direction,
      child: Scaffold(

        appBar: AppBar(title: Text("address".tr)),

        body: ListView(
          padding: const EdgeInsets.all(12.0),
          children: [
            _CitySelectionComponent(
              onChanged: (city) => _modifiedAddress.city = city,
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: TextEditingController(text: address?.district),
                textInputAction: TextInputAction.next,
                decoration: DefaultValues
                    .ktsDefaultTextFieldInputDecoration.copyWith(
                  labelText: 'district'.tr + ' *'
                ),

                onChanged: (text) => _modifiedAddress.district = text,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: TextEditingController(text: address?.street),
                textInputAction: TextInputAction.next,
                decoration: DefaultValues
                    .ktsDefaultTextFieldInputDecoration.copyWith(
                  labelText: 'street'.tr + ' *',
                ),

                onChanged: (text) => _modifiedAddress.street = text,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                  controller: TextEditingController(text: address?.others),
                decoration: DefaultValues
                    .ktsDefaultTextFieldInputDecoration.copyWith(
                  labelText: 'others'.tr  + ' *',
                  hintText: 'address_other_field_hint'.tr,
                ),

                onChanged: (text) => _modifiedAddress.others = text,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: ShamScreenWidthButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  text: 'save'.tr,
                  height: 60,
                  onPressed: onSubmit,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  onSubmit() {
    if(_allFieldsAreFilled()) Get.back(result: _modifiedAddress);

    else _showFillFieldsError();
  }

  bool _allFieldsAreFilled() {
    return _modifiedAddress.street.isNotEmpty
        && _modifiedAddress.district.isNotEmpty
        && _modifiedAddress.city.isNotEmpty
        && _modifiedAddress.others.isNotEmpty;
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


class _CitySelectionComponent extends StatelessWidget {
  final Function(String) onChanged;

  const _CitySelectionComponent({Key key, @required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Text('select_city'.tr + ' *',
            style: TextStyle(
              fontSize: DefaultValues.ktsMediumTextSize
            )
          ),
        ),

        Expanded(
          child: DropdownButton(
            isExpanded: true,
            itemHeight: 60,
            value: 'aleppo',
            items: [
              DropdownMenuItem(
                  value: 'aleppo',
                  child: Text('city_aleppo'.tr,
                    style: TextStyle(fontSize: DefaultValues.ktsMediumTextSize),)
              ),

              // DropdownMenuItem(
              //     value: 'damascus',
              //     child: Text('city_damascus'.tr, style: TextStyle(fontSize: DefaultValues.largeTextSize))
              // ),
              //
              // DropdownMenuItem(
              //     value: 'homs',
              //     child: Text('city_homs'.tr, style: TextStyle(fontSize: DefaultValues.largeTextSize))
              // ),
            ],
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
