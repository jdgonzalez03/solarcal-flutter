import 'package:calculator/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  final Widget child; // ✅

  const HomeScreen({super.key, required this.child}); // ✅

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SolarCal')),
      drawer: const MainDrawer(), 
      body: widget.child,
    );
  }
}
