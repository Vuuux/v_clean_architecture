import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:v_clean_architecture/domain/domain.dart';

final class Feature2Screen extends StatefulWidget {
  const Feature2Screen({required this.deepLinkType, super.key});
  final DeepLinkType? deepLinkType;

  @override
  State<Feature2Screen> createState() => _Feature2ScreenState();
}

class _Feature2ScreenState extends State<Feature2Screen>
    with TickerProviderStateMixin {
  late final AnimationController _glowController;
  late final Animation<double> _glowAnimation;
  final TextEditingController _searchController = TextEditingController();

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
    _searchController.dispose();
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.lg,
                  vertical: Dimens.md,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const Gap(Dimens.lg),
                    _buildSearchBar(),
                    const Gap(Dimens.xl),
                    _buildTrendingSection(),
                    const Gap(Dimens.xl),
                    _buildBrowseCategoriesSection(),
                    const Gap(Dimens.xl),
                    _buildPopularItemsSection(),
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
          top: -100,
          left: -150,
          child: Container(
            width: 350,
            height: 350,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF00EEFC).withValues(alpha: _glowAnimation.value * 0.12),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Explore',
          style: context.textTheme.h4.semibold.copyWith(
            color: Colors.white,
          ),
        ),
        const Gap(Dimens.xs),
        Text(
          'Discover something new today',
          style: context.textTheme.bodySmall?.copyWith(
            color: const Color(0xFFA9ABB3),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF161A21),
        borderRadius: BorderRadius.circular(Dimens.radiusMd),
        border: Border.all(
          color: const Color(0xFF22262F),
          width: 1,
        ),
      ),
      child: TextField(
        controller: _searchController,
        style: context.textTheme.bodyMedium?.copyWith(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: 'Search for products, brands...',
          hintStyle: context.textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF6B7280),
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Color(0xFF6B7280),
          ),
          suffixIcon: Container(
            margin: const EdgeInsets.all(Dimens.xs),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF85ADFF), Color(0xFF00EEFC)],
              ),
              borderRadius: BorderRadius.circular(Dimens.radiusSm),
            ),
            child: const Icon(
              Icons.tune_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: Dimens.md,
            vertical: Dimens.md,
          ),
        ),
      ),
    );
  }

  Widget _buildTrendingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Trending Now 🔥',
              style: context.textTheme.h6.semibold.copyWith(
                color: Colors.white,
              ),
            ),
            _buildSeeAllButton(),
          ],
        ),
        const Gap(Dimens.md),
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            separatorBuilder: (_, __) => const Gap(Dimens.md),
            itemBuilder: (context, index) {
              final items = [
                {'title': 'Summer Vibes', 'subtitle': '2.3k items', 'color': const Color(0xFF85ADFF)},
                {'title': 'Tech Gadgets', 'subtitle': '1.8k items', 'color': const Color(0xFF00EEFC)},
                {'title': 'Fashion Week', 'subtitle': '3.1k items', 'color': const Color(0xFFFF716C)},
                {'title': 'Home Decor', 'subtitle': '956 items', 'color': const Color(0xFFFFC107)},
              ];
              final item = items[index];
              return _buildTrendingCard(
                title: item['title'] as String,
                subtitle: item['subtitle'] as String,
                color: item['color'] as Color,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSeeAllButton() {
    return AppSeeAllButton(
      onPressed: () {},
    );
  }

  Widget _buildTrendingCard({
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          width: 140,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: 0.3),
                color.withValues(alpha: 0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(Dimens.radiusMd),
            border: Border.all(
              color: color.withValues(alpha: 0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: _glowAnimation.value * 0.2),
                blurRadius: 16,
                spreadRadius: 0,
              ),
            ],
          ),
          padding: const EdgeInsets.all(Dimens.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(Dimens.radiusSm),
                ),
                child: Icon(
                  Icons.trending_up_rounded,
                  color: color,
                  size: 22,
                ),
              ),
              const Spacer(),
              Text(
                title,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(Dimens.xxs),
              Text(
                subtitle,
                style: context.textTheme.labelMedium?.copyWith(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBrowseCategoriesSection() {
    final categories = [
      {'icon': Icons.devices_rounded, 'label': 'Electronics', 'color': const Color(0xFF00EEFC)},
      {'icon': Icons.checkroom_rounded, 'label': 'Fashion', 'color': const Color(0xFFFF716C)},
      {'icon': Icons.sports_basketball_rounded, 'label': 'Sports', 'color': const Color(0xFFFFC107)},
      {'icon': Icons.home_rounded, 'label': 'Home', 'color': const Color(0xFF85ADFF)},
      {'icon': Icons.auto_awesome_rounded, 'label': 'Beauty', 'color': const Color(0xFFE879F9)},
      {'icon': Icons.menu_book_rounded, 'label': 'Books', 'color': const Color(0xFF34D399)},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Browse Categories',
          style: context.textTheme.h6.semibold.copyWith(
            color: Colors.white,
          ),
        ),
        const Gap(Dimens.md),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: Dimens.sm,
            mainAxisSpacing: Dimens.sm,
            childAspectRatio: 1.1,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return _buildCategoryCard(
              icon: category['icon'] as IconData,
              label: category['label'] as String,
              color: category['color'] as Color,
            );
          },
        ),
      ],
    );
  }

  Widget _buildCategoryCard({
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
                width: 48,
                height: 48,
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
              const Gap(Dimens.sm),
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

  Widget _buildPopularItemsSection() {
    final items = [
      {
        'title': 'Wireless Earbuds Pro',
        'price': '\$129.99',
        'rating': '4.9',
        'reviews': '2.3k',
        'color': const Color(0xFF00EEFC),
      },
      {
        'title': 'Smart Watch Series X',
        'price': '\$299.00',
        'rating': '4.8',
        'reviews': '1.8k',
        'color': const Color(0xFF85ADFF),
      },
      {
        'title': 'Premium Backpack',
        'price': '\$79.50',
        'rating': '4.7',
        'reviews': '956',
        'color': const Color(0xFFFFC107),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Popular This Week',
              style: context.textTheme.h6.semibold.copyWith(
                color: Colors.white,
              ),
            ),
            _buildSeeAllButton(),
          ],
        ),
        const Gap(Dimens.md),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          separatorBuilder: (_, __) => const Gap(Dimens.sm),
          itemBuilder: (context, index) {
            final item = items[index];
            return _buildPopularItemCard(
              title: item['title'] as String,
              price: item['price'] as String,
              rating: item['rating'] as String,
              reviews: item['reviews'] as String,
              color: item['color'] as Color,
            );
          },
        ),
      ],
    );
  }

  Widget _buildPopularItemCard({
    required String title,
    required String price,
    required String rating,
    required String reviews,
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
                width: 72,
                height: 72,
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
                  Icons.shopping_bag_rounded,
                  color: color,
                  size: 32,
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
                    const Gap(Dimens.xs),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 16,
                          color: Color(0xFFFFC107),
                        ),
                        const Gap(Dimens.xxs),
                        Text(
                          rating,
                          style: context.textTheme.labelMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Gap(Dimens.xs),
                        Text(
                          '($reviews reviews)',
                          style: context.textTheme.labelMedium?.copyWith(
                            color: const Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                    const Gap(Dimens.xs),
                    Text(
                      price,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF00EEFC),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF85ADFF), Color(0xFF00EEFC)],
                  ),
                  borderRadius: BorderRadius.circular(Dimens.radiusSm),
                ),
                child: const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
