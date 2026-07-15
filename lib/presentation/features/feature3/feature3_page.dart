import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_clean_architecture/presentation/features/feature3/bloc/feature3_bloc.dart';
import 'package:v_clean_architecture/presentation/features/feature3/feature3_screen.dart';

final class Feature3Arguments {
  Feature3Arguments();
}

final class Feature3Page extends StatelessWidget {
  const Feature3Page({
    super.key,
    this.arguments,
  });

  final Feature3Arguments? arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Feature3Bloc.initialize(),
      child: const Feature3Screen(),
    );
  }
}
