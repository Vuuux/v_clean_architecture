import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:v_clean_architecture/presentation/features/main/enums/app_tab.dart';

class MainBottomNavIcon extends StatelessWidget {
  const MainBottomNavIcon({
    required this.tab,
    required this.isActive,
    super.key,
  });

  final AppCustomTab tab;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AppAnimatedRiveIcon(
      assetPath: tab.animationAsset,
      isActive: isActive,
    );
  }
}
