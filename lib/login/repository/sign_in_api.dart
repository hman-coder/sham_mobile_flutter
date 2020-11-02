import 'package:sham_mobile/login/repository/google_sign_in_api.dart';
import 'facebook_sign_in_api.dart';
import 'package:sham_mobile/models/user.dart';

/// Defines the methods that a login method should use.
/// Check [FacebookSignInApi] and [GoogleSignInApi].
abstract class SignInApi {
  Future<User> signIn();

  void signOut();
}