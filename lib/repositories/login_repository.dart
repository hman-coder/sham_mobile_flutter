import 'package:sham_mobile/models/user.dart';
import 'package:sham_mobile/repositories/login/login_api_barrel.dart';

class LoginRepository {
  Future<User> fetchUserFromGoogleAccount() async {
    GoogleSignInApi api = GoogleSignInApi();
    return await api.signIn();
  }

  Future<User> fetchUserFromFacebookAccount() async {
    FacebookSignInApi api = FacebookSignInApi();
    return await api.signIn();
  }

}



