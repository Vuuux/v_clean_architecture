part of 'loader_bloc.dart';

abstract class LoaderState extends Equatable {
  const LoaderState();

  @override
  List<Object> get props => [];
}

class LoaderInitial extends LoaderState {}

class LoaderStartSuccess extends LoaderState {}

class LoaderStopSuccess extends LoaderState {}
