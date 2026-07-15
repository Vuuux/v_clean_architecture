import 'package:app_ui/app_ui.dart';
import 'package:app_ui/src/widgets/animated_floating_label/animated_floating_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _kDefaultBorderRadius = 16.0;

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.dismissKeyboardOnTapOutside = true,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines = 1,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.textInputAction,
    this.keyboardType,
    this.validator,
    this.autovalidateMode,
    this.inputFormatters,
    this.fillColor,
    this.textDisabledColor,
    this.inputColor,
    this.labelColor,
    this.hintColor,
    this.errorColor,
    this.prefixIconColor,
    this.suffixIconColor,
    this.borderRadius = _kDefaultBorderRadius,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enabled;
  final bool dismissKeyboardOnTapOutside;
  final int? maxLines;
  final int? minLines;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;
  final Color? inputColor;
  final Color? fillColor;
  final Color? labelColor;
  final Color? hintColor;
  final Color? errorColor;
  final Color? textDisabledColor;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final double borderRadius;
  final Duration animationDuration;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _isValidateError = false;
  bool _hasValue = false;
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);

    _hasValue = widget.controller?.text.isNotEmpty ?? false;
    _obscureText = widget.obscureText;

    // Listen to controller changes to update _hasValue
    widget.controller?.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    final hasValue = widget.controller?.text.isNotEmpty ?? false;
    if (_hasValue != hasValue) {
      setState(() {
        _hasValue = hasValue;
      });
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onControllerChanged);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_onFocusChange);
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _onTextChanged(String value) {
    final hasValue = value.isNotEmpty;
    if (_hasValue != hasValue) {
      setState(() {
        _hasValue = hasValue;
      });
    }
    widget.onChanged?.call(value);
  }

  Color _getLabelColor(BuildContext context) {
    if (widget.labelColor != null) {
      return widget.labelColor!;
    }

    if (widget.errorText != null || _isValidateError) {
      return widget.errorColor ?? AppColors.error;
    }

    if (!widget.enabled) {
      return AppColors.textDisabled;
    }

    if (_isFocused) {
      return AppColors.primary;
    }

    return AppColors.textSecondaryBlack;
  }

  Color get _fillColor {
    if (!widget.enabled) {
      return AppColors.bgOverlay;
    }

    if (widget.fillColor != null) {
      return widget.fillColor!;
    }

    return AppColors.white;
  }

  Color get _borderColor {
    if (widget.errorText != null || _isValidateError) {
      return AppColors.error;
    }

    if (!widget.enabled) {
      return AppColors.textDisabled;
    }

    if (_isFocused) {
      return AppColors.primary;
    }

    return AppColors.enabledBorderColor;
  }

  bool get _shouldShowLabelOnTop => _hasValue;

  String? get _effectiveHintText {
    if (_shouldShowLabelOnTop) {
      return widget.hintText;
    }
    return widget.hintText ?? widget.labelText;
  }

  Widget? get _suffixIcon {
    if (widget.obscureText) {
      return ScaleGestureDetector(
        onTap: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        child: Icon(
          _obscureText ? Icons.visibility_rounded : Icons.visibility_off,
          color: widget.suffixIconColor ?? AppColors.enabledBorderColor,
        ),
      );
    }
    if (widget.suffixIcon != null && widget.suffixIconColor != null) {
      return IconTheme(
        data: IconThemeData(color: widget.suffixIconColor),
        child: widget.suffixIcon!,
      );
    }
    return widget.suffixIcon;
  }

  Widget? get _prefixIcon {
    if (widget.prefixIcon != null && widget.prefixIconColor != null) {
      return IconTheme(
        data: IconThemeData(color: widget.prefixIconColor),
        child: widget.prefixIcon!,
      );
    }
    return widget.prefixIcon;
  }

  EdgeInsets get _contentPadding {
    if (widget.keyboardType == TextInputType.multiline) {
      return const EdgeInsets.all(Dimens.md);
    }
    return const EdgeInsets.symmetric(horizontal: Dimens.sm);
  }

  String? _handleOnValidate(String? value) {
    if (widget.validator == null) {
      return null;
    }

    final errorText = widget.validator!(value);

    // Schedule setState for next frame to avoid calling during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _isValidateError = errorText != null;
        });
      }
    });

    return errorText;
  }

  void _handleOnTapOutside(_) {
    if (widget.dismissKeyboardOnTapOutside) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  void didUpdateWidget(AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle controller change
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_onControllerChanged);
      widget.controller?.addListener(_onControllerChanged);
    }

    // Update _hasValue if controller text changed
    final hasValue = widget.controller?.text.isNotEmpty ?? false;
    if (_hasValue != hasValue) {
      setState(() {
        _hasValue = hasValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText != null)
          AnimatedFloatingLabel(
            shouldFloat: _shouldShowLabelOnTop,
            labelText: widget.labelText!,
            animationDuration: widget.animationDuration,
            labelColor: _getLabelColor(context),
          ),

        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          obscureText: _obscureText,
          enabled: widget.enabled,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          onTap: widget.onTap,
          onChanged: _onTextChanged,
          onTapOutside: _handleOnTapOutside,
          onFieldSubmitted: widget.onSubmitted,
          textInputAction: widget.textInputAction,
          keyboardType: widget.keyboardType,
          validator: _handleOnValidate,
          autovalidateMode: widget.autovalidateMode,
          inputFormatters: widget.inputFormatters,
          style: theme.textTheme.bodyMedium?.semibold.copyWith(
            color: widget.enabled
                ? widget.inputColor ?? AppColors.textPrimaryBlack
                : widget.textDisabledColor ?? AppColors.textDisabled,
          ),
          decoration: InputDecoration(
            hintText: _effectiveHintText,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color:
                  widget.hintColor ??
                  (widget.enabled
                      ? AppColors.textSecondaryBlack
                      : AppColors.textDisabled),
            ),
            prefixIcon: _prefixIcon,
            suffixIcon: _suffixIcon,
            filled: true,
            fillColor: _fillColor,
            contentPadding: _contentPadding,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(color: AppColors.enabledBorderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(color: _borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(color: _borderColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(color: AppColors.error, width: 2),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(color: AppColors.textDisabled),
            ),
            errorText: widget.errorText,
            errorStyle: theme.textTheme.bodySmall?.copyWith(
              color: widget.errorColor ?? AppColors.error,
            ),
          ),
        ),
      ],
    );
  }
}
