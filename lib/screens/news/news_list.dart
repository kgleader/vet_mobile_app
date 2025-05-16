import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News List')),
      body: const Center(child: Text('News List Screen')),
    );
  }
}
