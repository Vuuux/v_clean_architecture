enum FirstPageCustomTab { main, second, last }

extension FirstPageTab on FirstPageCustomTab {
  String get name {
    switch (this) {
      case FirstPageCustomTab.main:
        return 'Main';
      case FirstPageCustomTab.second:
        return 'Second';
      case FirstPageCustomTab.last:
        return 'Last';
    }
  }
}
