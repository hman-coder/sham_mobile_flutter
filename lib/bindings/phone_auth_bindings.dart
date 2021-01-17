import 'package:get/get.dart';
import 'package:sham_mobile/controllers/phone_auth_controller.dart';

class PhoneAuthBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(PhoneAuthController());
  }

}