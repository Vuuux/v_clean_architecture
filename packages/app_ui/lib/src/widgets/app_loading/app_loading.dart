import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';

const _kDefaultSize = 56.0;

class AppLoading extends StatefulWidget {
  const AppLoading({super.key, this.color, this.size = _kDefaultSize});

  final Color? color;
  final double size;

  @override
  State<AppLoading> createState() => _AppLoadingState();
}

class _AppLoadingState extends State<AppLoading> {
  late RiveWidgetController _controller;
  ViewModelInstanceColor? _colorViewModel;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initRive();
  }

  Future<void> _initRive() async {
    final file = (await File.asset(
      'packages/app_ui/assets/animations/anim_loading.riv',
      riveFactory: Factory.rive,
    ))!;
    _controller = RiveWidgetController(file);
    _colorViewModel = _controller.dataBind(DataBind.auto()).color('color');
    if (widget.color != null) {
      _colorViewModel?.value = widget.color!;
    }

    setState(() {
      _isInitialized = true;
    });
  }

  @override
  void didUpdateWidget(AppLoading oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color != widget.color && widget.color != null) {
      _colorViewModel?.value = widget.color!;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const SizedBox.shrink();
    }
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Center(
        child: SizedBox.square(
          dimension: widget.size,
          child: RiveWidget(controller: _controller),
        ),
      ),
    );
  }
}
