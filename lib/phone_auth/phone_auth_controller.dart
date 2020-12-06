import 'dart:developer';

import 'package:country_pickers/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:country_pickers/country.dart';
import 'package:sham_mobile/error/error_controller.dart';
import 'package:sham_mobile/phone_auth/phone_auth_pin_dialog.dart';

class PhoneAuthController extends GetxController {
  static final String  _logTag = "phone_auth_controller";

  // vars ----------------------------------------
  var _phoneNumber = ''.obs;

  var _country = Country().obs;

  var _state = _PhoneAuthState.none.obs;

  // getters --------------------------------------

  String get phoneNumber => _phoneNumber.value;

  Country get country => _country.value;

  bool get isSendingCode => _state.value == _PhoneAuthState.sending_pin_code;

  bool get isValidatingPinCode => _state.value == _PhoneAuthState.validating_pin_code;

  bool get isPinCodeInvalid => _state.value == _PhoneAuthState.invalid_pin_code;

  // setters
  set phoneNumber(String number) {
    _phoneNumber.value = number;
  }

  set country(Country country) => _country.value = country;

  // overridden methods ---------------------------

  @override
  void onInit() {
    _country = CountryPickerUtils.getCountryByIsoCode('sy').obs;
    super.onInit();
  }

  // inner methods --------------------------------

  submitPhoneNumber() async {
    _state.value = _PhoneAuthState.validating_phone_number;

    _state.value = _PhoneAuthState.sending_pin_code;
    await Firebase.initializeApp();
    var firebaseAuth = FirebaseAuth.instance;

    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: _buildFullPhoneNumber(),
      timeout: Duration(seconds: 0),
      verificationCompleted: (firebaseUser) {},
      codeAutoRetrievalTimeout: (String verificationId) {},

      codeSent: _handleVerificationIdReceived,

      verificationFailed: _handleVerificationIdRetrievalError,
    );
  }

  String _buildFullPhoneNumber() {
    String countryCode = _country.value.phoneCode.replaceAll('-', '');
    String number = _phoneNumber.value;
    while(number.startsWith('0')) {
      print('loop');
      number = number.replaceFirst('0', '');
    }

    String fullPhoneNumber = '+$countryCode$number';
    log('Final phone number: $fullPhoneNumber', name: _logTag);

    return fullPhoneNumber;
  }

  String _verificationId;

  _handleVerificationIdReceived(String id, [forceResendingToken]) async {
    _verificationId = id;
    log("Received verification id: $id", name: _logTag);

    _state.value = _PhoneAuthState.none;

    Get.dialog(PhoneAuthPinVerificationDialog(), barrierDismissible: false);
  }

  _handleVerificationIdRetrievalError(FirebaseAuthException error) {
    _state.value = _PhoneAuthState.none;
    log('An error has occurred: $error', name: _logTag, level: 2);
    if(error != null && (error?.plugin != null)) {
      if (error.code == "network-request-failed")
        Get.find<ShamErrorController>().showError(
            ShamError(
              displayType: ErrorDisplayType.snackbar,
              message: 'No internet connection',
              severity: ErrorSeverity.mild,
            )
        );

      else
        Get.find<ShamErrorController>().showUnknownError();
    }
  }

  submitPinCode(String pinCode) async {
    _state.value = _PhoneAuthState.validating_pin_code;

    AuthCredential a = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: pinCode
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(a);

      Get.back(
          result: _buildFullPhoneNumber(),
          closeOverlays: true
      );

    } catch(error) {
      if(error is FirebaseAuthException) {
        _state.value = _PhoneAuthState.invalid_pin_code;
        Get.find<ShamErrorController>().showError(
            ShamError(
                message: 'invalid_code'.tr,
                severity: ErrorSeverity.moderate,
                displayType: ErrorDisplayType.dialog
            )
        );
      }

      else {
        _state.value = _PhoneAuthState.none;
        Get.find<ShamErrorController>().showUnknownError();
      }
    }
  }
}

enum _PhoneAuthState {
  none,
  validating_phone_number,
  validating_pin_code,
  invalid_pin_code,
  sending_pin_code
}