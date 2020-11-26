import 'package:get/get.dart';

import 'package:sham_mobile/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController{
  final String _userIdSharedPreferencesKey = 'user_id';

  var obsUser = User().obs;

  User get user => obsUser.value;

  @override
  void onInit() {
    super.onInit();
    _initializeUser();
  }

  void _initializeUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int userId = sp.getInt(_userIdSharedPreferencesKey) ?? 0;
    obsUser.update((val) {
      val.id = userId;
    });
  }
}