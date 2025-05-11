import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String texto;
  final bool esTitulo;

  const MyText(this.texto, {super.key, this.esTitulo = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: TextStyle(
        fontSize: esTitulo ? 20 : 16,
        fontWeight: esTitulo ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
