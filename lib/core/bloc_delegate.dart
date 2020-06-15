import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition.toString());
    super.onTransition(bloc, transition);
  }
}