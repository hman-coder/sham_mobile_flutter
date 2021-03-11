import 'package:get/get.dart';
import 'package:sham_mobile/controllers/contact_us_controller.dart';

class ContactUsBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ContactUsController());
  }

}