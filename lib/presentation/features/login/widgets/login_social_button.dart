import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:v_clean_architecture/constants/constants.dart';
import 'package:v_clean_architecture/domain/entities/entities.dart';


class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    required this.provider,
    required this.onPressed,
    super.key,
  });

  final OAuthProvider provider;
  final VoidCallback onPressed;

  String get iconPath {
    switch (provider) {
      case OAuthProvider.google:
        return AssetConstants.icSocialGoogle;
      case OAuthProvider.line:
        return AssetConstants.icSocialLine;
      case OAuthProvider.apple:
        return AssetConstants.icSocialApple;
      case OAuthProvider.undefined:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppSocialButton(
      iconPath: iconPath,
      onPressed: onPressed,
    );
  }
}
