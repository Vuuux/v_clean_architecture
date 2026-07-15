
import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:v_clean_architecture/presentation/global_bloc/global_blocs.dart';

final class Feature1Screen extends StatefulWidget {
  const Feature1Screen({super.key});

  @override
  State<Feature1Screen> createState() => _Feature1ScreenState();
}

class _Feature1ScreenState extends State<Feature1Screen>
    with TickerProviderStateMixin {
  late final AnimationController _glowController;
  late final Animation<double> _glowAnimation;

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
            // Animated background glow
            _buildBackgroundGlow(),
            // Main content
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.lg,
                  vertical: Dimens.md,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    const Gap(Dimens.xl),
                    _buildFeaturedBanner(),
                    const Gap(Dimens.xl),
                    _buildQuickStats(),
                    const Gap(Dimens.xl),
                    _buildCategoriesSection(),
                    const Gap(Dimens.xl),
                    _buildRecentItemsSection(),
                    const Gap(Dimens.xl),
                  ],
                ),
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
          top: -150,
          right: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF85ADFF).withValues(alpha: _glowAnimation.value * 0.15),
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

  Widget _buildHeader(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) {
        String userName = 'Welcome';
        if (state is SessionFetchUserDataSuccess) {
          userName = state.userData?.username ?? 'User';
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, $userName 👋',
              style: context.textTheme.h5.semibold.copyWith(
                color: Colors.white,
              ),
            ),
            const Gap(Dimens.xs),
            Text(
              'Have a great day!',
              style: context.textTheme.bodySmall?.copyWith(
                color: const Color(0xFFA9ABB3),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFeaturedBanner() {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimens.radiusMd),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF85ADFF),
                Color(0xFF00EEFC),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF85ADFF).withValues(alpha: _glowAnimation.value),
                blurRadius: 24,
                spreadRadius: 0,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.all(Dimens.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SPECIAL OFFER',
                          style: context.textTheme.labelMedium?.copyWith(
                            color: Colors.white70,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Gap(Dimens.xs),
                        Text(
                          'Get 20% OFF',
                          style: context.textTheme.h5.semibold.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const Gap(Dimens.sm),
                        Text(
                          'on your next purchase',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(Dimens.radiusMd),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.local_offer_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ],
              ),
              const Gap(Dimens.lg),
              _buildGlassButton(
                label: 'Explore Now',
                onPressed: () {},
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGlassButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(Dimens.radiusSm),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.lg,
            vertical: Dimens.sm,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(Dimens.radiusSm),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Stats',
          style: context.textTheme.h6.semibold.copyWith(
            color: Colors.white,
          ),
        ),
        const Gap(Dimens.md),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.trending_up_rounded,
                title: 'Growth',
                value: '125%',
                color: const Color(0xFF00EEFC),
              ),
            ),
            const Gap(Dimens.md),
            Expanded(
              child: _buildStatCard(
                icon: Icons.star_rounded,
                title: 'Rating',
                value: '4.8',
                color: const Color(0xFFFFC107),
              ),
            ),
          ],
        ),
        const Gap(Dimens.md),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.shopping_bag_rounded,
                title: 'Purchases',
                value: '42',
                color: const Color(0xFF85ADFF),
              ),
            ),
            const Gap(Dimens.md),
            Expanded(
              child: _buildStatCard(
                icon: Icons.favorite_rounded,
                title: 'Favorites',
                value: '18',
                color: const Color(0xFFFF716C),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF161A21),
            borderRadius: BorderRadius.circular(Dimens.radiusMd),
            border: Border.all(
              color: color.withValues(alpha: 0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: _glowAnimation.value * 0.15),
                blurRadius: 16,
                spreadRadius: 0,
              ),
            ],
          ),
          padding: const EdgeInsets.all(Dimens.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color.withValues(alpha: 0.2),
                      color.withValues(alpha: 0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(Dimens.radiusSm),
                  border: Border.all(
                    color: color.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const Gap(Dimens.md),
              Text(
                value,
                style: context.textTheme.h5.semibold.copyWith(
                  color: Colors.white,
                ),
              ),
              const Gap(Dimens.xxs),
              Text(
                title,
                style: context.textTheme.labelMedium?.copyWith(
                  color: const Color(0xFFA9ABB3),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoriesSection() {
    final categories = [
      {'icon': Icons.shopping_cart_rounded, 'label': 'Shop', 'color': const Color(0xFF85ADFF)},
      {'icon': Icons.trending_up_rounded, 'label': 'Trending', 'color': const Color(0xFF00EEFC)},
      {'icon': Icons.favorite_rounded, 'label': 'Saved', 'color': const Color(0xFFFF716C)},
      {'icon': Icons.notifications_rounded, 'label': 'Updates', 'color': const Color(0xFFFFC107)},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: context.textTheme.h6.semibold.copyWith(
            color: Colors.white,
          ),
        ),
        const Gap(Dimens.md),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: Dimens.sm,
            mainAxisSpacing: Dimens.sm,
            childAspectRatio: 0.85,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return _buildCategoryTile(
              icon: category['icon'] as IconData,
              label: category['label'] as String,
              color: category['color'] as Color,
            );
          },
        ),
      ],
    );
  }

  Widget _buildCategoryTile({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(Dimens.radiusMd),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF161A21),
            borderRadius: BorderRadius.circular(Dimens.radiusMd),
            border: Border.all(
              color: const Color(0xFF22262F),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color.withValues(alpha: 0.2),
                      color.withValues(alpha: 0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(Dimens.radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 22,
                ),
              ),
              const Gap(Dimens.xs),
              Text(
                label,
                style: context.textTheme.labelMedium?.copyWith(
                  color: const Color(0xFFA9ABB3),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentItemsSection() {
    final recentItems = [
      {
        'title': 'Latest Collection',
        'subtitle': 'New arrivals',
        'icon': Icons.shopping_bag_rounded,
        'color': const Color(0xFF85ADFF),
      },
      {
        'title': 'Summer Sale',
        'subtitle': 'Up to 50% off',
        'icon': Icons.local_fire_department_rounded,
        'color': const Color(0xFFFF716C),
      },
      {
        'title': 'Recommendations',
        'subtitle': 'Based on your activity',
        'icon': Icons.recommend_rounded,
        'color': const Color(0xFF00EEFC),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Items',
          style: context.textTheme.h6.semibold.copyWith(
            color: Colors.white,
          ),
        ),
        const Gap(Dimens.md),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recentItems.length,
          separatorBuilder: (_, __) => const Gap(Dimens.sm),
          itemBuilder: (context, index) {
            final item = recentItems[index];
            return _buildRecentItemTile(
              title: item['title'] as String,
              subtitle: item['subtitle'] as String,
              icon: item['icon'] as IconData,
              color: item['color'] as Color,
            );
          },
        ),
      ],
    );
  }

  Widget _buildRecentItemTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(Dimens.radiusMd),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF161A21),
            borderRadius: BorderRadius.circular(Dimens.radiusMd),
            border: Border.all(
              color: const Color(0xFF22262F),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(Dimens.md),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color.withValues(alpha: 0.2),
                      color.withValues(alpha: 0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(Dimens.radiusSm),
                  border: Border.all(
                    color: color.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 26,
                ),
              ),
              const Gap(Dimens.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const Gap(Dimens.xxs),
                    Text(
                      subtitle,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: const Color(0xFFA9ABB3),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF22262F),
                  borderRadius: BorderRadius.circular(Dimens.radiusXs),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: Color(0xFFA9ABB3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
