import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showToast({
  required String title,
  TextStyle? titleStyle,
  Widget? icon,
  String? description,
  Color? backgroundColor,
  AppToastType type = AppToastType.success,
  Duration autoCloseDuration = const Duration(seconds: 4),
  VoidCallback? onTap,
}) {
  toastification.showCustom(
    builder: (_, item) => AppToastLayout(
      type: type,
      title: title,
      titleStyle: titleStyle,
      icon: icon,
      description: description,
      backgroundColor: backgroundColor,
      onCloseTap: () => toastification.dismiss(item),
      onTap: onTap,
    ),
    alignment: Alignment.topCenter,
    autoCloseDuration: autoCloseDuration,
  );
}
