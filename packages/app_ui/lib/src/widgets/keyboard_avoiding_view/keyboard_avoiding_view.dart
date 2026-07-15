import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stream_transform/stream_transform.dart';

const Duration _throttleDuration = Duration(milliseconds: 300);

class KeyboardAvoidingView extends StatefulWidget {
  const KeyboardAvoidingView({
    required this.child,
    this.enabled = true,
    super.key,
  });

  final Widget child;
  final bool enabled;

  @override
  State<KeyboardAvoidingView> createState() => _KeyboardAvoidingViewState();
}

class _KeyboardAvoidingViewState extends State<KeyboardAvoidingView>
    with WidgetsBindingObserver {
  late StreamController<void> _streamController;
  double _keyboardHeight = 0;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<void>();
    _streamController.stream
        .audit(_throttleDuration)
        .listen(_handleKeyboardChange);
    WidgetsBinding.instance.addObserver(this);
    FocusManager.instance.addListener(_handleFocusChanged);
  }

  @override
  void dispose() {
    _streamController.close();
    WidgetsBinding.instance.removeObserver(this);
    FocusManager.instance.removeListener(_handleFocusChanged);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (!widget.enabled) return;
    _streamController.add(null);
  }

  void _handleFocusChanged() {
    if (!widget.enabled) return;
    _streamController.add(null);
  }

  void _handleKeyboardChange(_) {
    final physicalInset = View.of(context).viewInsets.bottom;
    final dpr = View.of(context).devicePixelRatio;
    final bottomInset = physicalInset / dpr;

    if (bottomInset != _keyboardHeight) {
      _keyboardHeight = bottomInset;
    }

    if (_keyboardHeight > 0) {
      _adjustForFocusedField();
    }
  }

  void _adjustForFocusedField() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final focus = FocusManager.instance.primaryFocus;
      if (focus == null || !focus.hasFocus) {
        return;
      }

      final focusContext = focus.context;
      if (focusContext == null) {
        return;
      }

      final renderBox = focus.context?.findRenderObject() as RenderBox?;
      if (renderBox == null || !renderBox.attached) {
        return;
      }

      // textfield position
      final fieldOffset = renderBox.localToGlobal(Offset.zero);
      final fieldHeight = renderBox.size.height;
      final fieldBottom = fieldOffset.dy + fieldHeight;

      // screen size
      final screenHeight = MediaQuery.of(context).size.height;
      final distanceFromKeyboard = (screenHeight - _keyboardHeight) / 2;
      final visibleHeight =
          screenHeight - _keyboardHeight - distanceFromKeyboard;

      // check if the text field is obscured
      final isObscured = fieldBottom > visibleHeight;

      if (isObscured) {
        final obscuredHeight = fieldBottom - visibleHeight;

        // find the wrapper ScrollController
        final scrollable = Scrollable.maybeOf(focusContext);

        if (scrollable != null) {
          final currentOffset = scrollable.position.pixels;
          final targetOffset = currentOffset + obscuredHeight;

          scrollable.position.animateTo(
            targetOffset.clamp(
              scrollable.position.minScrollExtent,
              scrollable.position.maxScrollExtent,
            ),
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOutCubic,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
