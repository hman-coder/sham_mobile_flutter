import 'package:get/get.dart';
import 'package:sham_mobile/controllers/login_controller.dart';
import 'package:sham_mobile/repositories/login/login_repository.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(LoginController(LoginRepository()));
  }

}