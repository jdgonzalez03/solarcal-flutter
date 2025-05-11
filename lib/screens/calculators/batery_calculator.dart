import 'package:flutter/material.dart';
import 'package:calculator/widgets/my_button.dart';
import 'package:calculator/widgets/my_input.dart';
import 'package:calculator/widgets/my_text.dart';

class BateryCalculatorScreen extends StatefulWidget {
  const BateryCalculatorScreen({super.key});

  @override
  State<BateryCalculatorScreen> createState() => _BateryCalculatorScreenState();
}

class _BateryCalculatorScreenState extends State<BateryCalculatorScreen> {
  final cargaAC = TextEditingController();
  final cargaDC = TextEditingController();
  final eficienciaInversor = TextEditingController();
  final voltajeSistemaDC = TextEditingController();
  final diasAutonomia = TextEditingController();
  final limiteDescarga = TextEditingController();
  final capacidadBateria = TextEditingController();
  final voltajeBateria = TextEditingController();

  Map<String, dynamic>? resultados;

  double parseNumber(String value) {
    return double.tryParse(value.replaceAll(',', '.')) ?? 0.0;
  }

  void calcularBancoBaterias() {
    final cargaACNum = parseNumber(cargaAC.text);
    final cargaDCNum = parseNumber(cargaDC.text);
    final eficienciaNum = (parseNumber(eficienciaInversor.text) / 100).clamp(0.01, 1.0);
    final voltajeSistemaDCNum = parseNumber(voltajeSistemaDC.text) == 0 ? 12 : parseNumber(voltajeSistemaDC.text);
    final diasAutonomiaNum = parseNumber(diasAutonomia.text) == 0 ? 1 : parseNumber(diasAutonomia.text);
    final limiteDescargaNum = (parseNumber(limiteDescarga.text) / 100).clamp(0.01, 1.0);
    final capacidadBateriaNum = parseNumber(capacidadBateria.text) == 0 ? 1 : parseNumber(capacidadBateria.text);
    final voltajeBateriaNum = parseNumber(voltajeBateria.text) == 0 ? 12 : parseNumber(voltajeBateria.text);

    final amperHoraPromedioDia = (cargaACNum / eficienciaNum) + (cargaDCNum / voltajeSistemaDCNum);
    final aux2 = (amperHoraPromedioDia * diasAutonomiaNum) / limiteDescargaNum;
    final bateriasParalelo = (aux2 / capacidadBateriaNum).ceil();
    final bateriasSerie = (voltajeSistemaDCNum / voltajeBateriaNum).ceil();
    final bateriasTotales = bateriasParalelo * bateriasSerie;

    setState(() {
      resultados = {
        'amperHoraPromedioDia': amperHoraPromedioDia.toStringAsFixed(2),
        'bateriasParalelo': bateriasParalelo,
        'bateriasSerie': bateriasSerie,
        'bateriasTotales': bateriasTotales,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dimensionamiento de Baterías')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const MyText("Dimensionamiento de Baterías", esTitulo: true),
            const SizedBox(height: 20),
            MyInput(
              placeholder: 'Carga promedio AC por día (Ah)',
              controller: cargaAC,
              label: 'Carga promedio AC',
            ),
            MyInput(
              placeholder: 'Carga promedio DC por día (Ah)',
              controller: cargaDC,
              label: 'Carga promedio DC',
            ),
            MyInput(
              placeholder: 'Eficiencia del inversor (0 a 100)',
              controller: eficienciaInversor,
              label: 'Eficiencia del inversor',
            ),
            MyInput(
              placeholder: 'Voltaje del sistema DC',
              controller: voltajeSistemaDC,
              label: 'Voltaje sistema DC',
            ),
            MyInput(
              placeholder: 'Días de autonomía',
              controller: diasAutonomia,
              label: 'Días de autonomía',
            ),
            MyInput(
              placeholder: 'Límite de descarga profunda (%)',
              controller: limiteDescarga,
              label: 'Límite de descarga',
            ),
            MyInput(
              placeholder: 'Capacidad de batería (Ah)',
              controller: capacidadBateria,
              label: 'Capacidad batería',
            ),
            MyInput(
              placeholder: 'Voltaje de batería',
              controller: voltajeBateria,
              label: 'Voltaje batería',
            ),
            const SizedBox(height: 10),
            MyButton(onPressed: calcularBancoBaterias, texto: 'Calcular'),
            const SizedBox(height: 20),
            if (resultados != null) ...[
              MyText("Amperio-Hora promedio/día: ${resultados!['amperHoraPromedioDia']} Ah"),
              MyText("Baterías en paralelo: ${resultados!['bateriasParalelo']}"),
              MyText("Baterías en serie: ${resultados!['bateriasSerie']}"),
              MyText("Total de baterías: ${resultados!['bateriasTotales']}"),
            ]
          ],
        ),
      ),
    );
  }
}
