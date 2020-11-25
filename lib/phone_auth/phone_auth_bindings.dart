import 'package:get/get.dart';
import 'phone_auth_controller.dart';

class PhoneAuthBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(PhoneAuthController());
  }

}