import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'feature2_event.dart';
part 'feature2_state.dart';

final class Feature2Bloc extends Bloc<Feature2Event, Feature2State> {
  Feature2Bloc() : super(Feature2Initial()) {
    on<Feature2Started>(_onSecondPageStarted);
  }

  factory Feature2Bloc.initialize() {
    return Feature2Bloc();
  }

  Future<void> _onSecondPageStarted(
    Feature2Started event,
    Emitter<Feature2State> emit,
  ) async {
    emit(Feature2Success());
  }
}
