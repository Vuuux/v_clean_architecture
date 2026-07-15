// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_bloc/flutter_bloc.dart';

class MultiBlocObserver extends BlocObserver {
  MultiBlocObserver(this._observers);

  final List<BlocObserver> _observers;

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    for (final observer in _observers) {
      observer.onCreate(bloc);
    }
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    for (final observer in _observers) {
      observer.onEvent(bloc, event);
    }
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    for (final observer in _observers) {
      observer.onChange(bloc, change);
    }
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    for (final observer in _observers) {
      observer.onTransition(bloc, transition);
    }
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    for (final observer in _observers) {
      observer.onError(bloc, error, stackTrace);
    }
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    for (final observer in _observers) {
      observer.onClose(bloc);
    }
  }
}
