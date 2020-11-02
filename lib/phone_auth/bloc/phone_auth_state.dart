import 'package:country_pickers/country.dart';

class PhoneAuthState {}

class InitialState extends PhoneAuthState{
  final Country country;

  InitialState(this.country);
}

class CountryChangedState extends PhoneAuthState {
  final Country country;

  CountryChangedState(this.country);
}

class EmptyPhoneNumberState extends PhoneAuthState{}

class CodeSentState  extends PhoneAuthState {}

class SendingCodeState extends PhoneAuthState {}

class NetworkErrorState extends PhoneAuthState {}

class UnknownErrorState extends PhoneAuthState {}

class ValidatingCodeState extends PhoneAuthState {}

class CodeValidatedState extends PhoneAuthState {}

class InvalidCodeState extends PhoneAuthState {}