import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'loader_event.dart';
part 'loader_state.dart';

class LoaderBloc extends Bloc<LoaderEvent, LoaderState> {
  LoaderBloc() : super(LoaderInitial()) {
    on<LoaderStarted>(_onLoaderStarted);
    on<LoaderStopped>(_onLoaderStopped);
  }

  factory LoaderBloc.initialize() {
    return LoaderBloc();
  }

  Future<void> _onLoaderStarted(
    LoaderStarted event,
    Emitter<LoaderState> emit,
  ) async {
    if (state is! LoaderStartSuccess) {
      emit(LoaderStartSuccess());
    }
  }

  Future<void> _onLoaderStopped(
    LoaderStopped event,
    Emitter<LoaderState> emit,
  ) async {
    if (state is! LoaderStopSuccess) {
      emit(LoaderStopSuccess());
    }
  }
}

mixin LoaderMixin<W extends StatefulWidget> on State<W> {
  void showLoader() {
    context.read<LoaderBloc>().add(LoaderStarted());
  }

  void hideLoader() {
    context.read<LoaderBloc>().add(LoaderStopped());
  }
}

extension LoaderExtension on BuildContext {
  void showLoader() {
    read<LoaderBloc>().add(LoaderStarted());
  }

  void hideLoader() {
    read<LoaderBloc>().add(LoaderStopped());
  }
}
