import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    print("Creating bloc :\n" + bloc.toString());
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    print('$event');
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    print('$change');
    super.onChange(bloc, change);
  }

  @override
  void onClose(BlocBase bloc) {
    print("Closed bloc :" + bloc.toString());
    super.onClose(bloc);
  }

  // @override
  // void onTransition(Bloc bloc, Transition transition) {
  //   super.onTransition(bloc, transition);
  //   print(transition);
  // }

  // @override
  // void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
  //   print(error);
  //   super.onError(bloc, error, stackTrace);
  // }
}
