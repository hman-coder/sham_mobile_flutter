import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:sham_mobile/controllers/loading_controller.dart';

class LoadingBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<LoadingController>(LoadingController());
  }
}