part of 'glass_container.dart';

const Color _kDefaultShadowColor = Colors.black26;

class GlassBoxBorder extends BoxBorder {
  const GlassBoxBorder({
    this.borderGradient,
    this.borderWidth = 1.0,
    this.hasShadow = true,
    this.shadowColor,
  });

  final Gradient? borderGradient;

  final double borderWidth;

  final bool hasShadow;

  final Color? shadowColor;

  @override
  BorderSide get bottom => BorderSide.none;

  @override
  BorderSide get top => BorderSide.none;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(borderWidth);

  @override
  bool get isUniform => true;

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) {
    switch (shape) {
      case BoxShape.circle:
        _paintCircle(canvas, rect);
        return;
      case BoxShape.rectangle:
        if (borderRadius != null) {
          _paintRRect(canvas, rect, borderRadius);
          return;
        }
        _paintRect(canvas, rect);
        return;
    }
  }

  void _paintRect(Canvas canvas, Rect rect) {
    canvas.drawRect(rect.deflate(borderWidth / 2), _getPaint(rect));
    if (hasShadow) {
      final shadowPaint = _getShadowPaint();
      canvas.drawRect(rect, shadowPaint);
    }
  }

  void _paintRRect(Canvas canvas, Rect rect, BorderRadius borderRadius) {
    final rrect = borderRadius.toRRect(rect).deflate(borderWidth / 2);
    canvas.drawRRect(rrect, _getPaint(rect));
    if (hasShadow) {
      final shadowPaint = _getShadowPaint();
      canvas.drawRRect(rrect, shadowPaint);
    }
  }

  void _paintCircle(Canvas canvas, Rect rect) {
    final paint = _getPaint(rect);
    final radius = (rect.shortestSide - borderWidth) / 2.0;
    canvas.drawCircle(rect.center, radius, paint);
    if (hasShadow) {
      final shadowPaint = _getShadowPaint();
      canvas.drawCircle(rect.center, radius, shadowPaint);
    }
  }

  @override
  ShapeBorder scale(double t) => this;

  Paint _getPaint(Rect rect) {
    final glassGradient =
        borderGradient ??
        const SweepGradient(
          colors: [
            Colors.white10,
            Colors.white,
            Colors.white10,
            Colors.transparent,
          ],
          startAngle: math.pi,

          tileMode: TileMode.repeated,
          stops: [0, 0.1, 0.8, 1.0],
        );

    return Paint()
      ..strokeWidth = borderWidth
      ..shader = glassGradient.createShader(rect)
      ..style = PaintingStyle.stroke;
  }

  Paint _getShadowPaint() {
    return Paint()
      ..color = shadowColor ?? _kDefaultShadowColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 4);
  }
}
