import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

/// A widget that displays an animated Rive icon.
///
/// This widget loads a Rive animation file and provides control over
/// animation properties through data binding.
class AppAnimatedRiveIcon extends StatefulWidget {
  const AppAnimatedRiveIcon({
    required this.assetPath,
    this.isActive = false,
    this.activePropertyName = 'isActive',
    this.fit = Fit.cover,
    this.onInitialized,
    super.key,
  });

  /// Path to the Rive animation asset
  final String assetPath;

  /// Whether the icon is in active state
  final bool isActive;

  /// Name of the boolean property in the Rive animation for active state
  final String activePropertyName;

  /// How the Rive animation should be fitted
  final Fit fit;

  /// Callback when the Rive animation is initialized
  final VoidCallback? onInitialized;

  @override
  State<AppAnimatedRiveIcon> createState() => _AppAnimatedRiveIconState();
}

class _AppAnimatedRiveIconState extends State<AppAnimatedRiveIcon> {
  late RiveWidgetController _controller;
  bool _isInitialized = false;
  ViewModelInstanceBoolean? _activeProperty;

  @override
  void initState() {
    super.initState();
    _initRive();
  }

  Future<void> _initRive() async {
    final file = (await File.asset(
      widget.assetPath,
      riveFactory: Factory.rive,
    ))!;
    _controller = RiveWidgetController(file);
    _activeProperty = _controller
        .dataBind(DataBind.auto())
        .boolean(widget.activePropertyName);
    _activeProperty?.value = widget.isActive;

    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
      widget.onInitialized?.call();
    }
  }

  @override
  void didUpdateWidget(covariant AppAnimatedRiveIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isActive != widget.isActive) {
      _activeProperty?.value = widget.isActive;
    }
  }

  @override
  void dispose() {
    _activeProperty?.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const SizedBox.shrink();
    }
    return RiveWidget(
      controller: _controller,
      fit: widget.fit,
    );
  }
}

