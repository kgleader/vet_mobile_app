import 'package:flutter/material.dart';

class NewsDetail extends StatelessWidget {
  const NewsDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News Detail')),
      body: const Center(child: Text('News Detail Screen')),
    );
  }
}
