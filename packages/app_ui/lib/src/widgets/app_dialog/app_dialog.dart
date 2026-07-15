import 'dart:async';
import 'dart:ui';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

part 'app_dialog_container.dart';
part 'app_dialog_animation.dart';

final class AppDialog {
  static Future<void> show(
    BuildContext context, {
    Widget? icon,
    String? title,
    String? message,
    Alignment alignment = Alignment.center,
    Color? barrierColor,
    bool barrierDismissible = true,
    Duration? autoCloseDuration,
    AppDialogDecoration? decoration,
    EdgeInsets? contentPadding,
    List<AppDialogAction> actions = const [],
    Axis? actionDirection,
    Color? backgroundColor,

    /// Animation type  [scale, fade, rotate, slideInDown]
    AppDialogTransition transitionType = AppDialogTransition.scale,
  }) {
    if (autoCloseDuration != null) {
      Timer(autoCloseDuration, () {
        Navigator.of(context, rootNavigator: true).pop();
      });
    }

    final child = PopScope(
      canPop: barrierDismissible,
      child: SafeArea(
        child: Align(
          alignment: alignment,
          child: AppDialogContainer(
            icon: icon,
            decoration: decoration ?? AppDialogDecoration.defaultDecoration(),
            title: title,
            padding: contentPadding,
            message: message,
            actions: actions,
            actionDirection: actionDirection,
            backgroundColor: backgroundColor,
          ),
        ),
      ),
    );

    return showGeneralDialog(
      barrierColor: barrierColor ?? Colors.black26,
      barrierLabel: '',
      barrierDismissible: autoCloseDuration != null || barrierDismissible,
      context: context,
      pageBuilder: (context, a1, _) => transitionType.animationBuilder(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Theme(data: AppTheme.light(), child: child),
        ),
        animation: a1,
      ),
    );
  }

  static Future<void> showCustomized(
    BuildContext context, {
    required Widget content,
    Alignment alignment = Alignment.center,
    Color? barrierColor,
    bool barrierDismissible = true,
    Duration? autoCloseDuration,
    AppDialogDecoration? decoration,
    EdgeInsets? contentPadding,
    Color? backgroundColor,

    /// Animation type  [scale, fade, rotate, slideInDown]
    AppDialogTransition transitionType = AppDialogTransition.scale,
  }) {
    if (autoCloseDuration != null) {
      Timer(autoCloseDuration, () {
        Navigator.of(context, rootNavigator: true).pop();
      });
    }

    final child = PopScope(
      canPop: barrierDismissible,
      child: SafeArea(
        child: Align(
          alignment: alignment,
          child: AppDialogContainer(
            padding: EdgeInsets.zero,
            decoration: decoration ?? AppDialogDecoration.defaultDecoration(),
            backgroundColor: backgroundColor,
            child: content,
          ),
        ),
      ),
    );

    return showGeneralDialog(
      barrierColor: barrierColor ?? Colors.black26,
      barrierLabel: '',
      barrierDismissible: autoCloseDuration != null || barrierDismissible,
      context: context,
      pageBuilder: (context, a1, _) => transitionType.animationBuilder(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: child,
        ),
        animation: a1,
      ),
    );
  }
}
