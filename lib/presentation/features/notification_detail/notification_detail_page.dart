import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_clean_architecture/presentation/features/notification_detail/bloc/notification_detail_bloc.dart';
import 'package:v_clean_architecture/presentation/features/notification_detail/notification_detail_screen.dart';

final class NotificationDetailPageArguments {
  NotificationDetailPageArguments({required this.notiId});
  final String notiId;
}

final class NotificationDetailPage extends StatelessWidget {
  const NotificationDetailPage({
    super.key,
    this.arguments,
  });

  final NotificationDetailPageArguments? arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationDetailBloc.initialize(),
      child: const NotificationDetailScreen(),
    );
  }
}
