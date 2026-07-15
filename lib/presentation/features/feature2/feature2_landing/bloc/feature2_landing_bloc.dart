import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'feature2_landing_event.dart';
part 'feature2_landing_state.dart';

final class Feature2LandingBloc extends Bloc<Feature2LandingEvent, Feature2LandingState> {
  Feature2LandingBloc() : super(Feature2LandingInitial()) {
    on<Feature2LandingStarted>(_onFeature2LandingStarted);
  }

  factory Feature2LandingBloc.initialize() {
    return Feature2LandingBloc();
  }

  Future<void> _onFeature2LandingStarted(
    Feature2LandingStarted event,
    Emitter<Feature2LandingState> emit,
  ) async {
    emit(Feature2LandingStartSuccess());
  }
}
