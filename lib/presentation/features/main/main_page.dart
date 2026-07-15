import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:v_clean_architecture/presentation/enums/app_tab.dart';
import 'package:v_clean_architecture/presentation/features/main/widgets/main_bottom_nav_icon.dart';

final class MainPage extends StatelessWidget {
  const MainPage({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('main_page'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: AppBottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          onTabChanged: navigationShell.goBranch,
          items: AppCustomTab.values
              .mapIndexed(
                (tabIndex, tab) => AppBottomNavigationBarItem(
                  key: tab.key,
                  icon: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: Dimens.iconLg,
                        width: Dimens.iconLg,
                        child: MainBottomNavIcon(
                          tab: tab,
                          isActive: tabIndex == navigationShell.currentIndex,
                        ),
                      ),
                      Text(
                        tab.label,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: tabIndex == navigationShell.currentIndex
                              ? AppColors.icLightGreen
                              : AppColors.textDisabled,
                        ),
                      ),
                    ],
                  ),
                  label: tab.label,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
