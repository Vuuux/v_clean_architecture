import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_clean_architecture/presentation/features/feature2/feature2_landing/bloc/feature2_landing_bloc.dart';
import 'package:v_clean_architecture/presentation/features/feature2/feature2_landing/feature2_landing_screen.dart';

final class Feature2LandingPageArguments {
  Feature2LandingPageArguments();
}

final class Feature2LandingPage extends StatelessWidget {
  const Feature2LandingPage({
    super.key,
    this.arguments,
  });

  final Feature2LandingPageArguments? arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Feature2LandingBloc.initialize(),
      child: const Feature2LandingScreen(),
    );
  }
}
