import 'package:flutter/material.dart';
import 'package:calculator/widgets/my_input.dart';
import 'package:calculator/widgets/my_button.dart';
import 'package:calculator/widgets/my_text.dart';

class InversorCalculatorScreen extends StatefulWidget {
  const InversorCalculatorScreen({super.key});

  @override
  State<InversorCalculatorScreen> createState() => _InversorCalculatorScreenState();
}

class _InversorCalculatorScreenState extends State<InversorCalculatorScreen> {
  final TextEditingController cargasTotalesController = TextEditingController();
  final TextEditingController factorSeguridadController = TextEditingController(text: "1.25");
  final TextEditingController voltajeSistemaController = TextEditingController();

  String? potenciaInversor;
  String? corrienteEntrada;

  void calcularInversor() {
    final cargas = double.tryParse(cargasTotalesController.text.replaceAll(",", ".")) ?? double.nan;
    final factor = double.tryParse(factorSeguridadController.text.replaceAll(",", ".")) ?? 1.0;
    final voltaje = double.tryParse(voltajeSistemaController.text.replaceAll(",", ".")) ?? double.nan;

    if (cargas.isNaN || voltaje.isNaN) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Error"),
          content: const Text("Por favor ingresa valores válidos para las cargas y el voltaje."),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))
          ],
        ),
      );
      return;
    }

    final potencia = cargas * factor;
    final corriente = potencia / voltaje;

    setState(() {
      potenciaInversor = "${potencia.toStringAsFixed(2)} W";
      corrienteEntrada = "${corriente.toStringAsFixed(2)} A";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const MyText("Calculadora de Inversores", esTitulo: true)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText("Ingrese los valores para calcular el inversor", esTitulo: true),
              const SizedBox(height: 16),
              MyInput(
                placeholder: "Ejemplo: 950",
                controller: cargasTotalesController,
                label: "Cargas totales",
              ),
              MyInput(
                placeholder: "Ejemplo: 1.25",
                controller: factorSeguridadController,
                label: "Factor de seguridad",
              ),
              MyInput(
                placeholder: "Ejemplo: 48",
                controller: voltajeSistemaController,
                label: "Voltaje del sistema DC",
              ),
              Center(
                child: MyButton(
                  onPressed: calcularInversor,
                  texto: "Calcular",
                ),
              ),
              const SizedBox(height: 24),
              if (potenciaInversor != null && corrienteEntrada != null) ...[
                MyText("Potencia recomendada del inversor: $potenciaInversor"),
                const SizedBox(height: 8),
                MyText("Corriente de entrada del inversor: $corrienteEntrada"),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
