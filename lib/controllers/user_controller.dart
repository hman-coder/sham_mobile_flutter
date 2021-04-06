import 'package:get/get.dart';
import 'package:sham_mobile/controllers/sham_controller.dart';
import 'package:sham_mobile/models/address.dart';
import 'package:sham_mobile/models/gender.dart';
import 'package:sham_mobile/ui/dialogs/sign_up_alert_dialog.dart';
import 'package:sham_mobile/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends ShamController{
  final String _userIdSharedPreferencesKey = 'user_id';

  var _obsUser = User().obs;

  User get user => _obsUser.value;

  bool get isUserLoggedIn => true;
      // user.id != null && user.id != 0;

  bool get hasCompletedContactInfo => true;
      // isUserLoggedIn
      //     && ! user.phoneNumber.isNullOrBlank
      //     && ! user.firstName.isNullOrBlank
      //     && ! ( (user.address?.summary).isNullOrBlank);

  /// Checks if the user is eligible for services (delivering books, etc)
  Future<bool> get eligibleForServices async {
    // Check if user is signed in
    if(await _checkAndRequireSignIn())

      // Check if contact info is filled
      if(await _checkAndRequireContactInfo())
        return true;

    return false;
  }

  /// shows a login dialog if needed
  Future<bool> _checkAndRequireSignIn() async {
    if(! isUserLoggedIn)
      await Get.dialog(SignUpAlertDialog());

    return isUserLoggedIn;
  }

  Future<bool> _checkAndRequireContactInfo() async {
    if(! hasCompletedContactInfo)
      await Get.dialog(ContactInfoAlertDialog());

    return hasCompletedContactInfo;
}

  @override
  void onInit() {
    super.onInit();
    _initializeUser();
  }

  void _initializeUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int userId = sp.getInt(_userIdSharedPreferencesKey) ?? 0;
    _obsUser.update((val) {
      val.id = userId;
      val.image = "assets/images/hisham.png";
    });
  }

  listenToUserChanges(Function(User) onUpdated) {
    _obsUser.listen(onUpdated);
  }

  updatePhoneNumber(String value) {
    _obsUser.update((user) => user.phoneNumber = value);
  }

  updatePersonalInfo(String firstName, String lastName) {
    _obsUser.update((user) {
      if(firstName.isNotEmpty) user.firstName = firstName;
      if(lastName.isNotEmpty) user.lastName = lastName;
    });
  }

  updateAddress(Address address) {
    _obsUser.update((user) => user.address = address);
  }

  updateAccessTokens({String googleAccessToken, String facebookAccessToken}) {
    assert (googleAccessToken != null && facebookAccessToken != null,
    'You should provide at least one access token to update');

    _obsUser.update((user) {
      if(googleAccessToken != null) user.googleAccessToken = googleAccessToken;
      if(facebookAccessToken != null) user.facebookAccessToken = facebookAccessToken;
    });
  }

  updateOtherInfo({String email, DateTime birthday, Gender gender}) {
    assert(email != null && birthday != null && gender != null,
    'You should provide at least one parameter to update');

    _obsUser.update((user) {
      if(email != null) user.email = email;
      if(birthday != null) user.birthday = birthday;
      if(gender != null) user.gender = gender;
    });
  }

  changeUser(User newUser) {

    // TODO: Remove this line when testing is finished
    newUser.id = newUser.id != null && newUser.id == 0 ? 1 : newUser.id;

    _obsUser.value = newUser;
  }
}