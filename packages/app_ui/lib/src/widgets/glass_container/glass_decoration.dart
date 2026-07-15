part of 'glass_container.dart';

const Color _kDefaultBackgroundColor = Colors.white24;
const _kDefaultBlurValue = 8.0;

final class GlassDecoration {
  const GlassDecoration({
    this.border = const GlassBoxBorder(),
    this.borderRadius,
    this.backgroundColor = _kDefaultBackgroundColor,
    this.underlyingColor,
    this.backgroundGradient,
    this.boxShape = BoxShape.rectangle,
    this.blurEnabled = true,
    this.blurValue = _kDefaultBlurValue,
  }) : assert(
         boxShape != BoxShape.circle || borderRadius == null,
         'borderRadius must be null if boxShape is BoxShape.circle',
       );

  factory GlassDecoration.darken({
    BoxBorder border = const GlassBoxBorder(),
    BorderRadius? borderRadius,
    Color? backgroundColor,
    Color? underlyingColor,
    Gradient? backgroundGradient,
    BoxShape boxShape = BoxShape.rectangle,
    bool blurEnabled = true,
    double blurValue = _kDefaultBlurValue,
  }) {
    return GlassDecoration(
      border: border,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor ?? const Color(0x80000000),
      underlyingColor: underlyingColor ?? const Color(0x80CCCCCC),
      backgroundGradient: backgroundGradient,
      boxShape: boxShape,
      blurEnabled: blurEnabled,
      blurValue: blurValue,
    );
  }

  final BoxBorder border;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? underlyingColor;
  final Gradient? backgroundGradient;
  final BoxShape boxShape;
  final bool blurEnabled;
  final double blurValue;

  BoxDecoration toBoxDecoration() {
    return BoxDecoration(
      border: border,
      borderRadius: borderRadius,
      color: backgroundColor,
      gradient: backgroundGradient,
      shape: boxShape,
      boxShadow: [
        if (underlyingColor != null) BoxShadow(color: underlyingColor!),
      ],
    );
  }
}
