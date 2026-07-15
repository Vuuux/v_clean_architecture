import 'dart:io';
import 'dart:math' as math;

import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:v_clean_architecture/app/app_environment.dart';
import 'package:v_clean_architecture/app/app_router.dart';
import 'package:v_clean_architecture/constants/assets.dart';
import 'package:v_clean_architecture/constants/route_names.dart';
import 'package:v_clean_architecture/presentation/features/splash/bloc/splash_bloc.dart';
import 'package:v_clean_architecture/presentation/global_bloc/session/session_bloc.dart';

const _progressBarWidth = 180.0;
const _progressBarHeight = 3.0;
const _logoSize = 120.0;

final class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final ValueNotifier<double> _somethingProgressNotifier = ValueNotifier(0);
  late final AnimationController _pulseController;
  late final AnimationController _rotationController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _checkSecuredDevice();
  }

  void _initAnimations() {
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    _somethingProgressNotifier.dispose();
    super.dispose();
  }

  void _checkSecuredDevice() {
    context.read<SplashBloc>().add(
      SplashCheckSecuredDeviceStarted(),
    );
  }

  void _checkMinVersion() {
    context.read<SplashBloc>().add(
      SplashCheckMinVersionStarted(),
    );
  }

  void _cacheAssetImages() {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    context.read<SplashBloc>().add(
      SplashCacheAssetsImageStarted(devicePixelRatio: devicePixelRatio),
    );
  }

  void _splashBlocListener(BuildContext context, SplashState state) {
    switch (state.runtimeType) {
      case const (SplashCheckSecuredDeviceSuccess):
        _somethingProgressNotifier.value = 0.2;
        _checkMinVersion();
        return;
      case const (SplashCheckSecuredDeviceFailure):
        _somethingProgressNotifier.value = 0.1;
        _showDeviceNotSecureDialog();
        return;
      case const (SplashCheckMinVersionCompleted):
        _somethingProgressNotifier.value += 0.2;
        _cacheAssetImages();
        return;
      case const (SplashForceUpdateRequired):
        _somethingProgressNotifier.value += 0.2;
        _showForceUpdateDialog((state as SplashForceUpdateRequired).minVersion);
        return;
      case const (SplashCacheAssetsImageSuccess):
      case const (SplashCacheAssetsImageFailure):
        _somethingProgressNotifier.value += 0.2;
        context.read<SessionBloc>().add(SessionRetriveAuthTokensStarted());
        return;
      default:
        return;
    }
  }

  void _sessionBlocListener(BuildContext context, SessionState state) {
    if (state is SessionRetriveLocalAuthTokensSuccess) {
      _somethingProgressNotifier.value += 0.2;
      if (state.authTokens == null) {
        // No tokens, go to login
        _somethingProgressNotifier.value = 1.0;
        context.goNamed(RouteNames.login);
      } else {
        // Tokens exist, fetch user data
        context.read<SessionBloc>().add(SessionFetchUserDataStarted());
      }
    }
    if (state is SessionFetchUserDataSuccess) {
      _somethingProgressNotifier.value = 1.0;
      // Navigate to home after user data is fetched
      context.goNamed(RouteNames.feature1);
    }
    if (state is SessionUserDataUpdateSuccess) {
      if (state.userData == null) {
        _somethingProgressNotifier.value += 0.2;
      } else {
        _somethingProgressNotifier.value = 1.0;
      }
    }
  }

  void _showDeviceNotSecureDialog() {
    final context = AppRouter.shared.rootNavigatorKey.currentContext;
    if (context != null) {
      AppDialog.show(
        context,
        title: 'Warning!',
        message: 'Your device is not secure!',
        icon: const Icon(
          Icons.warning_rounded,
          color: AppColors.warning,
          size: Dimens.iconXl,
        ),
        barrierDismissible: false,
        actions: [
          AppDialogAction(
            label: 'Proceed',
            onPressed: () {
              context.pop();
              _checkMinVersion();
            },
          ),
        ],
      );
    }
  }

  void _showForceUpdateDialog(
    String minVersion,
  ) {
    final context = AppRouter.shared.rootNavigatorKey.currentContext;
    if (context != null) {
      AppDialog.show(
        context,
        title: 'New update found',
        message:
            'Please update the app to the latest version, $minVersion, to continue using it.',
        icon: const Icon(
          Icons.system_update_rounded,
          color: AppColors.primary,
          size: Dimens.iconXl,
        ),
        barrierDismissible: false,
        actions: [
          AppDialogAction(
            label: 'Update Now!',
            onPressed: _openStore,
          ),
        ],
      );
    }
  }

  Future<void> _openStore() async {
    Uri url;

    if (Platform.isIOS) {
      url = Uri.parse(
        'https://apps.apple.com/app/id${AppEnvironment.appStoreAppId}',
      );
    } else if (Platform.isAndroid) {
      url = Uri.parse(
        'https://play.google.com/store/apps/details?id=${AppEnvironment.playStoreAppId}',
      );
    } else {
      return;
    }

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SplashBloc, SplashState>(
          listener: _splashBlocListener,
        ),
        BlocListener<SessionBloc, SessionState>(
          listener: _sessionBlocListener,
        ),
      ],
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
          child: Stack(
            children: [
              // Subtle animated background glow
              _buildBackgroundGlow(),
              // Main content
              SafeArea(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo with pulse animation
                      _buildAnimatedLogo(),
                      const SizedBox(height: Dimens.xxl),
                      // Bottom section with progress
                      _buildBottomSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundGlow() {
    return AnimatedBuilder(
      animation: _rotationController,
      builder: (context, child) {
        return Positioned(
          top: -100,
          left: -100,
          right: -100,
          child: Transform.rotate(
            angle: _rotationController.value * 2 * math.pi,
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF85ADFF).withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                  radius: 0.8,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedLogo() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: Container(
            width: _logoSize,
            height: _logoSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF85ADFF).withValues(alpha: 0.3),
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                AssetConstants.logo,
                width: _logoSize,
                height: _logoSize,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Progress indicator
        ValueListenableBuilder<double>(
          valueListenable: _somethingProgressNotifier,
          builder: (context, progress, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Progress bar
                Container(
                  width: _progressBarWidth,
                  height: _progressBarHeight,
                  decoration: BoxDecoration(
                    color: const Color(0xFF22262F),
                    borderRadius: BorderRadius.circular(Dimens.radiusRounded),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimens.radiusRounded),
                    child: Stack(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOutCubic,
                          width: _progressBarWidth * progress,
                          height: _progressBarHeight,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF85ADFF),
                                Color(0xFF00EEFC),
                              ],
                            ),
                            borderRadius:
                                BorderRadius.circular(Dimens.radiusRounded),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xFF00EEFC).withValues(alpha: 0.5),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: Dimens.md),
                // Status text
                Text(
                  _getStatusText(progress),
                  style: context.textTheme.labelMedium?.copyWith(
                    color: const Color(0xFFA9ABB3),
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  String _getStatusText(double progress) {
    if (progress < 0.2) return 'INITIALIZING...';
    if (progress < 0.4) return 'CHECKING VERSION...';
    if (progress < 0.6) return 'LOADING ASSETS...';
    if (progress < 0.8) return 'AUTHENTICATING...';
    if (progress < 1.0) return 'ALMOST READY...';
    return 'READY';
  }
}
