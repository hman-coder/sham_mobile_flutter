import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';
import 'package:sham_mobile/widgets/default_values.dart';

import 'phone_auth_controller.dart';

class PhoneAuthPinVerificationDialog extends GetView<PhoneAuthController> {
  String _pinCode;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ShamLocalizations.of(context).getDirection(),
      child: Dialog(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('enter_phone_auth_pin_code'.tr,
                        style: TextStyle(fontSize: Provider.of<DefaultValues>(context).smallTextSize)
                    ),

                    SizedBox(height: 20,),

                    Directionality(
                        textDirection: TextDirection.ltr,
                        child: _PinCodeField(
                          onCodeChanged: (code) => _pinCode = code,
                        )
                    ),

                    SizedBox(height: 10,),

                    Obx(() {
                        if(controller.isValidatingPinCode)
                          return Center(child: CircularProgressIndicator());

                        else if (controller.isPinCodeInvalid)
                          return Center(child: Text(
                              'invalid_code'.tr + '.',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: Provider.of<DefaultValues>(context).smallTextSize
                              )
                          ));

                        else return Container();
                      },
                    ),

                    Obx(() {
                          if(controller.isValidatingPinCode || controller.isPinCodeInvalid)
                            return SizedBox(height: 10);
                          else return Container();
                        }
                    ),

                    FlatButton(
                      minWidth: double.infinity,
                      child: Text(
                        'confirm'.tr,
                        style: TextStyle(
                            fontSize: Provider.of<DefaultValues>(context).smallTextSize,
                            color: Colors.white
                        ),
                      ),
                      color: Provider.of<DefaultValues>(context).maroon,
                      onPressed: () => controller.submitPinCode(_pinCode),
                    ),

                    FlatButton(
                      minWidth: double.infinity,
                      child: Text('cancel'.tr,
                        style: TextStyle(
                            fontSize: Provider.of<DefaultValues>(context).smallTextSize,
                            color: Provider.of<DefaultValues>(context).maroon
                        ),
                      ),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                  ]
              ),
            ),
          )
      ),
    );
  }
}

class _PinCodeField extends StatelessWidget {
  final Function(String) onCodeChanged;

  const _PinCodeField({Key key, @required this.onCodeChanged}) :
        assert (onCodeChanged != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      onChanged: onCodeChanged,
      keyboardType: TextInputType.number,
      backgroundColor: Colors.transparent,
      pinTheme: PinTheme(
          borderRadius: BorderRadius.circular(8),
          shape: PinCodeFieldShape.box
      ),
      length: 6,
      appContext: context,

    );
  }
}