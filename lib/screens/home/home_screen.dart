import 'package:flutter/material.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/screens/menu/menu_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const MenuScreen(),
    const NewsListScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildFooterItem(int index, IconData icon) {
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Icon(
        icon,
        color: Colors.white,
        size: 32,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildFooterItem(0, Icons.home),
            _buildFooterItem(1, Icons.article),
            _buildFooterItem(2, Icons.person),
          ],
        ),
      ),
    );
  }
}

// Заглушки для экранов (будут реализованы позже)

class NewsListScreen extends StatelessWidget {
  const NewsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Жаңылыктар'), elevation: 0),
      body: const Center(child: Text('Жаңылыктар тизмеси')),
    );
    
  }
}

class VetListScreen extends StatelessWidget {
  const VetListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ветеринарлар'), elevation: 0),
      body: const Center(child: Text('Ветеринарлар тизмеси')),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Профиль'), elevation: 0),
      body: const Center(child: Text('Профиль экраны')),
    );
  }
}
