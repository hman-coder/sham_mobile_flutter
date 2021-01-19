import 'package:get/get.dart';
import 'package:sham_mobile/controllers/books_controller.dart';
import 'package:sham_mobile/controllers/user_controller.dart';

class MainController extends GetxController{
  @override
  void onInit() {
    Get.put(BooksController(), permanent: true);
    super.onInit();
  }


  @override
  void onReady() {
    super.onReady();
    if(_isFirstAppStart()) {
      print('first time');
      Get.toNamed('/login');
    }
  }

  bool _isFirstAppStart() =>
    Get.find<UserController>().user?.id == null
        || Get.find<UserController>().user.id == 0;
}