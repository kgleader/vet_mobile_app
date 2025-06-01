// filepath: /Users/meerimakmatova/vet_mobile_app/lib/screens/menu/menu_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/config/constants/menu_constants.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_logo.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';
import 'package:vet_mobile_app/data/models/menu_item_model.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      // Removed SafeArea since we're handling padding in the GridView
      body: GridView.builder(
        padding: EdgeInsets.fromLTRB(
          Sizes.paddingL,
          Sizes.paddingL,
          Sizes.paddingL,
          100, // Extra bottom padding to avoid content being hidden by navigation bar
        ),
        itemCount: MenuConstants.menuItems.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: Sizes.menuCardSpacing,
          crossAxisSpacing: Sizes.menuCardSpacing,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          return _MenuCard(item: MenuConstants.menuItems[index]);
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.primary),
        // Заменяем context.pop() на навигацию на конкретный экран
        onPressed: () => context.go(RouteNames.register), // или используйте RouteNames.splash
      ),
      title: Text(
        'Меню',
        style: AppTextStyles.heading2.copyWith(color: AppColors.textPrimary),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: Sizes.paddingL),
          child: AppLogo(), // Simple clickable logo
        ),
      ],
    );
  }
}

class _MenuCard extends StatelessWidget {
  final MenuItemModel item;

  const _MenuCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go(item.route);
      },
      child: Container(
        width: Sizes.menuCardSize,
        height: Sizes.menuCardSize,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(Sizes.menuCardRadius),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/menu/${item.iconPath}',
              width: Sizes.menuIconSize,
              height: Sizes.menuIconSize,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}

// AppLogo moved to shared widgets
