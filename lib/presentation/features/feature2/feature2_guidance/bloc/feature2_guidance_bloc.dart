import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'feature2_guidance_event.dart';
part 'feature2_guidance_state.dart';

final class Feature2GuidanceBloc extends Bloc<Feature2GuidanceEvent, Feature2GuidanceState> {
  Feature2GuidanceBloc() : super(Feature2GuidanceInitial()) {
    on<Feature2GuidanceStarted>(_onFeature2GuidanceStarted);
  }

  factory Feature2GuidanceBloc.initialize() {
    return Feature2GuidanceBloc();
  }

  Future<void> _onFeature2GuidanceStarted(
    Feature2GuidanceStarted event,
    Emitter<Feature2GuidanceState> emit,
  ) async {
    emit(Feature2GuidanceStartSuccess());
  }
}
