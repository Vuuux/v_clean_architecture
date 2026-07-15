import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'feature3_event.dart';
part 'feature3_state.dart';

final class Feature3Bloc extends Bloc<Feature3Event, Feature3State> {
  Feature3Bloc() : super(Feature3Initial()) {
    on<Feature3Started>(_onFeature3Started);
  }

  factory Feature3Bloc.initialize() {
    return Feature3Bloc();
  }

  Future<void> _onFeature3Started(
    Feature3Started event,
    Emitter<Feature3State> emit,
  ) async {
    emit(Feature3StartSuccess());
  }
}
