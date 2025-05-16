import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_logo.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => context.go(RouteNames.menu),
        ),
        title: const Text(
          'Колдонуучу',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: Sizes.padding),
            child: AppLogo(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.primary.withOpacity(0.2),
                child: const Icon(Icons.person, size: 60, color: AppColors.primary),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Алымканов Марсбек Турсуналиевич',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '46 жаш',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            _buildInfoTile(
              icon: Icons.email_outlined,
              text: 'alimkang@mail.com',
            ),
            _buildInfoTile(
              icon: Icons.phone_outlined,
              text: '0707000000',
            ),
            _buildInfoTile(
              icon: Icons.settings_outlined,
              text: 'Параметрлер',
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => context.go(RouteNames.settings),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  static Widget _buildInfoTile({
    required IconData icon,
    required String text,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: AppColors.textPrimary,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}