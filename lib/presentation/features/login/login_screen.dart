import 'dart:io';
import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:v_clean_architecture/app/app_router.dart';
import 'package:v_clean_architecture/constants/constants.dart';
import 'package:v_clean_architecture/domain/entities/entities.dart';
import 'package:v_clean_architecture/presentation/features/login/bloc/login_bloc.dart';
import 'package:v_clean_architecture/presentation/global_blocs/global_blocs.dart';
import 'package:v_clean_architecture/presentation/utils/utils.dart';

const _kLogoSize = 100.0;

final class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.onLoginSuccess});

  final VoidCallback? onLoginSuccess;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _loginBlocListener(BuildContext context, LoginState state) {
    setState(() {
      _isLoading = state is LoginInProgress || state is LoginSocialInProgress;
    });

    if (state is LoginFailure) {
      if (state.error is ApiException) {
        final apiException = state.error as ApiException;
        if (apiException.code == AppErrorConstants.errLoginLocked) {
          AppDialog.show(
            context,
            title: 'Account Locked',
            message: apiException.message ?? 'Your account has been locked. Please try resetting your password.',
            icon: const Icon(
              Icons.lock_rounded,
              color: AppColors.error,
              size: 48,
            ),
            barrierDismissible: false,
            actions: [
              AppDialogAction(
                label: 'Reset Password',
                onPressed: _onForgotPasswordPressed,
              ),
              AppDialogAction(
                label: 'Cancel',
                onPressed: () => context.pop(),
              ),
            ],
          );
        } else {
          showToast(
            title: 'Login Failed',
            description: apiException.message ?? 'Please check your credentials and try again.',
            type: AppToastType.error,
          );
        }
      }
    }

    if (state is LoginSocialFailure) {
      if (state.error is ApiException) {
        final apiException = state.error as ApiException;
        showToast(
          title: 'Social Login Failed',
          description: apiException.message ?? 'Please try a different method.',
          type: AppToastType.error,
        );
      }
    }

    if (state is LoginSuccess) {
      // Fetch user data
      context.read<SessionBloc>().add(
        SessionFetchUserDataStarted(
          shouldRedirect: false,
        ),
      );
      // TODO: Implement for push notification
      // context.read<PushNotificationBloc>().add(
      //   const PushNotificationTokenUpdated(),
      // );

      // Navigate to home using AppRouter
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          AppRouter.shared.router.go('/${RouteNames.feature1}');
          widget.onLoginSuccess?.call();
        }
      });
    }
  }

  void _handleLoginPressed() {
    if (_usernameController.text.isEmpty) {
      showToast(
        title: 'The information is incomplete.',
        description: 'Please enter username',
        type: AppToastType.error,
      );
      return;
    }
    if (_passwordController.text.isEmpty) {
      showToast(
        title: 'The information is incomplete.',
        description: 'Please enter password',
        type: AppToastType.error,
      );
      return;
    }

    context.read<LoginBloc>().add(
      LoginStarted(
        username: _usernameController.text,
        password: _passwordController.text,
      ),
    );
  }

  void _handleSocialLogin(OAuthProvider provider) {
    context.read<LoginBloc>().add(
      LoginSocialPressed(
        provider: provider,
      ),
    );
  }

  void _onRegisterAccountPressed() {
    showToast(
      title: 'Sign Up',
      description: 'Registration feature coming soon!',
      type: AppToastType.info,
    );
  }

  void _onForgotPasswordPressed() {
    showToast(
      title: 'Password Reset',
      description: 'Password reset feature coming soon!',
      type: AppToastType.info,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: _loginBlocListener,
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0B0E14),
                Color(0xFF10131A),
                Color(0xFF161A21),
              ],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(Dimens.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(Dimens.xl),
                  // Logo
                  Center(
                    child: Container(
                      width: _kLogoSize,
                      height: _kLogoSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF85ADFF).withValues(alpha: 0.3),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          AssetConstants.logo,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const Gap(Dimens.xxl),
                  // Title
                  Text(
                    'Welcome Back',
                    style: context.textTheme.h4.semibold.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const Gap(Dimens.xs),
                  Text(
                    'Sign in to continue',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFFA9ABB3),
                    ),
                  ),
                  const Gap(Dimens.xl),
                  // Username field
                  _buildTextField(
                    controller: _usernameController,
                    label: 'Username',
                    icon: Icons.person_outline_rounded,
                    textInputAction: TextInputAction.next,
                  ),
                  const Gap(Dimens.md),
                  // Password field
                  _buildTextField(
                    controller: _passwordController,
                    label: 'Password',
                    icon: Icons.lock_outline_rounded,
                    obscureText: true,
                    onSubmitted: (_) => _handleLoginPressed(),
                  ),
                  const Gap(Dimens.sm),
                  // Forgot password
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: _onForgotPasswordPressed,
                      child: Text(
                        'Forgot password?',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF85ADFF),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const Gap(Dimens.xl),
                  // Login button
                  _buildLoginButton(),
                  const Gap(Dimens.xl),
                  // Divider
                  const AppDividerWithText(
                    text: 'Or continue with',
                  ),
                  const Gap(Dimens.lg),
                  // Social buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialButton(
                        icon: AssetConstants.icSocialLine,
                        onTap: () => _handleSocialLogin(OAuthProvider.line),
                      ),
                      const Gap(Dimens.md),
                      _buildSocialButton(
                        icon: AssetConstants.icSocialGoogle,
                        onTap: () => _handleSocialLogin(OAuthProvider.google),
                      ),
                      if (Platform.isIOS) ...[
                        const Gap(Dimens.md),
                        _buildSocialButton(
                          icon: AssetConstants.icSocialApple,
                          onTap: () => _handleSocialLogin(OAuthProvider.apple),
                        ),
                      ],
                    ],
                  ),
                  const Gap(Dimens.xxl),
                  // Sign up
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: context.textTheme.bodySmall?.copyWith(
                            color: const Color(0xFFA9ABB3),
                          ),
                        ),
                        GestureDetector(
                          onTap: _onRegisterAccountPressed,
                          child: Text(
                            'Sign up',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: const Color(0xFF00EEFC),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputAction? textInputAction,
    ValueChanged<String>? onSubmitted,
  }) {
    return AppDarkTextField(
      controller: controller,
      label: label,
      prefixIcon: icon,
      obscureText: obscureText,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
    );
  }

  Widget _buildLoginButton() {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, sessionState) {
        final isSessionLoading = sessionState is SessionFetchUserDataInProgress;
        return AppGradientButton(
          label: 'Sign In',
          onPressed: _handleLoginPressed,
          isLoading: _isLoading || isSessionLoading,
        );
      },
    );
  }

  Widget _buildSocialButton({
    required String icon,
    required VoidCallback onTap,
  }) {
    return AppSocialButtonSquare(
      iconPath: icon,
      onPressed: onTap,
    );
  }
}
