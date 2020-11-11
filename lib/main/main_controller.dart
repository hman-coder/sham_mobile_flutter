import 'package:get/get.dart';
import 'package:sham_mobile/user/user_controller.dart';

class MainController extends GetxController{
  @override
  void onInit() {
    print('main on init');
    if(_isFirstAppStart()) {
      Get.toNamed('/login');
    }
    super.onInit();
  }

  bool _isFirstAppStart() =>
    Get.find<UserController>().user.id == 0;
}