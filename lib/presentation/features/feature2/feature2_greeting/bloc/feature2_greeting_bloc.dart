import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'feature2_greeting_event.dart';
part 'feature2_greeting_state.dart';

final class Feature2GreetingBloc
    extends Bloc<Feature2GreetingEvent, Feature2GreetingState> {
  Feature2GreetingBloc({bool hasOnBoardingToken = false})
    : super(Feature2GreetingInitial()) {
    on<Feature2GreetingStarted>(_onFeature2GreetingStarted);
  }

  factory Feature2GreetingBloc.initialize({required bool hasOnboardingToken}) {
    return Feature2GreetingBloc(hasOnBoardingToken: hasOnboardingToken);
  }

  Future<void> _onFeature2GreetingStarted(
    Feature2GreetingStarted event,
    Emitter<Feature2GreetingState> emit,
  ) async {
    emit(Feature2GreetingStartSuccess());
  }
}
