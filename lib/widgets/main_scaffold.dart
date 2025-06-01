import 'package:flutter/material.dart';

class MainScaffold extends StatelessWidget {
  final Widget body;
  final int currentIndex;
  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  const MainScaffold({
    super.key,
    required this.body,
    required this.currentIndex, // Must accept this parameter
    this.title = '',
    this.leading,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    // final Color figmaGreen = const Color(0xFF38A169); // Removed as unused
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color(0xFFF3F0EB),
        elevation: 0,
        leading: leading,
        actions: actions,
      ),
      body: body,
      backgroundColor: const Color(0xFFF3F0EB),
      // bottomNavigationBar removed - MainLayout provides it
    );
  }
}