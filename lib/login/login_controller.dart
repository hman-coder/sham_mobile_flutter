import 'package:get/get.dart';
import 'package:sham_mobile/login/repository/login_repository.dart';
import 'package:sham_mobile/models/user.dart';

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
    String _phoneNumber = await Get.toNamed('/phone_auth');

    if(_phoneNumber != null)
      Get.offNamed('/contact_info');
  }
}