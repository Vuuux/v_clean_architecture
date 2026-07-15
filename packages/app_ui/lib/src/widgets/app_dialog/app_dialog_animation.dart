part of 'app_dialog.dart';

enum AppDialogTransition { scale, fade, rotate, slideInDown }

extension AppDialogTransitionExtension on AppDialogTransition {
  Widget animationBuilder({
    required Widget child,
    required Animation<double> animation,
  }) {
    switch (this) {
      case AppDialogTransition.scale:
        return ScaleTransition(
          scale: Tween<double>(begin: 0.9, end: 1).animate(animation),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(animation),
            child: child,
          ),
        );
      case AppDialogTransition.fade:
        return FadeTransition(
          opacity: Tween<double>(begin: 0, end: 1).animate(animation),
          child: child,
        );
      case AppDialogTransition.rotate:
        return RotationTransition(
          turns: Tween<double>(begin: 0, end: 1).animate(animation),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(animation),
            child: child,
          ),
        );
      case AppDialogTransition.slideInDown:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(animation),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.5, end: 1).animate(animation),
            child: child,
          ),
        );
    }
  }
}
