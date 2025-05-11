import 'package:flutter/material.dart';
import 'package:calculator/widgets/my_button.dart';
import 'package:calculator/widgets/my_input.dart';
import 'package:calculator/widgets/my_text.dart';

class EnergyCalculatorScreen extends StatefulWidget {
  const EnergyCalculatorScreen({super.key});

  @override
  State<EnergyCalculatorScreen> createState() => _EnergyCalculatorScreenState();
}

class _EnergyCalculatorScreenState extends State<EnergyCalculatorScreen> {
  final power = TextEditingController();
  final hours = TextEditingController();
  final energy = TextEditingController();
  String unit = "W";  // Cambiar a String para manejar la unidad seleccionada

  // Lista de opciones para las unidades
  final List<String> units = ["W", "kW"];

  void calculate() {
  final powerValue = double.tryParse(power.text) ?? 0;
  final hoursValue = double.tryParse(hours.text) ?? 0;

  if (powerValue > 0 && hoursValue > 0) {
    // Ajusta la potencia según la unidad seleccionada
    final powerInW = unit == 'W' ? powerValue : powerValue * 1000;

    // Calcula la energía
    final result = powerInW * hoursValue;

    setState(() {
      energy.text = result.toStringAsFixed(2); // Actualiza el controlador con el resultado
    });
  } else {
    setState(() {
      energy.text = 'Error: Verifique los valores'; // Muestra un mensaje de error si los valores no son válidos
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora de Energía')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
              esTitulo: true,
              'Ingrese los valores para calcular la energía',
            ),
            const SizedBox(height: 16),
            MyInput(
              placeholder: "Ejemplo: 12 ", 
              controller: power, 
              label: "Potencia (W)"
            ),
            const SizedBox(height: 16),
            MyInput(
              placeholder: "Ejemplo: 5 ", 
              controller: hours, 
              label: "Horas de uso"
            ),
            const SizedBox(height: 16),
            // Dropdown para seleccionar la unidad
            Row(
              children: [
                Text("Unidad: ", style: TextStyle(fontSize: 16)),
                DropdownButton<String>(
                  value: unit,
                  onChanged: (String? newValue) {
                    setState(() {
                      unit = newValue!;
                    });
                  },
                  items: units.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: MyButton(
                texto: "Calcular",
                onPressed: calculate,
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: MyText(
                "Energía calculada: ${energy.text} Wh",
                esTitulo: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
