import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

mixin ScreenVisibilityMixin<W extends StatefulWidget> on State<W> {
  late final ValueListenable<bool> _tickerListenable;

  @mustCallSuper
  @override
  void initState() {
    _tickerListenable = TickerMode.getNotifier(context);
    _tickerListenable.addListener(_widgetVisibilityListener);
    super.initState();
  }

  @mustCallSuper
  @override
  void dispose() {
    _tickerListenable.removeListener(_widgetVisibilityListener);
    super.dispose();
  }

  void _widgetVisibilityListener() {
    if (_tickerListenable.value) {
      return didResume();
    }
    return didPause();
  }

  void didResume() {}

  void didPause() {}
}
