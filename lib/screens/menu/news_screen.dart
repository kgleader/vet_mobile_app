import 'package:flutter/material.dart';
import 'package:vet_mobile_app/core/bottom_bar.dart';

class NewsScreen extends StatelessWidget {
  final int bottomBarCurrentIndex;

  const NewsScreen({
    super.key,
    required this.bottomBarCurrentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Жаңылыктар'), // "News"
      ),
      body: const Center(
        child: Text('News content goes here.'),
        // Replace with your actual news list or content
      ),
      bottomNavigationBar: BottomBar( // Removed const because bottomBarCurrentIndex is not a compile-time const
        currentIndex: bottomBarCurrentIndex,
      ),
    );
  }
}
