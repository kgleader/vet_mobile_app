import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/core/app_logo.dart';

class SheepGoatsScreen extends StatelessWidget {
  final int bottomBarCurrentIndex;
  
  const SheepGoatsScreen({super.key, this.bottomBarCurrentIndex = 0});

  @override
  Widget build(BuildContext context) {
    final String bannerImagePath = "assets/images/sheep_banner.jpg";
    final String bannerDescription = "Кой жана эчки чарбачылыгы";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => GoRouter.of(context).go(RouteNames.menu),
        ),
        title: const Text(
          "Кой эчки",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: Sizes.paddingL),
            child: AppLogo(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              // Стандарттык баннердик сүрөт
              Container(
                margin: const EdgeInsets.all(16),
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(bannerImagePath),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                  child: Text(
                    bannerDescription,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Кнопка "Тыштангыруу"
              _buildActionButton(
                title: 'Тыштангыруу',
                icon: Icons.grass_outlined,
                isActive: false,
                onTap: () => GoRouter.of(context).go(RouteNames.feed),
              ),
              
              const SizedBox(height: 16),
              
              // Кнопка "Ооруусу"
              _buildActionButton(
                title: 'Ооруусу',
                icon: Icons.medical_services_outlined,
                isActive: true,
                onTap: () => GoRouter.of(context).go(RouteNames.diseases),
              ),
              
              const SizedBox(height: 16),
              
              // Кнопка "Уруктандыруу"
              _buildActionButton(
                title: 'Уруктандыруу',
                icon: Icons.spa_outlined,
                isActive: false,
                onTap: () => GoRouter.of(context).go(RouteNames.insemination),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildActionButton({
    required String title,
    required IconData icon,  // Changed from String iconPath to IconData icon
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF38A169) : Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFFEDF2F7),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Icon(
                  icon,  // Using Icon widget instead of SvgPicture
                  size: 24,
                  color: isActive ? Colors.white : const Color(0xFF38A169),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: isActive ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
