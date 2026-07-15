import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_clean_architecture/presentation/features/profile/bloc/profile_bloc.dart';
import 'package:v_clean_architecture/presentation/features/profile/profile_screen.dart';

final class ProfilePageArguments {
  ProfilePageArguments();
}

final class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
    this.arguments,
  });

  final ProfilePageArguments? arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc.initialize(),
      child: const ProfileScreen(),
    );
  }
}
