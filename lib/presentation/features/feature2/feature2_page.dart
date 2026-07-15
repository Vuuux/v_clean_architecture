import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_clean_architecture/domain/domain.dart';
import 'package:v_clean_architecture/presentation/features/feature2/bloc/feature2_bloc.dart';
import 'package:v_clean_architecture/presentation/features/feature2/feature2_screen.dart';

final class Feature2Arguments {
  Feature2Arguments({
    this.deepLinkType,
  });
  final DeepLinkType? deepLinkType;
}

final class Feature2Page extends StatelessWidget {
  const Feature2Page({
    super.key,
    this.arguments,
  });

  final Feature2Arguments? arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Feature2Bloc.initialize(),
      child: Feature2Screen(
        deepLinkType: arguments!.deepLinkType,
      ),
    );
  }
}
