import 'package:get/get.dart';
import 'package:sham_mobile/controllers/family_info_controller.dart';

class FamilyInfoBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FamilyInfoController());
  }

}