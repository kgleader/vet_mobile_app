import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;

  const BottomBar({
    required this.currentIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.bottomBarHeight,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.home_outlined,
            isSelected: currentIndex == 0,
            onTap: () => context.go(RouteNames.home),
          ),
          _buildNavItem(
            icon: Icons.article_outlined,
            isSelected: currentIndex == 1,
            onTap: () => context.go(RouteNames.menu),
          ),
          _buildNavItem(
            icon: Icons.person_outline,
            isSelected: currentIndex == 2,
            onTap: () => context.go(RouteNames.profile),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        icon,
        color: Colors.white,
        size: Sizes.bottomBarIconSize,
      ),
    );
  }
}