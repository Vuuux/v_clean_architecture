import 'package:flutter/material.dart';
import 'package:v_clean_architecture/constants/constants.dart';

enum AppCustomTab { tab1, tab2, tab3, profile }

extension AppTabExtension on AppCustomTab {
  Key get key {
    switch (this) {
      case AppCustomTab.tab1:
        return const ValueKey('tab_key_1');
      case AppCustomTab.tab2:
        return const ValueKey('tab_key_2');
      case AppCustomTab.tab3:
        return const ValueKey('tab_key_3');
      case AppCustomTab.profile:
        return const ValueKey('tab_key_profile');
    }
  }

  String get label {
    switch (this) {
      case AppCustomTab.tab1:
        return 'Home';
      case AppCustomTab.tab2:
        return 'Explore';
      case AppCustomTab.tab3:
        return 'Activity';
      case AppCustomTab.profile:
        return 'Settings';
    }
  }

  IconData get icon {
    switch (this) {
      case AppCustomTab.tab1:
        return Icons.home_rounded;
      case AppCustomTab.tab2:
        return Icons.explore_rounded;
      case AppCustomTab.tab3:
        return Icons.history_rounded;
      case AppCustomTab.profile:
        return Icons.settings_rounded;
    }
  }

  IconData get activeIcon {
    switch (this) {
      case AppCustomTab.tab1:
        return Icons.home_rounded;
      case AppCustomTab.tab2:
        return Icons.explore_rounded;
      case AppCustomTab.tab3:
        return Icons.history_rounded;
      case AppCustomTab.profile:
        return Icons.settings_rounded;
    }
  }

  String get animationAsset {
    switch (this) {
      case AppCustomTab.tab1:
        return AssetConstants.animBottomNavHome;
      case AppCustomTab.tab2:
        return AssetConstants.animBottomNavLearn;
      case AppCustomTab.tab3:
        return AssetConstants.animBottonNavRank;
      case AppCustomTab.profile:
        return AssetConstants.animBottomNavProfile;
    }
  }
}
