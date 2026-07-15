import 'dart:typed_data';
import 'dart:ui';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

part './image_cropper_controller.dart';

class ImageCropper extends StatefulWidget {
  const ImageCropper({
    required this.controller,
    required this.image,
    this.backgroundColor = AppColors.black,
    this.maxZoomScale = 2.5,
    this.minZoomScale = 0.1,
    this.aspectRatio = 1,
    this.rotationTurns = 0,
    this.onScaleStart,
    this.onScaleUpdate,
    this.onScaleEnd,
  }) : super(key: controller);

  final ImageCropperController controller;

  final Color backgroundColor;
  final double maxZoomScale;
  final double minZoomScale;
  final double aspectRatio;
  final int rotationTurns;

  final Image image;

  final GestureScaleStartCallback? onScaleStart;
  final GestureScaleUpdateCallback? onScaleUpdate;
  final GestureScaleEndCallback? onScaleEnd;

  @override
  State<ImageCropper> createState() => ImageCropperState();
}

class ImageCropperState extends State<ImageCropper> {
  final GlobalKey _cropperKey = GlobalKey();
  late final TransformationController _transformationController;

  late bool _hasImageUpdated;

  bool _shouldSetInitialScale = false;
  bool _shouldUpdateScale = false;

  final ImageConfiguration _imageConfiguration = ImageConfiguration.empty;

  late final _imageStreamListener = ImageStreamListener((_, _) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _shouldSetInitialScale = true;
      });
    });
  });

  @override
  void initState() {
    super.initState();
    _hasImageUpdated = true;
    _transformationController = TransformationController();
  }

  @override
  void didUpdateWidget(covariant ImageCropper oldWidget) {
    super.didUpdateWidget(oldWidget);

    _hasImageUpdated = oldWidget.image.image != widget.image.image;
    _shouldUpdateScale = oldWidget.rotationTurns != widget.rotationTurns;
  }

  Future<Uint8List?> crop({double pixelRatio = 3}) async {
    // Get cropped image
    final renderObject = _cropperKey.currentContext!.findRenderObject();
    final boundary = renderObject as RenderRepaintBoundary?;
    final image = await boundary?.toImage(pixelRatio: pixelRatio);

    // Convert image to bytes in PNG format and return
    final byteData = await image?.toByteData(format: ImageByteFormat.png);
    final pngBytes = byteData?.buffer.asUint8List();

    return pngBytes;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: ColoredBox(
        color: widget.backgroundColor,
        child: Stack(
          alignment: Alignment.center,
          children: [
            RepaintBoundary(
              key: _cropperKey,
              child: AspectRatio(
                aspectRatio: widget.aspectRatio,
                child: LayoutBuilder(
                  builder: (_, constraint) {
                    return InteractiveViewer(
                      clipBehavior: Clip.none,
                      transformationController: _transformationController,
                      constrained: false,
                      minScale: widget.minZoomScale,
                      maxScale: widget.maxZoomScale,
                      onInteractionStart: widget.onScaleStart,
                      onInteractionUpdate: widget.onScaleUpdate,
                      onInteractionEnd: widget.onScaleEnd,
                      child: Builder(
                        builder: (context) {
                          final imageStream = widget.image.image.resolve(
                            _imageConfiguration,
                          );
                          if (_hasImageUpdated && _shouldSetInitialScale) {
                            imageStream.removeListener(_imageStreamListener);
                            _setInitialScale(context, constraint.biggest);
                          }

                          if (_hasImageUpdated && !_shouldSetInitialScale) {
                            imageStream.addListener(_imageStreamListener);
                          }

                          if (_shouldUpdateScale) {
                            _setInitialScale(context, constraint.biggest);
                            _shouldUpdateScale = false;
                          }

                          return RotatedBox(
                            quarterTurns: widget.rotationTurns,
                            child: widget.image,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getCoverRatio(Size outside, Size inside) {
    return outside.width / outside.height > inside.width / inside.height
        ? outside.width / inside.width
        : outside.height / inside.height;
  }

  double _getTranslationX(Size outside, Size inside, num coverRatio) {
    return (outside.width / coverRatio - inside.width) / 2;
  }

  double _getTranslationY(Size outside, Size inside, num coverRatio) {
    return (outside.height / coverRatio - inside.height) / 2;
  }

  void _setInitialScale(BuildContext context, Size parentSize) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderBox = context.findRenderObject() as RenderBox?;
      final childSize = renderBox?.size ?? Size.zero;
      if (childSize != Size.zero) {
        final coverRatio = _getCoverRatio(parentSize, childSize);
        final value = (Matrix4.identity() * coverRatio) as Matrix4
          // Center the image inside the InteractiveViewer
          ..translate(
            _getTranslationX(parentSize, childSize, coverRatio),
            _getTranslationY(parentSize, childSize, coverRatio),
          );

        _transformationController.value = value;
      }

      _shouldSetInitialScale = false;
    });
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }
}
