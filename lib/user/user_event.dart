class UserEvent {}

class LoginWithGoogleAccount extends UserEvent {
  final String token;

  LoginWithGoogleAccount(this.token);
}

class LoginWithFacebookAccount extends UserEvent {
  final String token;

  LoginWithFacebookAccount(this.token);
}

class LoginWithPhoneNumber extends UserEvent {
  final String phoneNumber;

  LoginWithPhoneNumber(this.phoneNumber);
}


