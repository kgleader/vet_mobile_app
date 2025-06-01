import 'package:flutter/material.dart';
import 'package:vet_mobile_app/screens/menu/menu_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _selectedIndex = 0;

  final List<Widget> _screens = [
    const MenuScreen(),
    const NewsListScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      // bottomNavigationBar removed - MainLayout provides it
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
