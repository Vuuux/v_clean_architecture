import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

part 'glass_box_border.dart';
part 'glass_decoration.dart';

final class GlassContainer extends StatelessWidget {
  const GlassContainer({
    required this.child,
    super.key,
    this.width,
    this.height,
    this.decoration,
    this.constraints,
    this.margin,
    this.padding,
    this.clipBehavior = Clip.none,
  });

  final BoxConstraints? constraints;
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final GlassDecoration? decoration;
  final Clip clipBehavior;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final glassDecoration = decoration ?? const GlassDecoration();

    var render = child;
    if (padding != null) {
      render = Padding(padding: padding!, child: child);
    }
    render = BackdropFilter(
      enabled: glassDecoration.blurEnabled,
      filter: ImageFilter.blur(
        sigmaX: glassDecoration.blurValue,
        sigmaY: glassDecoration.blurValue,
      ),
      child: render,
    );
    if (glassDecoration.boxShape == BoxShape.circle) {
      render = ClipOval(child: render);
    } else {
      render = ClipRRect(
        borderRadius: glassDecoration.borderRadius ?? BorderRadiusGeometry.zero,
        child: render,
      );
    }
    return RepaintBoundary(
      child: Container(
        key: key,
        margin: margin,
        width: width,
        height: height,
        constraints: constraints,
        clipBehavior: clipBehavior,
        decoration: glassDecoration.toBoxDecoration(),
        child: render,
      ),
    );
  }
}
