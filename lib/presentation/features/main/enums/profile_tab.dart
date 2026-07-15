import 'package:flutter/material.dart';

enum ProfileTab {
  tab1,
  tab2,
  tab3,
  me,
}

extension ProfileTabExtension on ProfileTab {
  Key get key {
    switch (this) {
      case ProfileTab.tab1:
        return const ValueKey('profile_tab_key_1');
      case ProfileTab.tab2:
        return const ValueKey('profile_tab_key_2');
      case ProfileTab.tab3:
        return const ValueKey('profile_tab_key_3');
      case ProfileTab.me:
        return const ValueKey('profile_tab_key_me');
    }
  }

  IconData get icon {
    switch (this) {
      case ProfileTab.tab1:
        return Icons.apple;
      case ProfileTab.tab2:
        return Icons.android;
      case ProfileTab.tab3:
        return Icons.catching_pokemon;
      case ProfileTab.me:
        return Icons.person;
    }
  }

  IconData get activeIcon {
    switch (this) {
      case ProfileTab.tab1:
        return Icons.apple_outlined;
      case ProfileTab.tab2:
        return Icons.android_outlined;
      case ProfileTab.tab3:
        return Icons.catching_pokemon_outlined;
      case ProfileTab.me:
        return Icons.person_outlined;
    }
  }
}
