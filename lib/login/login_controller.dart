import 'package:get/get.dart';
import 'package:sham_mobile/login/repository/login_repository.dart';
import 'package:sham_mobile/models/user.dart';
import 'package:sham_mobile/user/user_controller.dart';

class LoginController extends GetxController {
  var _isProcessing = false.obs;

  final LoginRepository _repository;

  LoginController(this._repository);

  bool get isProcessing => _isProcessing.value;

  void performGoogleSignIn() async {
    _isProcessing.value = true;
    try {
      User user = await _repository.fetchUserFromGoogleAccount();

    } catch (error) {
      print(error);
    }
    _isProcessing.value = false;
  }

  void performFacebookSignIn() async {
    _isProcessing.value = true;
    try {
      User user = await _repository.fetchUserFromFacebookAccount();
    } catch(error) {
      print(error);
    }
      _isProcessing.value = false;
  }

  void performPhoneSignIn() async {
    _isProcessing.value = true;
    var phoneNumber = await Get.toNamed('/phone_auth');
    if(phoneNumber != null) {
      await Get.find<UserController>().updatePhoneNumber(phoneNumber);
      Get.offNamed('/contact_info');
    }

    _isProcessing.value = false;

  }
}