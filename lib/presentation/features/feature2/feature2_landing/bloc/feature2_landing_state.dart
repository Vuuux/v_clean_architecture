part of 'feature2_landing_bloc.dart';

abstract class Feature2LandingState extends Equatable {
  const Feature2LandingState();

  @override
  List<Object?> get props => [];
}

class Feature2LandingInitial extends Feature2LandingState {}

class Feature2LandingStartSuccess extends Feature2LandingState {}
