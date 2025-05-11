import 'package:flutter/material.dart';
import 'package:calculator/widgets/my_button.dart';
import 'package:calculator/widgets/my_input.dart';
import 'package:calculator/widgets/my_text.dart';

class ControllerCalculatorScreen extends StatefulWidget {
  const ControllerCalculatorScreen({super.key});

  @override
  State<ControllerCalculatorScreen> createState() => _ControllerCalculatorScreenState();
}

class _ControllerCalculatorScreenState extends State<ControllerCalculatorScreen> {
  final corrienteCortoCircuito = TextEditingController();
  final cantidadModulos = TextEditingController();
  final cargaTotal = TextEditingController();
  final voltajeSistema = TextEditingController();

  Map<String, String>? resultados;

  double parseNumber(String value) {
    return double.tryParse(value.replaceAll(',', '.')) ?? 0.0;
  }

  double corrienteCortoCircuitoControlador(double corriente, double cantidadModulos) {
    return corriente * cantidadModulos * 1.25;
  }

  double maximaCorrienteCarga(double potencia, double voltaje) {
    if (voltaje == 0) return 0;
    return potencia / voltaje;
  }

  void calcularResultados() {
    final corriente = parseNumber(corrienteCortoCircuito.text);
    final numModulos = parseNumber(cantidadModulos.text);
    final carga = parseNumber(cargaTotal.text);
    final voltaje = parseNumber(voltajeSistema.text);

    if (corriente > 0 && numModulos > 0 && carga > 0 && voltaje > 0) {
      final corrienteCorto = corrienteCortoCircuitoControlador(corriente, numModulos).toStringAsFixed(2);
      final maxCorrienteDC = maximaCorrienteCarga(carga, voltaje).toStringAsFixed(2);
      setState(() {
        resultados = {
          'corrienteCorto': corrienteCorto,
          'maxCorrienteDC': maxCorrienteDC,
        };
      });
    } else {
      setState(() {
        resultados = {
          'corrienteCorto': 'Error: Verifique los valores',
          'maxCorrienteDC': 'Error: Verifique los valores',
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dimensionamiento del Controlador')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MyText("Dimensionamiento de Controlador", esTitulo: true),
            const SizedBox(height: 20),
            MyInput(
              label: "Corriente de corto circuito del módulo (A)",
              placeholder: "Ejemplo: 10.5",
              controller: corrienteCortoCircuito,
            ),
            MyInput(
              label: "Cantidad de módulos",
              placeholder: "Ejemplo: 4",
              controller: cantidadModulos,
            ),
            MyInput(
              label: "Carga total del sistema (W)",
              placeholder: "Ejemplo: 500",
              controller: cargaTotal,
            ),
            MyInput(
              label: "Voltaje del sistema DC (V)",
              placeholder: "Ejemplo: 12",
              controller: voltajeSistema,
            ),
            const SizedBox(height: 16),
            Center(
              child: MyButton(
              onPressed: calcularResultados,
              texto: "Calcular",
            )),
            const SizedBox(height: 24),
            if (resultados != null) ...[
              MyText(
                "Corriente de corto circuito del controlador: ${resultados!['corrienteCorto']} A",
              ),
              MyText(
                "Corriente máxima del controlador (DC): ${resultados!['maxCorrienteDC']} A",
              ),
            ],
          ],
        ),
      ),
    );
  }
}
