import 'package:get/get.dart';
import 'package:sham_mobile/controllers/contact_info_controller.dart';

class ContactInfoBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ContactInfoController());
  }

}