import 'package:flutter/material.dart';

class BateryCalculatorScreen extends StatefulWidget {
  const BateryCalculatorScreen({Key? key}) : super(key: key);

  @override
  State<BateryCalculatorScreen> createState() => _BateryCalculatorScreen();
}

class _BateryCalculatorScreen extends State<BateryCalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Calculadora de Batería'),
          centerTitle: true,
          backgroundColor: Color(0xFF2E86C1),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Text('Soy una calculadora de batería'),
          ],
        ),
      ),
    );
  }
}