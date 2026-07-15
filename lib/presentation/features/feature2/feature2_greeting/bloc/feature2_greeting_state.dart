part of 'feature2_greeting_bloc.dart';

abstract class Feature2GreetingState extends Equatable {
  const Feature2GreetingState();

  @override
  List<Object?> get props => [];
}

class Feature2GreetingInitial extends Feature2GreetingState {}

class Feature2GreetingStartSuccess extends Feature2GreetingState {}
