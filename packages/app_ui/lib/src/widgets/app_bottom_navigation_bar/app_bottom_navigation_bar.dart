import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../scale_gesture_detector/scale_gesture_detector.dart';

const _kDefaultAnimationDuration = Duration(milliseconds: 120);
const _kBottomBarColor = Color(0xE5191E21);
const _kShadowColor = Color(0x40000000);
const _kWrapperRadius = 10.0;
const _indicatorSize = Size(75, 19);
const _indicatorShadowSize = Size(63, 21);
const _wrapperVerticalPadding = 4.0;
const _boxShadow = [
  BoxShadow(color: _kShadowColor, blurRadius: 5, offset: Offset(0, -2)),
];

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    required this.currentIndex,
    required this.onTabChanged,
    required this.items,
    this.duration = _kDefaultAnimationDuration,
    super.key,
  }) : assert(items.length >= 2, 'items length must more than 2');

  final int currentIndex;
  final ValueChanged<int> onTabChanged;
  final List<AppBottomNavigationBarItem> items;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: _wrapperVerticalPadding),
      decoration: const BoxDecoration(
        color: _kBottomBarColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(_kWrapperRadius),
        ),
        boxShadow: _boxShadow,
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items
              .mapIndexed(
                (index, item) => Stack(
                  alignment: AlignmentDirectional.center,
                  clipBehavior: Clip.none,
                  children: [
                    if (currentIndex == index)
                      Positioned(
                        top:
                            -_indicatorSize.height -
                            _wrapperVerticalPadding -
                            1,
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              width: _indicatorShadowSize.width,
                              height: _indicatorShadowSize.height,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.elliptical(
                                    _indicatorShadowSize.width / 2,
                                    _indicatorShadowSize.height,
                                  ),
                                ),
                                boxShadow: _boxShadow,
                              ),
                            ),
                            SvgPicture.asset(
                              'packages/nan_mobile_ui/assets/svgs/selected_tab_indicator.svg',
                              width: _indicatorSize.width,
                              height: _indicatorSize.height,
                            ),
                          ],
                        ),
                      ),
                    Tooltip(
                      message: item.tooltip,
                      child: ScaleGestureDetector(
                        delayDuration: duration,
                        duration: duration,
                        onTap: () => onTabChanged(index),
                        child: Badge(
                          smallSize: 8,
                          isLabelVisible: item.showBadge,
                          child: item.icon,
                        ),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class AppBottomNavigationBarItem {
  const AppBottomNavigationBarItem({
    required this.icon,
    this.key,
    this.label,
    String? tooltip,
    this.showBadge = false,
  }) : tooltip = tooltip ?? label;

  final Key? key;
  final Widget icon;
  final String? label;
  final String? tooltip;
  final bool showBadge;
}
