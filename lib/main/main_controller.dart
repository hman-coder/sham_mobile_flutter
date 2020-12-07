import 'package:get/get.dart';
import 'package:sham_mobile/user/user_controller.dart';

class MainController extends GetxController{
  @override
  void onInit() {
    print('main on init');
    if(_isFirstAppStart()) {
      print('first time');
      Future.delayed(3.seconds).then((value) => Get.toNamed('/login'));
    }
    super.onInit();
  }

  bool _isFirstAppStart() =>
    Get.find<UserController>().user?.id == null
        || Get.find<UserController>().user.id == 0;
}