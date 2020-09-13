import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham_mobile/blocs/loading/loading_event.dart';
import 'package:sham_mobile/blocs/loading/loading_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  static final String _introShownKey = 'intro_shown';

  LoadingBloc() : super(InitialState());

  @override
  Stream<LoadingState> mapEventToState(LoadingEvent event) async* {
    yield* checkIfIntroWasShown();
  }

  Stream<LoadingState> checkIfIntroWasShown() async* {
    await Future.delayed(Duration(seconds: 2));
    SharedPreferences.setMockInitialValues(new Map<String, dynamic>());
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool introShown = preferences.containsKey(_introShownKey);
    if(introShown) {
      yield IntroAlreadyShownState();

    } else {
      await preferences.setBool(_introShownKey, true);
      yield IntroNotShownState();
    }
  }

}