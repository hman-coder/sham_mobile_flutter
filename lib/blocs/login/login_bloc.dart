import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham_mobile/models/user.dart';
import 'package:sham_mobile/repositories/login_repository.dart';
import 'login_state.dart';
import 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _repository;

  LoginBloc() :
        _repository = LoginRepository(),
        super(InitialState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is GoogleSignInRequested) {yield* _handleSocialSignInRequest(event);}
    else if (event is FacebookSignInRequested) {yield* _handleSocialSignInRequest(event);}
    else if (event is PhoneSignInRequested) yield InitialState();
  }

  Stream<LoginState> _handleSocialSignInRequest(LoginEvent event) async* {
    yield LoadingState();

    try {
      User user = event is GoogleSignInRequested
          ? await _repository.fetchUserFromGoogleAccount()
          : await _repository.fetchUserFromFacebookAccount();
      if(user == null) yield NullUserState();
      else yield UserAuthenticatedState(user);

    }  catch(error) {
      if(error is PlatformException && error.code == "network_error")
        yield NetworkErrorState();

      else {
        print(error);
        yield UnknownErrorState();
      }
    }
  }
}