import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_clean_architecture/presentation/features/splash/bloc/splash_bloc.dart';
import 'package:v_clean_architecture/presentation/features/splash/splash_screen.dart';

final class SplashPageArguments {
  SplashPageArguments();
}

final class SplashPage extends StatelessWidget {
  const SplashPage({
    super.key,
    this.arguments,
  });

  final SplashPageArguments? arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc.initialize(),
      child: const SplashScreen(),
    );
  }
}
