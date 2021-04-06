import 'package:get/get.dart';
import 'package:sham_mobile/controllers/sham_controller.dart';
import 'package:sham_mobile/repositories/login/login_repository.dart';
import 'package:sham_mobile/models/user.dart';
import 'package:sham_mobile/controllers/user_controller.dart';

class LoginController extends ShamController {
  final LoginRepository _repository;

  LoginController(this._repository);

  void performGoogleSignIn() async {
    isLoading = true;
    try {
      User user = await _repository.fetchUserFromGoogleAccount();
      await _repository.registerUser(user);
      Get.find<UserController>().changeUser(user);
      Get.offNamed('/user/contact_info');

    } catch (error) {
      print(error);
    }
    isLoading = false;
  }

  void performFacebookSignIn() async {
    isLoading = true;
    try {
      User user = await _repository.fetchUserFromFacebookAccount();
      await _repository.registerUser(user);
      Get.find<UserController>().changeUser(user);
      Get.offNamed('/user/contact_info');

    } catch(error) {
      print(error);
    }
      isLoading = false;
  }

  void performPhoneSignIn() async {
    isLoading = true;
    var phoneNumber = await Get.toNamed('/phone_auth');
    if(phoneNumber != null) {
      User user = User(phoneNumber: phoneNumber);
      await _repository.registerUser(user);
      Get.find<UserController>().updatePhoneNumber(phoneNumber);
      Get.offNamed('/user/contact_info');
    }

    isLoading = false;

  }
}