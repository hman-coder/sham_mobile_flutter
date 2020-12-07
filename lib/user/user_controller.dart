import 'package:get/get.dart';
import 'package:sham_mobile/models/address.dart';
import 'package:sham_mobile/models/gender.dart';

import 'package:sham_mobile/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController{
  final String _userIdSharedPreferencesKey = 'user_id';

  var _obsUser = User().obs;

  User get user => _obsUser.value;

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

  changeUser(User user) {
    _obsUser.value = user;
  }
}