import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_clean_architecture/presentation/features/feature2/feature2_greeting/bloc/feature2_greeting_bloc.dart';
import 'package:v_clean_architecture/presentation/features/feature2/feature2_greeting/feature2_greeting_screen.dart';

final class Feature2GreetingPageArguments {
  Feature2GreetingPageArguments({
    this.hasOnboardingToken = false,
  });

  final bool hasOnboardingToken;
}

final class Feature2GreetingPage extends StatelessWidget {
  const Feature2GreetingPage({
    super.key,
    this.arguments,
  });

  final Feature2GreetingPageArguments? arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Feature2GreetingBloc.initialize(
        hasOnboardingToken: arguments?.hasOnboardingToken ?? false,
      ),
      child: const Feature2GreetingScreen(),
    );
  }
}
