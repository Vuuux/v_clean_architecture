import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_clean_architecture/presentation/features/feature2/feature2_with_id_path/bloc/feature2_with_id_path_bloc.dart';
import 'package:v_clean_architecture/presentation/features/feature2/feature2_with_id_path/feature2_with_id_path_screen.dart';

final class Feature2WithIdPathPageArguments {
  Feature2WithIdPathPageArguments();
}

final class Feature2WithIdPathPage extends StatelessWidget {
  const Feature2WithIdPathPage({
    required this.id,
    super.key,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Feature2WithIdPathBloc.initialize(id: id),
      child: const Feature2WithIdPathScreen(),
    );
  }
}
