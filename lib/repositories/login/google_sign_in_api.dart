import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:sham_mobile/models/gender.dart';
import 'package:sham_mobile/models/user.dart';
import 'sign_in_api.dart';

class GoogleSignInApi extends SignInApi {
  GoogleSignIn _googleSignIn;

  @override
  void signOut() async {
    _initializeGoogleSignInInstance();
    _googleSignIn.signOut();
  }

  @override
  Future<User> signIn() async {
    _initializeGoogleSignInInstance();
    await _googleSignIn.signOut();
    GoogleSignInAccount acc = await _googleSignIn.signIn();

    if(acc == null)
      return null;

    GoogleSignInAuthentication auth = await acc.authentication;

    String response = await _fetchAdditionalInfoFromGoogleAcc(
        accountId: acc.id,
        accessToken: auth.accessToken,
        headers: await _googleSignIn.currentUser.authHeaders);

    return _extractUserFromResponse(response)
      ..googleAccessToken = auth.accessToken;
  }

  void _initializeGoogleSignInInstance() async {
    if(_googleSignIn == null) {
      List<String> scopes = [
        'email',
        'https://www.googleapis.com/auth/userinfo.profile'
      ];
      _googleSignIn = GoogleSignIn(
          scopes: scopes
      );
    }
  }

  Future<String> _fetchAdditionalInfoFromGoogleAcc
      ({@required String accountId, @required String accessToken, @required headers}) async {
    final http.Response res = await http.get(
        'https://people.googleapis.com/v1/people/$accountId?'
            'personFields=birthdays,names,genders'
            '&access_token=$accessToken',
        headers: headers
    );
    return res.body;
  }

  User _extractUserFromResponse(String response) {
    try {
      User user = User();
      Map<String, dynamic> map = json.decode(response);
      print('google profile: --------------------------------');
      print(map.toString());
      user.firstName = map['names'][0]['givenName'];
      user.lastName = map['names'][0]['familyName'];
      user.birthday = _dateTimeFromGoogleProfileMap(map);
      user.gender = _genderFromGoogleProfileMap(map);
      return user;

    } catch(error) {
      throw error;
    }
  }

  DateTime _dateTimeFromGoogleProfileMap(Map<String, dynamic> profileMap) {
    Map<String, dynamic> dateMap = profileMap['birthdays'][0]['date'];
    return DateTime(
        dateMap['year'],
        dateMap['month'],
        dateMap['day']
    );
  }

  Gender _genderFromGoogleProfileMap(Map<String, dynamic> profileMap) {
    Map<String, dynamic> genderMap = profileMap['genders'][0];
    return GenderConverters.fromString(genderMap['value']);
  }

}