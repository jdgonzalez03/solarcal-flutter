import 'package:flutter/material.dart';
import 'package:calculator/widgets/base_componente.dart';
import 'package:calculator/widgets/my_button.dart';
import 'package:calculator/widgets/my_input.dart';
import 'package:calculator/widgets/my_text.dart';

import 'package:calculator/utils/full_calculator.dart';
class FullCalculator extends StatefulWidget {
  const FullCalculator({Key? key}) : super(key: key);

  @override
  State<FullCalculator> createState() => _FullCalculatorState();
}

class _FullCalculatorState extends State<FullCalculator> {
  bool open = false;
  Map<String, dynamic> results = {};
  
  // Controllers for form inputs
  final TextEditingController nombreEquipoController = TextEditingController();
  final TextEditingController potenciaController = TextEditingController();
  final TextEditingController cantidadController = TextEditingController();
  final TextEditingController horasUsoController = TextEditingController();
  final TextEditingController diasUsoController = TextEditingController();
  
  // Controllers for system parameters
  final TextEditingController voltajeBateriaController = TextEditingController();
  final TextEditingController numeroDiasAutonomiaController = TextEditingController();
  final TextEditingController capacidadBateriaController = TextEditingController();
  final TextEditingController capacidadDescargaController = TextEditingController();
  final TextEditingController voltajeNominalPanelController = TextEditingController();
  final TextEditingController corrientCortoPanelController = TextEditingController();
  final TextEditingController corrienteNominalPanelController = TextEditingController();
  final TextEditingController hspController = TextEditingController();
  final TextEditingController tensionSistemaController = TextEditingController();
  final TextEditingController eficienciaInversorController = TextEditingController();
  final TextEditingController factorSeguridadController = TextEditingController();
  
  List<Map<String, dynamic>> equipos = [];

  @override
  void dispose() {
    // Dispose all controllers
    nombreEquipoController.dispose();
    potenciaController.dispose();
    cantidadController.dispose();
    horasUsoController.dispose();
    diasUsoController.dispose();
    voltajeBateriaController.dispose();
    numeroDiasAutonomiaController.dispose();
    capacidadBateriaController.dispose();
    capacidadDescargaController.dispose();
    voltajeNominalPanelController.dispose();
    corrientCortoPanelController.dispose();
    corrienteNominalPanelController.dispose();
    hspController.dispose();
    tensionSistemaController.dispose();
    eficienciaInversorController.dispose();
    factorSeguridadController.dispose();
    super.dispose();
  }

  void agregarEquipo() {
    final nombreEquipo = nombreEquipoController.text;
    final potencia = potenciaController.text;
    final cantidad = cantidadController.text;
    final horasUso = horasUsoController.text;
    final diasUso = diasUsoController.text;

    // Basic validation
    if (nombreEquipo.isEmpty ||
        potencia.isEmpty ||
        cantidad.isEmpty ||
        horasUso.isEmpty ||
        diasUso.isEmpty ||
        double.tryParse(potencia.replaceAll(',', '.')) == null ||
        int.tryParse(cantidad) == null ||
        double.tryParse(horasUso.replaceAll(',', '.')) == null ||
        int.tryParse(diasUso) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, completa todos los campos con datos válidos.'),
        ),
      );
      return;
    }

    final potenciaNumerica = double.parse(potencia.replaceAll(',', '.'));
    final horasUsoNumerico = double.parse(horasUso.replaceAll(',', '.'));
    final cantidadNumerica = int.parse(cantidad);
    final diasUsoNumerico = int.parse(diasUso);

    final potenciaTotal = potenciaNumerica * cantidadNumerica;
    final energia = potenciaTotal * horasUsoNumerico;

    // Create a new equipment and add it to the list
    final nuevoEquipo = {
      'nombre_equipo': nombreEquipo,
      'potencia': potenciaNumerica,
      'cantidad': cantidadNumerica,
      'horas_uso': horasUsoNumerico,
      'dias_uso': diasUsoNumerico,
      'potencia_total': potenciaTotal,
      'energia': energia,
    };

    setState(() {
      equipos.add(nuevoEquipo);
      
      // Clear the form
      nombreEquipoController.clear();
      potenciaController.clear();
      cantidadController.clear();
      horasUsoController.clear();
      diasUsoController.clear();
    });
  }

  void clear() {
    setState(() {
      equipos = [];
    });
  }

  void getParams() {
    if (equipos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, ingresa al menos un equipo antes de calcular.'),
        ),
      );
      return;
    }

    final maxPower = getMaxPower(equipos).toStringAsFixed(2);
    final maxEnergy = getMaxEnergyDaily(equipos).toStringAsFixed(2);
    
    final eficienciaInversor = double.parse(
      eficienciaInversorController.text.replaceAll(',', '.')
    );
    
    final realEnergy = getRealEnergyMax(
      double.parse(maxEnergy),
      eficienciaInversor,
    ).toStringAsFixed(2);
    
    final tensionSistema = double.parse(
      tensionSistemaController.text.replaceAll(',', '.')
    );
    
    final factorSeguridad = double.parse(
      factorSeguridadController.text.replaceAll(',', '.')
    );
    
    final maxCurrent = getMaxCurrent(
      double.parse(realEnergy),
      tensionSistema,
      factorSeguridad,
    ).toStringAsFixed(2);

    final corrienteNominalPanel = double.parse(
      corrienteNominalPanelController.text.replaceAll(',', '.')
    );
    
    final hsp = double.parse(hspController.text.replaceAll(',', '.'));
    
    final numPanelParalelo = getPanelesParalelo(
      double.parse(maxCurrent),
      hsp,
      corrienteNominalPanel,
    ).toStringAsFixed(2);

    final voltajeNominalPanel = double.parse(
      voltajeNominalPanelController.text.replaceAll(',', '.')
    );
    
    final numPanelSerie = getPanelesSerie(
      tensionSistema,
      voltajeNominalPanel,
    ).toStringAsFixed(2);

    final numeroDiasAutonomia = double.parse(
      numeroDiasAutonomiaController.text.replaceAll(',', '.')
    );
    
    final capacidadDescarga = double.parse(
      capacidadDescargaController.text.replaceAll(',', '.')
    );
    
    final capacidadBateria = double.parse(
      capacidadBateriaController.text.replaceAll(',', '.')
    );
    
    final numBateriasParalelo = getBateriasParalelo(
      double.parse(maxCurrent),
      numeroDiasAutonomia,
      capacidadDescarga,
      capacidadBateria,
    ).toStringAsFixed(2);

    final voltajeBateria = double.parse(
      voltajeBateriaController.text.replaceAll(',', '.')
    );
    
    final numBateriasSerie = getBateriasSerie(
      tensionSistema,
      voltajeBateria,
    ).toStringAsFixed(2);

    final corrienteCortoPanel = double.parse(
      corrientCortoPanelController.text.replaceAll(',', '.')
    );
    
    final maxCurrentControlador = getMaxCurrentControlador(
      (double.parse(numPanelParalelo)).ceil(),
      corrienteCortoPanel,
      factorSeguridad,
    ).toStringAsFixed(2);

    final maxPowerInversor = getMaxPowerInversor(
      double.parse(maxPower),
      factorSeguridad,
      eficienciaInversor,
    ).toStringAsFixed(2);

    setState(() {
      results = {
        'potencia_max': maxPower,
        'energia_max': maxEnergy,
        'eficiencia_inversor': eficienciaInversorController.text,
        'energia_real_diaria': realEnergy,
        'corriente_real_diaria': maxCurrent,
        'num_panel_paralelo': numPanelParalelo,
        'num_panel_paralelo_aprox': (double.parse(numPanelParalelo)).ceil().toString(),
        'num_panel_serie': numPanelSerie,
        'num_panel_serie_aprox': (double.parse(numPanelSerie)).ceil().toString(),
        'total_paneles': ((double.parse(numPanelParalelo)) * (double.parse(numPanelSerie))).ceil().toString(),
        'num_baterias_paralelo': numBateriasParalelo,
        'num_baterias_paralelo_aprox': (double.parse(numBateriasParalelo)).ceil().toString(),
        'num_baterias_serie': numBateriasSerie,
        'num_baterias_serie_aprox': (double.parse(numBateriasSerie)).ceil().toString(),
        'total_baterias': ((double.parse(numBateriasParalelo)) * (double.parse(numBateriasSerie))).ceil().toString(),
        'max_corriente_controlador': maxCurrentControlador,
        'max_potencia_inversor': maxPowerInversor,
      };
      
      open = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const MyText('Calculadora de Sistemas Fotovoltaicos', esTitulo: true),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const MyText('Calculadora diseño de sistemas fotovoltaicos', esTitulo: true),
            const MyText('Lista de equipos'),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Equipment form
                      _buildEquipoForm(),
                      
                      // Button to add equipment
                      MyButton(
                        onPressed: agregarEquipo,
                        texto: '¿Ingresar otro equipo?',
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // System parameters form
                      _buildParametrosForm(),
                      
                      const SizedBox(height: 16),
                      
                      // List of equipments
                      ..._buildEquiposList(),
                      
                      const SizedBox(height: 16),
                      
                      // Calculation buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MyButton(
                            onPressed: getParams,
                            texto: 'Calcular',
                          ),
                          MyButton(
                            onPressed: clear,
                            texto: 'Limpiar datos',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }

  Widget _buildEquipoForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: nombreEquipoController,
          decoration: const InputDecoration(
            labelText: 'Nombre del equipo',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        
        TextField(
          controller: potenciaController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Potencia que consume el equipo (W)',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        
        TextField(
          controller: cantidadController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Cantidad de equipos',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        
        TextField(
          controller: diasUsoController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Cantidad de días a la semana que se usa',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        
        TextField(
          controller: horasUsoController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Horas de uso diario',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildParametrosForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MyText('Parametros Inversor, baterias...', esTitulo: true),
        const SizedBox(height: 16),
        
        MyInput(
          placeholder: 'Eficiencia del inversor (0 - 1)',
          controller: eficienciaInversorController,
          label: 'Eficiencia',
        ),
        
        MyInput(
          placeholder: 'Factor de seguridad (Ejemplo: 1.2)',
          controller: factorSeguridadController,
          label: 'Factor',
        ),
        
        MyInput(
          placeholder: 'Tension del sistema (Ejemplo: 12 V)',
          controller: tensionSistemaController,
          label: 'Tension',
        ),
        
        MyInput(
          placeholder: 'Horas solares pico (Ejemplo: 5.27)',
          controller: hspController,
          label: 'HSP',
        ),
        
        MyInput(
          placeholder: 'Corriente nominal del panel (Ejemplo: 8.51 A)',
          controller: corrienteNominalPanelController,
          label: 'Corriente nominal',
        ),
        
        MyInput(
          placeholder: 'Corriente corto circuito del panel (Ejemplo: 9.51 A)',
          controller: corrientCortoPanelController,
          label: 'Corriente corto',
        ),
        
        MyInput(
          placeholder: 'Voltaje nominal del panel (Ejemplo: 12 V)',
          controller: voltajeNominalPanelController,
          label: 'Voltaje panel',
        ),
        
        MyInput(
          placeholder: 'Profundidad de descarga de baterías (Ejemplo: 0.35)',
          controller: capacidadDescargaController,
          label: 'Descarga',
        ),
        
        MyInput(
          placeholder: 'Capacidad de batería (Ejemplo: 100 Ah)',
          controller: capacidadBateriaController,
          label: 'Capacidad',
        ),
        
        MyInput(
          placeholder: 'Voltaje de batería (Ejemplo: 12 V)',
          controller: voltajeBateriaController,
          label: 'Voltaje batería',
        ),
        
        MyInput(
          placeholder: 'Días de autonomía (Ejemplo: 2 días)',
          controller: numeroDiasAutonomiaController,
          label: 'Autonomía',
        ),
      ],
    );
  }

  List<Widget> _buildEquiposList() {
    return equipos.map((equipo) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nombre: ${equipo['nombre_equipo']}'),
              Text('Potencia: ${equipo['potencia']} W'),
              Text('Cantidad: ${equipo['cantidad']}'),
              Text('Horas de uso: ${equipo['horas_uso']}'),
              Text('Días de uso: ${equipo['dias_uso']}'),
              Text('Potencia Total: ${equipo['potencia_total']} W'),
              Text('Energía: ${equipo['energia']} Wh'),
            ],
          ),
        ),
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    // Add listener to detect when the modal should be shown
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showResultsDialogIfNeeded();
    });
  }

  void _showResultsDialogIfNeeded() {
    if (open) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Resultados Calculados'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: results.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          '${entry.key.replaceAll('_', ' ')}:',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 2, 
                        child: Text('${entry.value}'),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  open = false;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        ),
      );
    }
  }
}