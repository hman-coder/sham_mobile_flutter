import 'package:get/get.dart';
import 'contact_info_controller.dart';

class ContactInfoBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ContactInfoController());
  }

}