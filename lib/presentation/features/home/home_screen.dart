import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:v_clean_architecture/presentation/global_bloc/global_blocs.dart';

final class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.lg,
            vertical: Dimens.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Greeting
              _buildHeader(context),
              const Gap(Dimens.xl),

              // Featured Banner Card
              _buildFeaturedBanner(),
              const Gap(Dimens.xl),

              // Quick Stats Section
              _buildQuickStats(),
              const Gap(Dimens.xl),

              // Categories Section
              _buildCategoriesSection(),
              const Gap(Dimens.xl),

              // Recent Items Section
              _buildRecentItemsSection(),
              const Gap(Dimens.xl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<SessionBloc, SessionState>(
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
                  style: context.textTheme.headlineSmall?.semibold,
                ),
                const Gap(Dimens.xs),
                Text(
                  'Have a great day!',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.textTertiaryBlack,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildFeaturedBanner() {
    return AppBannerCard(
      subtitle: 'Special Offer',
      title: 'Get 20% OFF',
      description: 'on your next purchase',
      trailingIcon: Icons.local_offer_rounded,
      action: AppButton.outlined(
        label: 'Explore Now',
        onPressed: () {},
      ),
    );
  }

  Widget _buildQuickStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Stats',
          style: context.textTheme.headlineSmall?.semibold,
        ),
        const Gap(Dimens.md),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.trending_up_rounded,
                title: 'Growth',
                value: '125%',
                color: AppColors.success,
              ),
            ),
            const Gap(Dimens.md),
            Expanded(
              child: _buildStatCard(
                icon: Icons.star_rounded,
                title: 'Rating',
                value: '4.8',
                color: AppColors.warning,
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
                color: AppColors.accentBlue,
              ),
            ),
            const Gap(Dimens.md),
            Expanded(
              child: _buildStatCard(
                icon: Icons.favorite_rounded,
                title: 'Favorites',
                value: '18',
                color: AppColors.primary,
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
    return AppStatCard(
      icon: icon,
      title: title,
      value: value,
      iconColor: color,
    );
  }

  Widget _buildCategoriesSection() {
    final categories = [
      {'icon': Icons.shopping_cart_rounded, 'label': 'Shop'},
      {'icon': Icons.trending_up_rounded, 'label': 'Trending'},
      {'icon': Icons.favorite_rounded, 'label': 'Saved'},
      {'icon': Icons.notifications_rounded, 'label': 'Updates'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: context.textTheme.headlineSmall?.semibold,
        ),
        const Gap(Dimens.md),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: Dimens.md,
            mainAxisSpacing: Dimens.md,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return _buildCategoryTile(
              icon: category['icon'] as IconData,
              label: category['label'] as String,
            );
          },
        ),
      ],
    );
  }

  Widget _buildCategoryTile({
    required IconData icon,
    required String label,
  }) {
    return AppCategoryTile(
      icon: icon,
      label: label,
      onTap: () {},
    );
  }

  Widget _buildRecentItemsSection() {
    final recentItems = [
      {
        'title': 'Latest Collection',
        'subtitle': 'New arrivals',
        'icon': Icons.shopping_bag_rounded,
      },
      {
        'title': 'Summer Sale',
        'subtitle': 'Up to 50% off',
        'icon': Icons.local_fire_department_rounded,
      },
      {
        'title': 'Recommendations',
        'subtitle': 'Based on your activity',
        'icon': Icons.recommend_rounded,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Items',
          style: context.textTheme.headlineSmall?.semibold,
        ),
        const Gap(Dimens.md),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recentItems.length,
          separatorBuilder: (_, __) => const Gap(Dimens.md),
          itemBuilder: (context, index) {
            final item = recentItems[index];
            return _buildRecentItemTile(
              title: item['title'] as String,
              subtitle: item['subtitle'] as String,
              icon: item['icon'] as IconData,
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
  }) {
    return AppListTile(
      title: title,
      subtitle: subtitle,
      leadingIcon: icon,
      onTap: () {},
    );
  }
}
