
import 'package:flutter/material.dart';

class TempScreen extends StatefulWidget {
  const TempScreen({super.key});

  @override
  State<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  @override
  void initState() {
    super.initState();
    debugPrint("TempScreen: initState");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("TempScreen: build");
    return const Scaffold(
      body: Center(
        child: Text('Temporary Screen - Testing Startup. Firebase should be initialized.'),
      ),
    );
  }
}
