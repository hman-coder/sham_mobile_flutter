import 'package:get/get.dart';
import 'package:sham_mobile/user/user_controller.dart';
import 'package:sham_mobile/models/user.dart';

class ContactInfoController extends GetxController {
  var _phoneNumberAuthenticated = true.obs;

  var _personalInfoGiven = false.obs;

  var _addressGiven = false.obs;

  bool get isPhoneNumberAuthenticated => _phoneNumberAuthenticated.value;

  bool get isPersonalInfoGiven => _personalInfoGiven.value;

  bool get isAddressGiven => _addressGiven.value;

  @override
  void onInit() {
    _bindToUserController();
    super.onInit();
  }

  _bindToUserController() {
    UserController controller = Get.find<UserController>();
    _updateStateAccordingToUser(controller.user);
    controller.listenToUserChanges(_updateStateAccordingToUser);
  }

  _updateStateAccordingToUser(User user) {
    _phoneNumberAuthenticated.value = user.phoneNumber != null;
    _personalInfoGiven.value = user.firstName != null;
    _addressGiven.value = user.address != null;
  }

}