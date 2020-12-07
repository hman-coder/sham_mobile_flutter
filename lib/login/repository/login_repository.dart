import 'package:sham_mobile/models/user.dart';
import 'login_api_barrel.dart';

class LoginRepository {
  Future<User> fetchUserFromGoogleAccount() async {
    GoogleSignInApi api = GoogleSignInApi();
    return await api.signIn();
  }

  Future<User> fetchUserFromFacebookAccount() async {
    FacebookSignInApi api = FacebookSignInApi();
    return await api.signIn();
  }

  Future<bool> registerUser(User user) async {
    await Future.delayed(Duration(seconds: 4));
    print('User virtually registered: ');
    print(user.toString());
    return true;
  }
}



