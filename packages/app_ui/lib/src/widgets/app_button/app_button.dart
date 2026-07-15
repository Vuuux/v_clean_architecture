import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

part 'app_button_style.dart';
part 'app_button_type.dart';

const _kDefaultLoadingSize = 20.0;
const _kDefaultChildSpacing = 8.0;
const _kDefaultPadding = EdgeInsets.all(Dimens.sm);

final class AppButton extends StatelessWidget {
  const AppButton({
    this.type = AppButtonType.filled,
    super.key,
    this.onPressed,
    this.onLongPressed,
    this.leading,
    this.trailing,
    this.child,
    this.label,
    this.style,
    this.loading = false,
    this.expanded = true,
    this.disabled = false,
    this.marquee = false,
    this.isDense = false,
  });

  factory AppButton.filled({
    Widget? child,
    String? label,
    VoidCallback? onPressed,
    VoidCallback? onLongPressed,
    Widget? leading,
    Widget? trailing,
    AppButtonStyle? style,
    bool loading = false,
    bool expanded = true,
    bool disabled = false,
    bool isDense = false,
  }) {
    return AppButton(
      label: label,
      onPressed: onPressed,
      onLongPressed: onLongPressed,
      leading: leading,
      trailing: trailing,
      style: AppButtonStyle.filled().from(style),
      expanded: expanded,
      loading: loading,
      disabled: disabled,
      isDense: isDense,
      child: child,
    );
  }

  factory AppButton.icon({
    required Widget icon,
    VoidCallback? onPressed,
    VoidCallback? onLongPressed,
    AppButtonStyle? style,
    bool loading = false,
    bool disabled = false,
  }) {
    return AppButton(
      onPressed: onPressed,
      onLongPressed: onLongPressed,
      style: AppButtonStyle.icon().from(style),
      isDense: true,
      expanded: false,
      loading: loading,
      disabled: disabled,
      child: icon,
    );
  }

  factory AppButton.outlined({
    Widget? child,
    String? label,
    VoidCallback? onPressed,
    VoidCallback? onLongPressed,
    Widget? leading,
    Widget? trailing,
    AppButtonStyle? style,
    bool loading = false,
    bool expanded = true,
    bool disabled = false,
    bool marquee = false,
    bool isDense = false,
  }) {
    return AppButton(
      type: AppButtonType.outlined,
      label: label,
      onPressed: onPressed,
      onLongPressed: onLongPressed,
      leading: leading,
      trailing: trailing,
      style: AppButtonStyle.outlined().from(style),
      expanded: expanded,
      loading: loading,
      disabled: disabled,
      marquee: marquee,
      isDense: isDense,
      child: child,
    );
  }

  factory AppButton.glassed({
    Widget? child,
    String? label,
    VoidCallback? onPressed,
    VoidCallback? onLongPressed,
    Widget? leading,
    Widget? trailing,
    AppButtonStyle? style,
    bool loading = false,
    bool expanded = true,
    bool disabled = false,
    bool marquee = false,
    bool isDense = false,
  }) {
    return AppButton(
      type: AppButtonType.glassed,
      label: label,
      onPressed: onPressed,
      onLongPressed: onLongPressed,
      leading: leading,
      trailing: trailing,
      style: AppButtonStyle.glassed().from(style),
      expanded: expanded,
      loading: loading,
      disabled: disabled,
      marquee: marquee,
      isDense: isDense,
      child: child,
    );
  }

  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final Widget? leading;
  final Widget? trailing;
  final Widget? child;
  final String? label;
  final AppButtonStyle? style;
  final bool loading;
  final bool expanded;
  final bool disabled;
  final AppButtonType type;
  final bool marquee;
  final bool isDense;

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? AppButtonStyle();

    Widget buildLabelWidget() {
      final textStyle = Theme.of(context).textTheme.button.semibold.copyWith(
        color: disabled ? style.disabledTitleColor : style.titleColor,
        // Some Thai characters lost its shape, consider remote permantly
        // height: isDense ? 1 : null,
      );
      final text = label ?? '';
      if (marquee) {
        return MarqueeText(text, style: textStyle, textAlign: TextAlign.center);
      }
      return Text(
        text,
        style: textStyle,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      );
    }

    List<Widget> buildRowChildren() {
      final children = <Widget>[];

      if (leading != null) {
        children.add(isDense ? leading! : Center(child: leading));
      }

      if (child != null) {
        final content = isDense
            ? child!
            : Expanded(
                flex: expanded ? 999 : 0,
                child: Center(child: child),
              );
        children.add(content);
      } else {
        final labelWidget = buildLabelWidget();
        final content = isDense
            ? Flexible(child: labelWidget)
            : Expanded(
                flex: expanded ? 999 : 0,
                child: Center(child: labelWidget),
              );
        children.add(content);
      }

      if (trailing != null) {
        children.add(trailing!);
      }
      return children;
    }

    Widget render = Stack(
      children: [
        Visibility(
          visible: !loading,
          maintainState: true,
          maintainAnimation: true,
          maintainSize: true,
          child: Row(
            spacing: _kDefaultChildSpacing,
            mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: expanded
                ? MainAxisAlignment.center
                : (isDense
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center),
            children: buildRowChildren(),
          ),
        ),
        if (loading)
          const Positioned.fill(
            child: Center(
              child: AppLoading(
                size: _kDefaultLoadingSize,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
    switch (type) {
      case AppButtonType.icon:
      case AppButtonType.filled:
      case AppButtonType.outlined:
        render = Container(
          padding: style.padding ?? _kDefaultPadding,
          decoration: BoxDecoration(
            color: disabled ? style.disabledColor : style.backgroundColor,
            border: Border.all(
              width: style.borderColor != null ? 1.0 : 0.0,
              color: disabled
                  ? (style.disabledBorderColor ?? Colors.transparent)
                  : (style.borderColor ?? Colors.transparent),
            ),
            borderRadius: style.borderRadius,
            shape: style.boxShape,
          ),
          child: render,
        );
      case AppButtonType.glassed:
        render = GlassContainer(
          padding: style.padding ?? _kDefaultPadding,
          decoration: GlassDecoration(
            backgroundColor: disabled
                ? style.disabledColor
                : style.backgroundColor ?? Colors.white24,
            underlyingColor: style.underlyingColor,
            borderRadius: style.borderRadius,
            boxShape: style.boxShape,
            blurEnabled: style.blurEnabled,
            blurValue: style.blurValue,
          ),
          child: render,
        );
    }

    return IgnorePointer(
      ignoring: disabled || loading,
      child: ScaleGestureDetector(
        onTap: onPressed,
        onLongPress: onLongPressed,
        child: render,
      ),
    );
  }
}
