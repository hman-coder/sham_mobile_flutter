import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:sham_mobile/loading/loading_controller.dart';

class LoadingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoadingController());
  }
}