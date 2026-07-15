import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_clean_architecture/presentation/features/feature1/bloc/feature1_bloc.dart';
import 'package:v_clean_architecture/presentation/features/feature1/feature1_screen.dart';

final class Feature1Arguments {
  Feature1Arguments({required this.id});

  final String id;
}

final class Feature1Page extends StatelessWidget {
  const Feature1Page({
    super.key,
    this.arguments,
  });

  final Feature1Arguments? arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Feature1Bloc.initialize(),
      child: const Feature1Screen(),
    );
  }
}
