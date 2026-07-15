import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_clean_architecture/presentation/features/home/bloc/home_bloc.dart';
import 'package:v_clean_architecture/presentation/features/home/home_screen.dart';

final class HomePageArguments {
  HomePageArguments();
}

final class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    this.arguments,
  });

  final HomePageArguments? arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc.initialize(),
      child: const HomeScreen(),
    );
  }
}
