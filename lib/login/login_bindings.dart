import 'package:get/get.dart';
import 'package:sham_mobile/login/login_controller.dart';
import 'package:sham_mobile/login/repository/login_repository.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(LoginController(LoginRepository()));
  }

}