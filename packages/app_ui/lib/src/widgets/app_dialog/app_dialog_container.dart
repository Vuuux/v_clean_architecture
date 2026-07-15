part of 'app_dialog.dart';

const _kDefaultPadding = EdgeInsets.all(24);
const _kDefaultIconSize = 38.0;
const _wrapperShadow = [
  BoxShadow(
    color: Color(0x26000000),
    offset: Offset(0, 2),
    blurRadius: 5,
    spreadRadius: 1,
  ),
];

class AppDialogContainer extends StatelessWidget {
  const AppDialogContainer({
    super.key,
    this.icon,
    this.title,
    this.message,
    this.child,
    this.actions = const [],
    this.padding,
    this.margin = const EdgeInsets.all(Dimens.xl),
    this.decoration,
    this.actionDirection,
    this.backgroundColor,
  });

  final Widget? icon;
  final String? title;
  final String? message;
  final Widget? child;
  final EdgeInsets margin;
  final EdgeInsets? padding;
  final List<AppDialogAction> actions;
  final AppDialogDecoration? decoration;
  final Axis? actionDirection;
  final Color? backgroundColor;

  Axis get _actionDirection {
    return actionDirection ?? Axis.vertical;
  }

  void _popAction(BuildContext context) {
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final decoration = this.decoration ?? AppDialogDecoration();
    final actionButtons = Padding(
      padding: _actionDirection == Axis.vertical
          ? const EdgeInsets.symmetric(horizontal: Dimens.xl)
          : EdgeInsetsGeometry.zero,
      child: Flex(
        direction: _actionDirection,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: decoration.actionSpacing,
        children: actions
            .map(
              (action) => Expanded(
                flex: action.expanded && _actionDirection == Axis.horizontal
                    ? 1
                    : 0,
                child:
                    action.type == AppDialogActionType.filled ||
                        action.type == AppDialogActionType.filledPrimary
                    ? AppButton.filled(
                        label: action.label,
                        leading: action.leading,
                        trailing: action.trailing,
                        style: AppButtonStyle(
                          padding: const EdgeInsets.all(Dimens.xs),
                        ),
                        onPressed:
                            action.onPressed ?? () => _popAction(context),
                        expanded: action.expanded,
                      )
                    : action.type == AppDialogActionType.error
                    ? AppButton.filled(
                        label: action.label,
                        leading: action.leading,
                        trailing: action.trailing,
                        style: AppButtonStyle(
                          padding: const EdgeInsets.all(Dimens.xs),
                          backgroundColor: AppColors.error,
                        ),
                        onPressed:
                            action.onPressed ?? () => _popAction(context),
                        expanded: action.expanded,
                      )
                    : action.type == AppDialogActionType.filledSecondary
                    ? AppButton.filled(
                        label: action.label,
                        leading: action.leading,
                        trailing: action.trailing,
                        style: AppButtonStyle(
                          padding: const EdgeInsets.all(Dimens.xs),
                          backgroundColor: AppColors.bgLightGrey,
                          titleColor: AppColors.textPrimaryBlack,
                        ),
                        onPressed:
                            action.onPressed ?? () => _popAction(context),
                        expanded: action.expanded,
                      )
                    : AppButton.outlined(
                        label: action.label,
                        leading: action.leading,
                        trailing: action.trailing,
                        style: AppButtonStyle(
                          padding: const EdgeInsets.all(Dimens.xs),
                        ),
                        onPressed:
                            action.onPressed ?? () => _popAction(context),
                        expanded: action.expanded,
                      ),
              ),
            )
            .toList(),
      ),
    );

    return Container(
      constraints: const BoxConstraints(minHeight: 100),
      margin: margin,
      padding: padding ?? _kDefaultPadding,
      decoration: BoxDecoration(
        border: decoration.border,
        color: backgroundColor ?? decoration.backgroundColor ?? AppColors.white,
        borderRadius: decoration.borderRadius,
        boxShadow: _wrapperShadow,
      ),
      clipBehavior: Clip.antiAlias,
      width: MediaQuery.of(context).size.shortestSide,
      child: Material(
        color: Colors.transparent,
        child:
            child ??
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon ??
                    const Icon(
                      Icons.error_outline_rounded,
                      color: AppColors.warning,
                      size: _kDefaultIconSize,
                    ),
                const Gap(Dimens.md),
                if (title != null && title!.isNotEmpty)
                  Text(
                    title!,
                    textAlign: TextAlign.center,
                    style:
                        decoration.titleStyle ??
                        Theme.of(context).textTheme.h5.semibold,
                  ),
                if (message != null && message!.isNotEmpty) ...[
                  const Gap(Dimens.md),
                  Text(
                    message!,
                    textAlign: TextAlign.center,
                    style:
                        decoration.messageStyle ??
                        Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondaryBlack,
                        ),
                  ),
                ],
                if (actions.isNotEmpty) ...[
                  const Gap(Dimens.lg),
                  actionButtons,
                ],
              ],
            ),
      ),
    );
  }
}

enum AppDialogActionType {
  filled,
  outlined,
  error,
  filledPrimary,
  filledSecondary,
}

class AppDialogAction {
  AppDialogAction({
    required this.label,
    this.type = AppDialogActionType.filled,
    this.onPressed,
    this.leading,
    this.trailing,
    this.expanded = true,
  });

  final AppDialogActionType type;
  final String label;
  final VoidCallback? onPressed;
  final Widget? leading;
  final Widget? trailing;
  final bool expanded;
}

class AppDialogDecoration {
  AppDialogDecoration({
    this.titleStyle,
    this.messageStyle,
    this.border,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.backgroundColor,
    this.actionSpacing = 12,
  });

  factory AppDialogDecoration.defaultDecoration() {
    return AppDialogDecoration(
      borderRadius: BorderRadius.circular(Dimens.radiusXl),
    );
  }

  final TextStyle? titleStyle;
  final TextStyle? messageStyle;
  final BorderRadius borderRadius;
  final Color? backgroundColor;
  final BoxBorder? border;
  final double actionSpacing;
}
