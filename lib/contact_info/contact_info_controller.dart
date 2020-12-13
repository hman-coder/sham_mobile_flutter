import 'package:get/get.dart';
import 'package:sham_mobile/contact_info/address_ui.dart';
import 'package:sham_mobile/user/user_controller.dart';
import 'package:sham_mobile/models/user.dart';
import 'personal_info_ui.dart';

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

  onPhoneNumberPressed() async {
    var phoneNumber = await Get.toNamed('/phone_auth');
    print(phoneNumber);
    if(phoneNumber != null && phoneNumber.isNotEmpty) {
      Get.find<UserController>().updatePhoneNumber(phoneNumber);
    }
  }

  onPersonalInfoPressed() async {
    UserController userController = Get.find<UserController>();

    var personalInfo = await Get.to(PersonalInfoUI(
      firstName: userController.user.firstName,
      lastName: userController.user.lastName,
    ));

    if(personalInfo != null)
      Get.find<UserController>()
          .updatePersonalInfo(personalInfo[0], personalInfo[1]);
  }

  onAddressPressed() async {
    var address = await Get.to(AddressUI());
    if(address != null) {
      Get.find<UserController>()
          .updateAddress(address);
    }
  }

}