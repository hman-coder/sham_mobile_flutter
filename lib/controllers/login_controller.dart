import 'package:get/get.dart';
import 'package:sham_mobile/repositories/login/login_repository.dart';
import 'package:sham_mobile/models/user.dart';
import 'package:sham_mobile/controllers/user_controller.dart';

class LoginController extends GetxController {
  var _isProcessing = false.obs;

  final LoginRepository _repository;

  LoginController(this._repository);

  bool get isProcessing => _isProcessing.value;

  void performGoogleSignIn() async {
    _isProcessing.value = true;
    try {
      User user = await _repository.fetchUserFromGoogleAccount();
      await _repository.registerUser(user);
      Get.find<UserController>().changeUser(user);
      Get.offNamed('/user/contact_info');

    } catch (error) {
      print(error);
    }
    _isProcessing.value = false;
  }

  void performFacebookSignIn() async {
    _isProcessing.value = true;
    try {
      User user = await _repository.fetchUserFromFacebookAccount();
      await _repository.registerUser(user);
      Get.find<UserController>().changeUser(user);
      Get.offNamed('/user/contact_info');

    } catch(error) {
      print(error);
    }
      _isProcessing.value = false;
  }

  void performPhoneSignIn() async {
    _isProcessing.value = true;
    var phoneNumber = await Get.toNamed('/phone_auth');
    if(phoneNumber != null) {
      User user = User(phoneNumber: phoneNumber);
      await _repository.registerUser(user);
      Get.find<UserController>().updatePhoneNumber(phoneNumber);
      Get.offNamed('/user/contact_info');
    }

    _isProcessing.value = false;

  }
}