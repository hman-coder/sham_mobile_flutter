import 'dart:convert';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:sham_mobile/models/gender.dart';
import 'package:sham_mobile/models/user.dart';
import 'package:sham_mobile/repositories/login/sign_in_api.dart';
import 'package:http/http.dart' as http;

class FacebookSignInApi extends SignInApi{
  FacebookLogin _facebookLogin;
  @override
  void signOut() async {
    await _initializeFacebookLoginInstance();
    _facebookLogin.logOut();
  }

  @override
  Future<User> signIn() async {
    try {
      _initializeFacebookLoginInstance();
      await _facebookLogin.logOut();
      final facebookLoginResult = await _performLoginWithScopes();
      http.Response response = await _requestAdditionProfileInfo(facebookLoginResult);
      return _extractUserFromResponse(response)
        ..facebookAccessToken = facebookLoginResult.accessToken.token;

    } catch(error) {
      throw error;
    }
  }

  void _initializeFacebookLoginInstance() {
    if(_facebookLogin == null) _facebookLogin = FacebookLogin();
  }

  Future<FacebookLoginResult> _performLoginWithScopes() async {
    List<String> scopes = ['email', 'user_birthday', 'user_gender'];
    return await _facebookLogin.logIn(scopes);
  }

  Future<http.Response> _requestAdditionProfileInfo(FacebookLoginResult result) async {
    final token = result.accessToken.token;
    return await http.get(
        'https://graph.facebook.com/v2.12/me?'
            'fields=first_name,last_name,address,birthday,email,gender'
            '&access_token=$token');
  }

  User _extractUserFromResponse(http.Response response) {
    try {
      User user = User();
      final Map<String, dynamic> profile = json.decode(response.body);
      print('facebook profile: --------------------------------');
      print(profile.toString());
      user.firstName = profile['first_name'];
      user.lastName = profile['last_name'];
      user.gender = GenderConverters.fromString(profile['gender']);
      user.birthday = _dateTimeFromFacebookBirthday(profile['birthday']);

      return user;
    } catch (error) {
      throw error;
    }
  }

  DateTime _dateTimeFromFacebookBirthday(String formattedString) {
    String month = formattedString.substring(0,2);
    String day = formattedString.substring(3,5);
    String year = formattedString.substring(6);

    return DateTime.parse(year + month + day);
  }
}