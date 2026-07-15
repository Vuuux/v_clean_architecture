part of 'profile_bloc.dart';

abstract class ProfileEvent {
  const ProfileEvent();
}

class ProfileStarted extends ProfileEvent {
  ProfileStarted();
}
