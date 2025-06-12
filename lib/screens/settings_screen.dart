// This file contains the Settings screen for the Veterinary Mobile App.
// It allows users to navigate to edit profile, change password, and sign out.
// The screen provides a clean and consistent interface for managing user settings.

import 'package:flutter/material.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/data/firebase/auth_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => context.go(RouteNames.profile),
        ),
        title: Text(
          'Параметрлер',
          style: AppTextStyles.heading2.copyWith(color: AppColors.textPrimary),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(Sizes.paddingL),
        children: [
          _buildSettingItem(
            context,
            icon: Icons.edit_outlined,
            title: 'Профилди оңдоо',
            onTap: () => context.go(RouteNames.editProfileScreen),          ),
          _buildSettingItem(
            context,
            icon: Icons.lock_outline,
            title: 'Сыр сөздү өзгөртүү',
            onTap: () => context.go(RouteNames.forgotPassword),
          ),
          
          _buildSettingItem(
            context,
            icon: Icons.exit_to_app,
            title: 'Чыгуу',
            color: Colors.red,
            onTap: () async {
              try {
                final authService = AuthService();
                await authService.signOut();
                if (context.mounted) {
                  context.go(RouteNames.login);
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Чыгууда ката кетти: $e')),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    Color? color,
    VoidCallback? onTap,
  }) {
    return Card(
      color: color != null ? color.withOpacity(0.05) : Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.cardRadius),
        side: BorderSide(color: AppColors.primary.withOpacity(0.07)),
      ),
      margin: const EdgeInsets.only(bottom: Sizes.spacingM),
      child: ListTile(
        leading: Icon(icon, color: color ?? AppColors.primary),
        title: Text(
          title,
          style: AppTextStyles.bodyMedium.copyWith(
            color: color ?? AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              )
            : null,
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}