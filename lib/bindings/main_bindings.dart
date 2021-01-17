import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:sham_mobile/controllers/main_controller.dart';

class MainBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(MainController());
  }

}