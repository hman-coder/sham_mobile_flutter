import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham_mobile/models/user.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  User _user;

  User get user => _user;

  UserBloc() :
        _user = User(),
        super(InitialState());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is LoginWithFacebookAccount) yield null;
    else if(event is LoginWithGoogleAccount) yield null;
    else if (event is LoginWithPhoneNumber) yield* _handleLoginWithPhoneNumber(event.phoneNumber);
  }

  Stream<UserState> _handleLoginWithPhoneNumber(String phoneNumber) {

  }
}