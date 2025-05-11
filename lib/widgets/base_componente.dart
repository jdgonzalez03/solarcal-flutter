import 'package:flutter/material.dart';

class BaseScreenComponent extends StatelessWidget {
  final Widget child;
  
  const BaseScreenComponent({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: child,
        ),
      ),
    );
  }
}