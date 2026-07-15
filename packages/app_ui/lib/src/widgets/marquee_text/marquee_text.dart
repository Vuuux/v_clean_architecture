import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

// Automatically applies marquee only when text overflows available width.
class MarqueeText extends StatelessWidget {
  const MarqueeText(
    this.text, {
    super.key,
    this.style,
    this.velocity = 40.0, // pixels per second
    this.blankSpace = 32.0,
    this.startPadding = 0.0,
    this.pauseAfterRound = Duration.zero, // set > 0 for a pause each loop
    this.textAlign = TextAlign.left,
  });

  final String text;
  final TextStyle? style;
  final double velocity;
  final double blankSpace;
  final double startPadding;
  final Duration pauseAfterRound;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        if (maxWidth == double.infinity || maxWidth <= 0) {
          return _buildStatic();
        }
        // Measure intrinsic (unconstrained) width to detect true overflow.
        final painter = TextPainter(
          text: TextSpan(text: text, style: style),
          maxLines: 1,
          textDirection: TextDirection.ltr,
        )..layout(); // no maxWidth => intrinsic width
        final intrinsicWidth = painter.width;
        if (intrinsicWidth <= maxWidth) {
          return _buildStatic();
        }
        return SizedBox(
          height: _lineHeightEstimate(style),
          width: maxWidth,
          child: Marquee(
            text: text,
            style: style,
            blankSpace: blankSpace,
            velocity: velocity,
            startPadding: startPadding,
            pauseAfterRound: pauseAfterRound,
          ),
        );
      },
    );
  }

  Widget _buildStatic() => Text(
    text,
    style: style,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    textAlign: textAlign,
  );

  double _lineHeightEstimate(TextStyle? style) {
    final fontSize = style?.fontSize ?? 14.0;
    final height = style?.height ?? 1.2;
    return fontSize * height + 2; // small padding buffer
  }
}
