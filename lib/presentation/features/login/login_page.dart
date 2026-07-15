import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_clean_architecture/presentation/features/login/bloc/login_bloc.dart';
import 'package:v_clean_architecture/presentation/features/login/login_screen.dart';

final class LoginPageArguments {
  LoginPageArguments({this.onLoginSuccess});
  final VoidCallback? onLoginSuccess;
}

final class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
    this.arguments,
  });

  final LoginPageArguments? arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc.initialize(),
      child: LoginScreen(
        onLoginSuccess: arguments?.onLoginSuccess,
      ),
    );
  }
}
