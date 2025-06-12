// Бул файл негизги макетти (layout) аныктайт, ал туруктуу навигация
// тилкесин (bottom navigation bar) камтыйт жана ар кандай экрандарды көрсөтүү үчүн колдонулат.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/blocs/navigation/navigation_bloc.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  
  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: child,
          extendBody: true,
          bottomNavigationBar: _buildBottomNavigationBar(context, state.currentIndex),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, int currentIndex) {
    final Color figmaGreen = const Color(0xFF38A169);
    final Color activeIconColor = figmaGreen; 
    final Color inactiveIconColor = Colors.white.withOpacity(0.7); 

    Widget buildActiveIconContainer(IconData iconData, {double size = 28}) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 40, 
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.white, 
              shape: BoxShape.circle,
            ),
          ),
          Icon(iconData, size: size * 0.7, color: activeIconColor), 
        ],
      );
    }

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
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            backgroundColor: figmaGreen,
            selectedItemColor: Colors.white, 
            unselectedItemColor: inactiveIconColor, 
            onTap: (index) {
              context.read<NavigationBloc>().add(NavigateTo(index));
            
              switch (index) {
                case 0: 
                  GoRouter.of(context).go(RouteNames.menu);
                  break;
                case 1: 
                  GoRouter.of(context).go(RouteNames.news);
                  break;
                case 2: 
                  GoRouter.of(context).go(RouteNames.vetList); 
                  break;
              }
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, size: 35, color: inactiveIconColor), 
                activeIcon: buildActiveIconContainer(Icons.home, size: 35),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.article_outlined, size: 35, color: inactiveIconColor), 
                activeIcon: buildActiveIconContainer(Icons.article, size: 35),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline, size: 35, color: inactiveIconColor), 
                activeIcon: buildActiveIconContainer(Icons.person, size: 35 ),
                label: '',
              ),
            ],
            selectedIconTheme: IconThemeData(size: 28, color: activeIconColor), 
            unselectedIconTheme: IconThemeData(size: 24, color: inactiveIconColor),
            enableFeedback: false,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}
