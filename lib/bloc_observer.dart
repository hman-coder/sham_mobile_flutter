import 'package:flutter_bloc/flutter_bloc.dart';

class ShamBlocObserver extends BlocObserver {

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print("bloc (${bloc.toString()}) onEvent: $event");
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    super.onError(cubit, error, stackTrace);
    print("cubit (${cubit.toString()}) onError: $stackTrace");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print("bloc (${bloc.toString()}) onTransition: $transition");
  }

  @override
  void onChange(Cubit cubit, Change change) {
    super.onChange(cubit, change);
    print("cubit (${cubit.toString()}) onChange: ${change.toString()}");
  }
}