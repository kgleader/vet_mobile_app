import 'package:flutter/material.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';
import 'package:vet_mobile_app/core/app_logo.dart';
import 'package:vet_mobile_app/config/router/route_names.dart'; // Керек болсо
import 'package:go_router/go_router.dart'; // Керек болсо

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () {
            // Артка кайтуу логикасы, мисалы, негизги менюга
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(RouteNames.menu); // Же сиздин негизги меню маршрутуңуз
            }
          },
        ),
        title: Text(
          'Жаңылыктар',
          style: AppTextStyles.heading2.copyWith(color: AppColors.textPrimary),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: AppLogo(), // AppLogo виджетиңиз
          ),
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0, // Figma'да көлөкө жоктой көрүнөт
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMainNewsBanner(
              context,
              imagePath: 'assets/images/news_banner.png',
              title: 'Ветеринардык кызматтын жаңы багыттары',
              description: 'Азыркы учурда ветеринардык кызмат көрсөтүүнүн жаңы ыкмалары колдонулууда.',
              onReadMore: () {
                // "Кеңирирээк" басылгандагы окуя
                // Мисалы, жаңылыктын толук бетине өтүү
                // context.push(RouteNames.newsDetail, extra: newsId);
                print("Кеңирирээк басылды - негизги жаңылык");
              },
            ),
            const SizedBox(height: 24),
            Text(
              'Блогдор',
              style: AppTextStyles.heading3.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildBlogItem(
              context,
              imagePath: 'assets/images/news_topic1.png',
              title: 'Блогдун аталышы 1', // Figma'дагы "Blog post 1"
              postDate: '10.01.2023', // Figma'дагы "Posted on Jan 10"
              onTap: () {
                print("Блог 1 басылды");
                // context.push(RouteNames.blogDetail, extra: blogId1);
              },
            ),
            const SizedBox(height: 12),
            _buildBlogItem(
              context,
              imagePath: 'assets/images/news_topic2.png',
              title: 'Блогдун аталышы 2',
              postDate: '10.01.2023',
              onTap: () {
                print("Блог 2 басылды");
              },
            ),
            const SizedBox(height: 12),
            _buildBlogItem(
              context,
              imagePath: 'assets/images/news_topic3.png',
              title: 'Блогдун аталышы 3',
              postDate: '10.01.2023',
              onTap: () {
                print("Блог 3 басылды");
              },
            ),
            // Керек болсо дагы блог постторун кошуңуз
          ],
        ),
      ),
    );
  }

  Widget _buildMainNewsBanner(
    BuildContext context, {
    required String imagePath,
    required String title,
    required String description,
    required VoidCallback onReadMore,
  }) {
    return Card(
      elevation: 2.0, // Кичине көлөкө
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      clipBehavior: Clip.antiAlias, // Сүрөттүн бурчтарын кесүү үчүн
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            width: double.infinity,
            height: 180, // Бийиктигин тууралаңыз
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 180,
                color: Colors.grey[300],
                child: const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.heading3.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  // "Кеңирирээк" баскычын калыбына келтирүү
                  child: TextButton(
                    onPressed: onReadMore,
                    child: Text(
                      'Кеңирирээк',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.primary, 
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlogItem(
    BuildContext context, {
    required String imagePath,
    required String title,
    required String postDate,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  imagePath,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image_not_supported, size: 30, color: Colors.grey),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.bodyBold,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Жарыяланды: $postDate', // "Posted on Jan 10"
                      style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
