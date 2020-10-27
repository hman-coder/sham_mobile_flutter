import 'package:flutter/foundation.dart';
import 'package:sham_mobile/models/user.dart';

class LoginState {}

class LoadingState extends LoginState {}

class NetworkErrorState extends LoginState {}

class NullUserState extends LoginState {}

class InitialState extends LoginState {}

class UnknownErrorState extends LoginState {}

class UserAuthenticatedState extends LoginState{
  final User user;

  UserAuthenticatedState(this.user);
}