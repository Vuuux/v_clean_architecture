import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'feature1_event.dart';
part 'feature1_state.dart';

final class Feature1Bloc extends Bloc<Feature1Event, Feature2State> {
  Feature1Bloc() : super(Feature1Initial()) {
    on<Feature1Started>(_onFirstPageStarted);
  }

  factory Feature1Bloc.initialize() {
    return Feature1Bloc();
  }

  Future<void> _onFirstPageStarted(
    Feature1Started event,
    Emitter<Feature2State> emit,
  ) async {
    emit(Feature1Success());
  }
}
