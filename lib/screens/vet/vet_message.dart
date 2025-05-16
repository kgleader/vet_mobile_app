import 'package:flutter/material.dart';

class VetMessage extends StatelessWidget {
  const VetMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vet Message')),
      body: const Center(child: Text('Vet Message Screen')),
    );
  }
}
