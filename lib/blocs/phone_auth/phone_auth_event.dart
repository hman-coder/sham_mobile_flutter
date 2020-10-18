import 'package:country_pickers/country.dart';

class PhoneAuthEvent {}

class CountrySelectedEvent  extends PhoneAuthEvent{
  final Country country;

  CountrySelectedEvent(this.country);
}

class PhoneNumberChangedEvent extends PhoneAuthEvent {
  final String number;

  PhoneNumberChangedEvent(this.number);
}

class PhoneNumberSubmittedEvent extends PhoneAuthEvent {}

class CodeSubmittedEvent extends PhoneAuthEvent {
  final String code;

  CodeSubmittedEvent(this.code);
}
