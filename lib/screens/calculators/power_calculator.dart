import 'package:flutter/material.dart';

import 'package:calculator/widgets/my_button.dart';
import 'package:calculator/widgets/my_input.dart';
import 'package:calculator/widgets/my_text.dart';

class PowerCalculatorScreen extends StatefulWidget {
  const PowerCalculatorScreen({super.key});

  @override
  State<PowerCalculatorScreen> createState() => _PowerCalculatorScreen();
}

class _PowerCalculatorScreen extends State<PowerCalculatorScreen> {
  String? selectedOption = "power"; // Variable para manejar la opción seleccionada
  final TextEditingController op1Controller = TextEditingController();
  final TextEditingController op2Controller = TextEditingController();

  // Función para parsear números reemplazando "," con "."
  double parseNumber(String num) {
    return double.tryParse(num.replaceAll(",", ".")) ?? 0;
  }

  Widget renderOperation() {
    switch (selectedOption) {
      case "power":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText('Ingresa el voltaje (V):'),
            MyInput(
              placeholder: 'Voltaje',
              controller: op1Controller,
              label: 'Voltaje ingresado',
            ),
            MyText('Ingresa la corriente (I):'),
            MyInput(
              placeholder: 'Corriente',
              controller: op2Controller,
              label: 'Corriente ingresada',
            ),
            SizedBox(height: 10),
            MyText(
              'La potencia es: ${op1Controller.text.isNotEmpty && op2Controller.text.isNotEmpty
                      ? "${(parseNumber(op1Controller.text) *
                              parseNumber(op2Controller.text))
                          .toStringAsFixed(2)} Watts"
                      : ""}',
              esTitulo: true,
            ),
          ],
        );
      case "voltage":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText('Ingresa la potencia (P):'),
            MyInput(
              placeholder: 'Potencia',
              controller: op1Controller,
              label: 'Potencia ingresada',
            ),
            MyText('Ingresa la corriente (I):'),
            MyInput(
              placeholder: 'Corriente',
              controller: op2Controller,
              label: 'Corriente ingresada',
            ),
            SizedBox(height: 10),
            MyText(
              'El voltaje es: ${op2Controller.text.isNotEmpty && parseNumber(op2Controller.text) != 0
                      ? "${(parseNumber(op1Controller.text) /
                              parseNumber(op2Controller.text))
                          .toStringAsFixed(2)} Volts"
                      : "N/A"}',
              esTitulo: true,
            ),
          ],
        );
      case "current":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText('Ingresa la potencia (P):'),
            MyInput(
              placeholder: 'Potencia',
              controller: op1Controller,
              label: 'Potencia ingresada',
            ),
            MyText('Ingresa el voltaje (V):'),
            MyInput(
              placeholder: 'Voltaje',
              controller: op2Controller,
              label: 'Voltaje ingresado',
            ),
            SizedBox(height: 10),
            MyText(
              'La corriente es: ${op2Controller.text.isNotEmpty && parseNumber(op2Controller.text) != 0
                      ? "${(parseNumber(op1Controller.text) /
                              parseNumber(op2Controller.text))
                          .toStringAsFixed(2)} Amperios"
                      : "N/A"}',
              esTitulo: true,
            ),
          ],
        );
      default:
        return Center(child: MyText('Por favor, selecciona una opción para calcular.'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: MyText('Calculadora de Potencia', esTitulo: true)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
              'Selecciona qué deseas calcular (Potencia, Corriente o Voltaje)',
              esTitulo: false,
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedOption,
              items: [
                DropdownMenuItem(
                  value: "power",
                  child: Text("Potencia"),
                ),
                DropdownMenuItem(
                  value: "voltage",
                  child: Text("Voltaje"),
                ),
                DropdownMenuItem(
                  value: "current",
                  child: Text("Corriente"),
                ),
              ],
              onChanged: (String? newValue) {
                setState(() {
                  selectedOption = newValue!;
                });
              },
              hint: MyText('Selecciona una opción', esTitulo: false),
            ),
            SizedBox(height: 20),
            renderOperation(),
            SizedBox(height: 20),
            MyButton(
              onPressed: () {
                setState(() {
                  // Recalcular al presionar el botón
                });
              },
              texto: 'Calcular',
            ),
          ],
        ),
      ),
    );
  }
}
