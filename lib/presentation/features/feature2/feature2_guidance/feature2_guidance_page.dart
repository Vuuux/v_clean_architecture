import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_clean_architecture/presentation/features/feature2/feature2_guidance/bloc/feature2_guidance_bloc.dart';
import 'package:v_clean_architecture/presentation/features/feature2/feature2_guidance/feature2_guidance_screen.dart';

final class Feature2GuidancePageArguments {
  Feature2GuidancePageArguments();
}

final class Feature2GuidancePage extends StatelessWidget {
  const Feature2GuidancePage({
    super.key,
    this.arguments,
  });

  final Feature2GuidancePageArguments? arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Feature2GuidanceBloc.initialize(),
      child: const Feature2GuidanceScreen(),
    );
  }
}
