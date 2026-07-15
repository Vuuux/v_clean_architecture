// ignore_for_file: document_ignores

import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide MultiBlocObserver;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:toastification/toastification.dart';
import 'package:v_clean_architecture/app/app_environment.dart';
import 'package:v_clean_architecture/app/app_router.dart';
import 'package:v_clean_architecture/dependency_injection.dart';
import 'package:v_clean_architecture/presentation/global_bloc/global_blocs.dart';
import 'package:v_clean_architecture/presentation/utils/utils.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _navigationKey = GlobalKey<NavigatorState>();
  late DeepLinkBloc _deepLinkBloc;
  late SessionBloc _sessionBloc;
  late PushNotificationBloc _pushNotificationBloc;

  @override
  void initState() {
    super.initState();
    DI.it.initialize();
    AppRouter.shared.initialize(_navigationKey);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    Bloc.observer = MultiBlocObserver([
      BlocErrorHandler(
        displayError: (title, message) => showToast(
          title: title,
          description: message,
          type: AppToastType.error,
        ),
        forceLogoutHandler: () =>
            _sessionBloc.add(const SessionLogoutRequested(isForce: true)),
      ),
      TalkerBlocObserver(
        talker: TalkerFlutter.init(),
        settings: TalkerBlocLoggerSettings(
          enabled: AppEnvironment.blocLogEnabled,
          // eventFilter: (bloc, event) => event is! SomethingEvent,
          // transitionFilter: (bloc, transition) =>
          //     transition.nextState is! SomethingEvent,
        ),
      ),
    ]);

    _deepLinkBloc = DeepLinkBloc.initialize();

    _sessionBloc = SessionBloc.initialize();

    // _pushNotificationBloc = PushNotificationBloc.initialize();
    // ..add(PushNotificationPermissionRequested())
    // ..add(PushNotificationInitialized());
  }

  @override
  void dispose() {
    _deepLinkBloc.close();
    _sessionBloc.close();
    // _pushNotificationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      config: ToastificationConfig(
        marginBuilder: (context, alignment) {
          return const EdgeInsets.symmetric(
            horizontal: Dimens.md,
          );
        },
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => LoaderBloc.initialize()),
          BlocProvider(create: (_) => _deepLinkBloc),
          BlocProvider(create: (_) => _sessionBloc),
          // BlocProvider(
          //   create: (_) => _pushNotificationBloc,
          // ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<DeepLinkBloc, DeepLinkState>(
              listener: (_, state) => _deepLinkBloc.listener(state),
            ),
            BlocListener<SessionBloc, SessionState>(
              listener: (_, state) => _sessionBloc.listener(
                state,
                onAppReady: () {
                  _deepLinkBloc.add(const DeepLinkStarted());
                  // _pushNotificationBloc.add(
                  //   PushNotificationInitialMessageChecked(),
                  // );
                },
              ),
            ),
            // BlocListener<PushNotificationBloc, PushNotificationState>(
            //   listener: (_, state) => _pushNotificationBloc.listener(state),
            // ),
          ],
          child: MaterialApp.router(
            supportedLocales: const [
              Locale('th', 'TH'),
              Locale('en', 'US'),
            ],
            debugShowCheckedModeBanner: false,
            locale: const Locale('en'),
            themeMode: ThemeMode.dark,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            routerConfig: AppRouter.shared.router,
            builder: (context, child) {
              return Stack(
                children: [
                  KeyboardAvoidingView(child: child!),
                  BlocBuilder<LoaderBloc, LoaderState>(
                    builder: (context, state) {
                      if (state is LoaderStartSuccess) {
                        return Positioned.fill(
                          child: ColoredBox(
                            color: AppColors.black.withAlpha(100),
                            child: const Center(
                              child: AppLoading(),
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  if (AppEnvironment.env != 'prd')
                    Positioned(
                      right: 0,
                      child: FutureBuilder(
                        future: PackageInfo.fromPlatform(),
                        builder: (context, info) {
                          final buildVersion =
                              // ignore: lines_longer_than_80_chars
                              '${info.data?.version}(${info.data?.buildNumber})';
                          final displayMessage =
                              '${AppEnvironment.env} $buildVersion';
                          return Banner(
                            message: displayMessage.toUpperCase(),
                            location: BannerLocation.topEnd,
                            color: Colors.blue,
                            textStyle: const TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        },
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
