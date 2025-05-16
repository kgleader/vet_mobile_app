import 'package:flutter/material.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/core/app_logo.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(); // ПУСТОЕ поле
    final dateController = TextEditingController(text: '4 май, 1976');
    final String? avatarUrl = null; // Замените на реальный url или null

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: AppColors.primary),
        title: const Text(
    'Профилди оңдоо',
    style: TextStyle(
      color: AppColors.textPrimary,
      fontSize: 15, // уменьшите размер шрифта здесь (например, 16 или 18)
      fontWeight: FontWeight.w600,
    ),
    textAlign: TextAlign.center,
  ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: Sizes.padding),
            child: AppLogo(),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          const SizedBox(height: 30),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Зеленая рамка вокруг аватара
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary,
                      width: 1,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.white,
                    backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
                    child: avatarUrl == null
                        ? null // Пусто, если нет фото
                        : null,
                  ),
                ),
                // Кнопка редактирования
                Positioned(
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white, size: 20),
                      onPressed: () {
                        // TODO: реализовать выбор фото
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'Алыпканов Марсбек Турсуналиевич',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          Text('Толук аты', style: AppTextStyles.bodySmall),
          const SizedBox(height: 8),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'Толук атыңызды жазыңыз',
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Sizes.inputRadius),
                borderSide: BorderSide(color: AppColors.primary.withOpacity(0.2)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Sizes.inputRadius),
                borderSide: BorderSide(color: AppColors.primary.withOpacity(0.2)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Sizes.inputRadius),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text('Туулган датасы', style: AppTextStyles.bodySmall),
          const SizedBox(height: 8),
          TextField(
            controller: dateController,
            readOnly: true,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.calendar_today, color: AppColors.primary),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Sizes.inputRadius),
                borderSide: BorderSide(color: AppColors.primary.withOpacity(0.2)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Sizes.inputRadius),
                borderSide: BorderSide(color: AppColors.primary.withOpacity(0.2)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Sizes.inputRadius),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
            ),
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode()); // чтобы не показывалась клавиатура
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime(1976, 5, 4),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                locale: const Locale('ru', ''), // для кириллических месяцев
              );
              if (picked != null) {
                final months = [
                  'январь', 'февраль', 'март', 'апрель', 'май', 'июнь',
                  'июль', 'август', 'сентябрь', 'октябрь', 'ноябрь', 'декабрь'
                ];
                dateController.text =
                    '${picked.day} ${months[picked.month - 1]}, ${picked.year}';
              }
            },
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.buttonRadius),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                // TODO: реализовать сохранение профиля
              },
              child: const Text('Сактоо', style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}