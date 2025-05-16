import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';
import 'package:vet_mobile_app/core/bottom_bar.dart';

class CategoryScreen extends StatelessWidget {
  final String title;
  final String iconPath;
  final List<String> topics;

  const CategoryScreen({
    super.key,
    required this.title,
    required this.iconPath,
    required this.topics,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/menu'),
        ),
        actions: [
          GestureDetector(
            onTap: () => context.go('/profile'),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Image.asset(
                'assets/icons/common/logo.png',
                width: 40,
                height: 40,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: topics.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                topics[index],
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primary,
                size: 16,
              ),
              onTap: () {
                // Переход к деталям темы
              },
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomBar(currentIndex: 1),
    );
  }
}