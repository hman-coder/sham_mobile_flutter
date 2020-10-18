import 'dart:async';
import 'dart:developer';

import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'phone_auth_event.dart';
import 'phone_auth_state.dart';

class PhoneAuthBloc extends Bloc<PhoneAuthEvent, PhoneAuthState> {
  static final String _logTag = "sham.phone_auth_bloc";

  Country selectedCountry;
  String phoneNumber;

  String verificationId;

  PhoneAuthBloc() :
        selectedCountry = CountryPickerUtils.getCountryByIsoCode('sy'),
        super(InitialState());

  @override
  Stream<PhoneAuthState> mapEventToState(PhoneAuthEvent event) async* {
    if(event is PhoneNumberChangedEvent) _handlePhoneNumberChangedEvent(event);
    else if(event is CountrySelectedEvent) yield _handleCountryChangedEvent(event);
    else if(event is PhoneNumberSubmittedEvent) yield* _handlePhoneNumberSubmittedEvent(event);
    else if (event is CodeSubmittedEvent) yield* _handleCodeSubmittedEvent(event);
  }

  void _handlePhoneNumberChangedEvent(PhoneNumberChangedEvent event) {
    phoneNumber = event.number;
  }

  PhoneAuthState _handleCountryChangedEvent(CountrySelectedEvent event) {
    selectedCountry = event.country;
    log("Selected country changed. New country code: ${selectedCountry.phoneCode}");
    return CountryChangedState();
  }

  Stream<PhoneAuthState> _handlePhoneNumberSubmittedEvent(PhoneNumberSubmittedEvent event) async*{
    if(phoneNumber == null || phoneNumber.isEmpty)
      yield EmptyPhoneNumberState();

    else {
      yield SendingCodeState();


      log("Starting verification", name: _logTag);
      await Firebase.initializeApp();
      var firebaseAuth = FirebaseAuth.instance;

      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: _buildPhoneNumber(),
        timeout: Duration(seconds: 0),
        verificationCompleted: (firebaseUser) {},
        codeAutoRetrievalTimeout: (String verificationId) {},

        codeSent: (id, [forceResendingToken]) =>
          emit(_handleVerificationIdReceived(id, forceResendingToken)),

        verificationFailed: (error) =>
          emit(_handleVerificationIdRetrievalError(error)),
      );
    }
  }

  String _buildPhoneNumber() {
    String countryCode = selectedCountry.phoneCode.replaceAll('-', '');
    String number = this.phoneNumber;
    while(number.startsWith('0')) {
      print('loop');
      number = number.replaceFirst('0', '');
    }

    final String finalNumber = '+$countryCode$number';
    log('Final phone number: $finalNumber', name: _logTag);

    return finalNumber;
  }

  PhoneAuthState _handleVerificationIdReceived(String id, [forceResendingToken]) {
    this.verificationId = id;
    log("Received verification id: $id", name: _logTag);
    return CodeSentState();
  }

  PhoneAuthState _handleVerificationIdRetrievalError(FirebaseAuthException error) {
    log('An error has occurred: $error', name: _logTag, level: 2);
    if(error != null && (error?.plugin != null)) {
      if (error.code == "network-request-failed") return NetworkErrorState();
      return UnknownErrorState();
    }

    return null;
  }

  Stream<PhoneAuthState> _handleCodeSubmittedEvent(CodeSubmittedEvent event) async*{
    yield ValidatingCodeState();

    AuthCredential a = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: event.code
    );

    try {
      var firebaseAuth = FirebaseAuth.instance;
      var s = await firebaseAuth.signInWithCredential(a);

      yield CodeValidatedState();

    } catch(error) {
      if(error is FirebaseAuthException)
        yield InvalidCodeState();
      else {
        yield UnknownErrorState();
      }
    }
  }

}
