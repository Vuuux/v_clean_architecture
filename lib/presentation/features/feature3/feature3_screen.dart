import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

final class Feature3Screen extends StatefulWidget {
  const Feature3Screen({super.key});

  @override
  State<Feature3Screen> createState() => _Feature3ScreenState();
}

class _Feature3ScreenState extends State<Feature3Screen>
    with TickerProviderStateMixin {
  late final AnimationController _glowController;
  late final Animation<double> _glowAnimation;
  int _selectedFilterIndex = 0;

  final List<String> _filters = ['All', 'Orders', 'Payments', 'Updates'];

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.3, end: 0.6).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0B0E14),
              Color(0xFF10131A),
              Color(0xFF161A21),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            _buildBackgroundGlow(),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(Dimens.lg),
                    child: _buildHeader(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.lg),
                    child: _buildFilterTabs(),
                  ),
                  const Gap(Dimens.lg),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: Dimens.lg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTodaySection(),
                          const Gap(Dimens.xl),
                          _buildYesterdaySection(),
                          const Gap(Dimens.xl),
                          _buildEarlierSection(),
                          const Gap(Dimens.xl),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundGlow() {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Positioned(
          top: -50,
          right: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  const Color(0xFFFFC107).withValues(alpha: _glowAnimation.value * 0.1),
                  Colors.transparent,
                ],
                radius: 0.8,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Activity',
              style: context.textTheme.h4.semibold.copyWith(
                color: Colors.white,
              ),
            ),
            const Gap(Dimens.xs),
            Text(
              'Your recent activity history',
              style: context.textTheme.bodySmall?.copyWith(
                color: const Color(0xFFA9ABB3),
              ),
            ),
          ],
        ),
        _buildNotificationBadge(),
      ],
    );
  }

  Widget _buildNotificationBadge() {
    return AppNotificationBadge(
      showBadge: true,
      onTap: () {},
    );
  }

  Widget _buildFilterTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_filters.length, (index) {
          final isSelected = _selectedFilterIndex == index;
          return Padding(
            padding: EdgeInsets.only(right: index < _filters.length - 1 ? Dimens.sm : 0),
            child: AppFilterChip(
              label: _filters[index],
              isSelected: isSelected,
              onTap: () => setState(() => _selectedFilterIndex = index),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTodaySection() {
    return _buildActivitySection(
      title: 'Today',
      activities: [
        _ActivityItem(
          icon: Icons.shopping_bag_rounded,
          title: 'Order Delivered',
          subtitle: 'Your order #12345 has been delivered',
          time: '2 hours ago',
          color: const Color(0xFF34D399),
          type: ActivityType.success,
        ),
        _ActivityItem(
          icon: Icons.payment_rounded,
          title: 'Payment Successful',
          subtitle: 'Payment of \$129.99 completed',
          time: '4 hours ago',
          color: const Color(0xFF00EEFC),
          type: ActivityType.info,
        ),
      ],
    );
  }

  Widget _buildYesterdaySection() {
    return _buildActivitySection(
      title: 'Yesterday',
      activities: [
        _ActivityItem(
          icon: Icons.local_shipping_rounded,
          title: 'Order Shipped',
          subtitle: 'Your order #12345 is on the way',
          time: 'Yesterday, 3:45 PM',
          color: const Color(0xFF85ADFF),
          type: ActivityType.info,
        ),
        _ActivityItem(
          icon: Icons.discount_rounded,
          title: 'New Coupon Available',
          subtitle: 'Get 15% off on your next order',
          time: 'Yesterday, 10:30 AM',
          color: const Color(0xFFFFC107),
          type: ActivityType.promo,
        ),
        _ActivityItem(
          icon: Icons.favorite_rounded,
          title: 'Item Back in Stock',
          subtitle: 'Wireless Earbuds Pro is available now',
          time: 'Yesterday, 8:15 AM',
          color: const Color(0xFFFF716C),
          type: ActivityType.alert,
        ),
      ],
    );
  }

  Widget _buildEarlierSection() {
    return _buildActivitySection(
      title: 'Earlier This Week',
      activities: [
        _ActivityItem(
          icon: Icons.star_rounded,
          title: 'Review Reminder',
          subtitle: 'Share your feedback on recent purchase',
          time: 'Mon, 2:00 PM',
          color: const Color(0xFFFFC107),
          type: ActivityType.info,
        ),
        _ActivityItem(
          icon: Icons.account_circle_rounded,
          title: 'Profile Updated',
          subtitle: 'Your profile information was updated',
          time: 'Sun, 11:30 AM',
          color: const Color(0xFF85ADFF),
          type: ActivityType.info,
        ),
      ],
    );
  }

  Widget _buildActivitySection({
    required String title,
    required List<_ActivityItem> activities,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.h6.semibold.copyWith(
            color: Colors.white,
          ),
        ),
        const Gap(Dimens.md),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: activities.length,
          separatorBuilder: (_, __) => const Gap(Dimens.sm),
          itemBuilder: (context, index) {
            return _buildActivityCard(activities[index]);
          },
        ),
      ],
    );
  }

  Widget _buildActivityCard(_ActivityItem activity) {
    return AppActivityCard(
      icon: activity.icon,
      title: activity.title,
      subtitle: activity.subtitle,
      time: activity.time,
      color: activity.color,
      onTap: () {},
    );
  }
}

enum ActivityType { success, info, alert, promo }

class _ActivityItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;
  final Color color;
  final ActivityType type;

  _ActivityItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.color,
    required this.type,
  });
}
