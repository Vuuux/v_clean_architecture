import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// A notification icon with optional badge indicator.
///
/// This widget displays an icon button with an optional notification badge.
class AppNotificationBadge extends StatelessWidget {
  const AppNotificationBadge({
    this.icon = Icons.notifications_outlined,
    this.showBadge = false,
    this.badgeColor,
    this.iconColor,
    this.backgroundColor,
    this.borderColor,
    this.onTap,
    this.size = 48.0,
    this.iconSize = 24.0,
    this.badgeSize = 10.0,
    this.borderRadius,
    super.key,
  });

  /// The notification icon
  final IconData icon;

  /// Whether to show the badge
  final bool showBadge;

  /// Badge color
  final Color? badgeColor;

  /// Icon color
  final Color? iconColor;

  /// Background color
  final Color? backgroundColor;

  /// Border color
  final Color? borderColor;

  /// Callback when tapped
  final VoidCallback? onTap;

  /// Size of the container
  final double size;

  /// Size of the icon
  final double iconSize;

  /// Size of the badge
  final double badgeSize;

  /// Border radius
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? Dimens.radiusSm;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: backgroundColor ?? const Color(0xFF161A21),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: borderColor ?? const Color(0xFF22262F),
              width: 1,
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: Icon(
                  icon,
                  color: iconColor ?? Colors.white,
                  size: iconSize,
                ),
              ),
              if (showBadge)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: badgeSize,
                    height: badgeSize,
                    decoration: BoxDecoration(
                      color: badgeColor ?? const Color(0xFFFF716C),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

