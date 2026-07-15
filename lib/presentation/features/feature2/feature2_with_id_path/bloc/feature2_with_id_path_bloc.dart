import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'feature2_with_id_path_event.dart';
part 'feature2_with_id_path_state.dart';

final class Feature2WithIdPathBloc
    extends Bloc<Feature2WithIdPathEvent, Feature2WithIdPathState> {
  Feature2WithIdPathBloc() : super(Feature2WithIdPathInitial()) {
    on<Feature2WithIdPathStarted>(_onFeature2WithIdPathStarted);
  }

  factory Feature2WithIdPathBloc.initialize({required String id}) {
    return Feature2WithIdPathBloc()..add(Feature2WithIdPathStarted(id: id));
  }

  Future<void> _onFeature2WithIdPathStarted(
    Feature2WithIdPathStarted event,
    Emitter<Feature2WithIdPathState> emit,
  ) async {
    emit(Feature2WithIdPathStartSuccess());
  }
}
