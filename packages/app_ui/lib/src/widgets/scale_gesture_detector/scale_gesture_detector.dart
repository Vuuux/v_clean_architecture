import 'package:flutter/material.dart';

final class ScaleGestureDetector extends StatefulWidget {
  const ScaleGestureDetector({
    required this.child,
    super.key,
    this.onTap,
    this.onTapDown,
    this.onTapCancel,
    this.onDoubleTap,
    this.onLongPress,
    this.duration = const Duration(milliseconds: 120),
    this.delayDuration = const Duration(milliseconds: 60),
    this.curve = Curves.easeOutQuint,
    this.enableFeedback = true,
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onTapDown;
  final VoidCallback? onTapCancel;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;
  final Duration duration;
  final Duration delayDuration;
  final Curve curve;
  final bool enableFeedback;

  @override
  State<ScaleGestureDetector> createState() => _ScaleGestureDetectorState();
}

class _ScaleGestureDetectorState extends State<ScaleGestureDetector> {
  final _scaleNotifier = ValueNotifier<double>(1);

  bool get enabled =>
      widget.onTap != null ||
      widget.onDoubleTap != null ||
      widget.onLongPress != null;

  void _handleTap() {
    _handleScaleUp();
    if (widget.onTap != null) {
      if (widget.enableFeedback) {
        Feedback.forTap(context);
      }
      widget.onTap?.call();
    }
  }

  void _handleTapDown(_) {
    if (!enabled) {
      return;
    }
    _handleScaleDown();
    widget.onTapDown?.call();
  }

  void _handleTapCancel() {
    _handleScaleUp();
    widget.onTapCancel?.call();
  }

  void _handleScaleDown() {
    _scaleNotifier.value = 0.9;
  }

  void _handleScaleUp() {
    Future<void>.delayed(
      widget.delayDuration,
    ).then((_) {
      if (!mounted) return;
      _scaleNotifier.value = 1;
    });
  }

  @override
  void dispose() {
    _scaleNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      onDoubleTap: widget.onDoubleTap,
      onLongPress: widget.onLongPress,
      onTapDown: _handleTapDown,
      onTapCancel: _handleTapCancel,
      behavior: HitTestBehavior.opaque,
      child: ValueListenableBuilder<double>(
        valueListenable: _scaleNotifier,
        builder: (context, scale, _) {
          return AnimatedScale(
            scale: scale,
            curve: widget.curve,
            duration: widget.duration,
            child: widget.child,
          );
        },
      ),
    );
  }
}
