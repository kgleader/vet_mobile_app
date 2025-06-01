// filepath: /Users/meerimakmatova/vet_mobile_app/lib/layouts/main_layout.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/blocs/navigation/navigation_bloc.dart';
import 'package:vet_mobile_app/blocs/navigation/navigation_event.dart';
import 'package:vet_mobile_app/blocs/navigation/navigation_state.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  
  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: child,
          // Using extendBody to allow content to scroll behind the bottom navigation
          extendBody: true,
          bottomNavigationBar: _buildBottomNavigationBar(context, state.currentIndex),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, int currentIndex) {
    final Color figmaGreen = const Color(0xFF38A169);
    
    // Full width navigation bar with rounded top corners
    return Container(
      decoration: BoxDecoration(
        color: figmaGreen,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          backgroundColor: figmaGreen,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.5),
          onTap: (index) {
            // Сначала обновляем состояние, если используете BlocProvider
            context.read<NavigationBloc>().add(NavigateToTab(index));
          
            // Затем выполняем навигацию в зависимости от выбранной вкладки
            switch (index) {
              case 0:
                GoRouter.of(context).go(RouteNames.menu);
                break;
              case 1:
                GoRouter.of(context).go(RouteNames.news);
                break;
              case 2:
                print('Navigating to Vet List...');
                // Сначала обновим BLoC, но не будем его ждать
                BlocProvider.of<NavigationBloc>(context).add(NavigateToTab(index));
                
                // Напрямую переходим на экран без задержки
                GoRouter.of(context).go(RouteNames.vetList);
                print('Navigation requested');
                break;
            }
          },
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 28),
              activeIcon: Icon(Icons.home, size: 28),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined, size: 26),
              activeIcon: Icon(Icons.article, size: 26),
              label: 'News',
            ),
            BottomNavigationBarItem(
              // Используем круглую иконку профиля как в Figma
              icon: SvgPicture.asset(
                'assets/icons/menu/profile_vector.svg',  // Используем ваш новый SVG
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.5), // Используем тот же цвет, что и для других неактивных иконок
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/menu/profile_vector.svg',  // Используем ваш новый SVG
                width: 28, // Увеличиваем размер для активной иконки
                height: 28,
                colorFilter: ColorFilter.mode(
                  Colors.white, // Чисто белый цвет для активной иконки
                  BlendMode.srcIn,
                ),
              ),
              label: 'Profile',
            ),
          ],
          selectedIconTheme: const IconThemeData(size: 24),
          unselectedIconTheme: const IconThemeData(size: 24),
          enableFeedback: false, // Disable haptic feedback
        ),
      ),
    );
  }
}
