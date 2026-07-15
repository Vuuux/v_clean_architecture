import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:v_clean_architecture/constants/route_names.dart';
import 'package:v_clean_architecture/domain/entities/app_user_entity.dart';
import 'package:v_clean_architecture/presentation/global_bloc/global_blocs.dart';

final class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
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
                    const Gap(Dimens.xl),
                    _buildProfileCard(),
                    const Gap(Dimens.xl),
                    _buildAccountSection(),
                    const Gap(Dimens.lg),
                    _buildPreferencesSection(),
                    const Gap(Dimens.lg),
                    _buildSupportSection(),
                    const Gap(Dimens.xl),
                    _buildLogoutButton(),
                    const Gap(Dimens.lg),
                    _buildVersionInfo(),
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
          left: -50,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF85ADFF).withValues(alpha: _glowAnimation.value * 0.12),
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
    return Text(
      'Settings',
      style: context.textTheme.h4.semibold.copyWith(
        color: Colors.white,
      ),
    );
  }

  Widget _buildProfileCard() {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) {
        AppUser? user;
        if (state is SessionFetchUserDataSuccess) {
          user = state.userData;
        }

        return AnimatedBuilder(
          animation: _glowAnimation,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF161A21),
                    const Color(0xFF1A1F28),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(Dimens.radiusMd),
                border: Border.all(
                  color: const Color(0xFF85ADFF).withValues(alpha: 0.2),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF85ADFF).withValues(alpha: _glowAnimation.value * 0.1),
                    blurRadius: 20,
                    spreadRadius: 0,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(Dimens.lg),
              child: Row(
                children: [
                  _buildAvatar(user),
                  const Gap(Dimens.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.displayFullName ?? user?.username ?? 'Guest User',
                          style: context.textTheme.h6.semibold.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const Gap(Dimens.xxs),
                        Text(
                          user?.email ?? 'No email',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: const Color(0xFFA9ABB3),
                          ),
                        ),
                        const Gap(Dimens.sm),
                        _buildEditProfileButton(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildAvatar(AppUser? user) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Color(0xFF85ADFF), Color(0xFF00EEFC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF85ADFF).withValues(alpha: 0.3),
            blurRadius: 16,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(3),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF161A21),
        ),
        child: ClipOval(
          child: user?.fullAvatarUrl.isNotEmpty == true
              ? Image.network(
                  user!.fullAvatarUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => _buildAvatarPlaceholder(user),
                )
              : _buildAvatarPlaceholder(user),
        ),
      ),
    );
  }

  Widget _buildAvatarPlaceholder(AppUser? user) {
    final initial = (user?.username ?? 'G').isNotEmpty
        ? (user?.username ?? 'G')[0].toUpperCase()
        : 'G';
    return Container(
      color: const Color(0xFF22262F),
      child: Center(
        child: Text(
          initial,
          style: context.textTheme.h4.semibold.copyWith(
            color: const Color(0xFF85ADFF),
          ),
        ),
      ),
    );
  }

  Widget _buildEditProfileButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(Dimens.radiusSm),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.md,
            vertical: Dimens.xs,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF85ADFF), Color(0xFF00EEFC)],
            ),
            borderRadius: BorderRadius.circular(Dimens.radiusSm),
          ),
          child: Text(
            'Edit Profile',
            style: context.textTheme.labelMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAccountSection() {
    return _buildSettingsSection(
      title: 'Account',
      items: [
        _SettingsItem(
          icon: Icons.person_outline_rounded,
          title: 'Personal Information',
          subtitle: 'Name, email, phone number',
          color: const Color(0xFF85ADFF),
          onTap: () {},
        ),
        _SettingsItem(
          icon: Icons.security_rounded,
          title: 'Security',
          subtitle: 'Password, 2FA, biometrics',
          color: const Color(0xFF00EEFC),
          onTap: () {},
        ),
        _SettingsItem(
          icon: Icons.payment_rounded,
          title: 'Payment Methods',
          subtitle: 'Cards, bank accounts',
          color: const Color(0xFF34D399),
          onTap: () {},
        ),
        _SettingsItem(
          icon: Icons.location_on_outlined,
          title: 'Addresses',
          subtitle: 'Shipping, billing addresses',
          color: const Color(0xFFFFC107),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildPreferencesSection() {
    return _buildSettingsSection(
      title: 'Preferences',
      items: [
        _SettingsItem(
          icon: Icons.notifications_outlined,
          title: 'Notifications',
          subtitle: 'Push, email, SMS',
          color: const Color(0xFFFF716C),
          onTap: () {},
          trailing: _buildToggle(true),
        ),
        _SettingsItem(
          icon: Icons.dark_mode_outlined,
          title: 'Appearance',
          subtitle: 'Dark mode',
          color: const Color(0xFFE879F9),
          onTap: () {},
          trailing: _buildToggle(true),
        ),
        _SettingsItem(
          icon: Icons.language_rounded,
          title: 'Language',
          subtitle: 'English',
          color: const Color(0xFF85ADFF),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSupportSection() {
    return _buildSettingsSection(
      title: 'Support',
      items: [
        _SettingsItem(
          icon: Icons.help_outline_rounded,
          title: 'Help Center',
          subtitle: 'FAQs, contact support',
          color: const Color(0xFF00EEFC),
          onTap: () {},
        ),
        _SettingsItem(
          icon: Icons.description_outlined,
          title: 'Terms of Service',
          subtitle: 'Legal information',
          color: const Color(0xFFA9ABB3),
          onTap: () {},
        ),
        _SettingsItem(
          icon: Icons.privacy_tip_outlined,
          title: 'Privacy Policy',
          subtitle: 'How we handle your data',
          color: const Color(0xFFA9ABB3),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required List<_SettingsItem> items,
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
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF161A21),
            borderRadius: BorderRadius.circular(Dimens.radiusMd),
            border: Border.all(
              color: const Color(0xFF22262F),
              width: 1,
            ),
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  _buildSettingsItem(item),
                  if (index < items.length - 1)
                    Divider(
                      height: 1,
                      color: const Color(0xFF22262F),
                      indent: Dimens.lg + 48,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsItem(_SettingsItem item) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(Dimens.radiusMd),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.md),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      item.color.withValues(alpha: 0.2),
                      item.color.withValues(alpha: 0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(Dimens.radiusSm),
                  border: Border.all(
                    color: item.color.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Icon(
                  item.icon,
                  color: item.color,
                  size: 22,
                ),
              ),
              const Gap(Dimens.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const Gap(Dimens.xxs),
                    Text(
                      item.subtitle,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              item.trailing ?? const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF6B7280),
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggle(bool value) {
    return Container(
      width: 48,
      height: 28,
      decoration: BoxDecoration(
        gradient: value
            ? const LinearGradient(
                colors: [Color(0xFF85ADFF), Color(0xFF00EEFC)],
              )
            : null,
        color: value ? null : const Color(0xFF22262F),
        borderRadius: BorderRadius.circular(Dimens.radiusRounded),
      ),
      padding: const EdgeInsets.all(2),
      child: Align(
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _showLogoutDialog,
        borderRadius: BorderRadius.circular(Dimens.radiusMd),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: Dimens.md),
          decoration: BoxDecoration(
            color: const Color(0xFF161A21),
            borderRadius: BorderRadius.circular(Dimens.radiusMd),
            border: Border.all(
              color: const Color(0xFFFF716C).withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout_rounded,
                color: const Color(0xFFFF716C),
                size: 22,
              ),
              const Gap(Dimens.sm),
              Text(
                'Log Out',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFFFF716C),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVersionInfo() {
    return Center(
      child: Column(
        children: [
          Text(
            'Version 1.0.0',
            style: context.textTheme.labelMedium?.copyWith(
              color: const Color(0xFF6B7280),
            ),
          ),
          const Gap(Dimens.xxs),
          Text(
            'Made with ❤️',
            style: context.textTheme.labelMedium?.copyWith(
              color: const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog<void>(
      context: context,
      barrierColor: const Color(0xFF0B0E14).withValues(alpha: 0.8),
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(Dimens.lg),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF161A21),
                Color(0xFF1A1F28),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(Dimens.radiusMd),
            border: Border.all(
              color: const Color(0xFF22262F),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF85ADFF).withValues(alpha: 0.1),
                blurRadius: 24,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFFF716C).withValues(alpha: 0.2),
                      const Color(0xFFFF716C).withValues(alpha: 0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFFF716C).withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.logout_rounded,
                  color: Color(0xFFFF716C),
                  size: 32,
                ),
              ),
              const Gap(Dimens.lg),
              Text(
                'Log Out?',
                style: context.textTheme.h6.semibold.copyWith(
                  color: Colors.white,
                ),
              ),
              const Gap(Dimens.sm),
              Text(
                'Are you sure you want to log out of your account?',
                style: context.textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFA9ABB3),
                ),
                textAlign: TextAlign.center,
              ),
              const Gap(Dimens.xl),
              Row(
                children: [
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Navigator.of(dialogContext).pop(),
                        borderRadius: BorderRadius.circular(Dimens.radiusSm),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: Dimens.md),
                          decoration: BoxDecoration(
                            color: const Color(0xFF22262F),
                            borderRadius: BorderRadius.circular(Dimens.radiusSm),
                          ),
                          child: Center(
                            child: Text(
                              'Cancel',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(Dimens.md),
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(dialogContext).pop();
                          _performLogout();
                        },
                        borderRadius: BorderRadius.circular(Dimens.radiusSm),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: Dimens.md),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFF716C), Color(0xFFFF8A80)],
                            ),
                            borderRadius: BorderRadius.circular(Dimens.radiusSm),
                          ),
                          child: Center(
                            child: Text(
                              'Log Out',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _performLogout() {
    context.read<SessionBloc>().add(const SessionLogoutRequested());
    context.goNamed(RouteNames.login);
  }
}

class _SettingsItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  final Widget? trailing;

  _SettingsItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
    this.trailing,
  });
}
