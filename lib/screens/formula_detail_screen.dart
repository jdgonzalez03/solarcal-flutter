import 'package:flutter/material.dart';
import 'package:calculator/models/formula.dart';
import 'package:calculator/widgets/MathFormula.dart';

class FormulaDetailScreen extends StatefulWidget {
  final Formula formula;

  const FormulaDetailScreen({
    Key? key,
    required this.formula,
  }) : super(key: key);

  @override
  State<FormulaDetailScreen> createState() => _FormulaDetailScreenState();
}

class _FormulaDetailScreenState extends State<FormulaDetailScreen> {
  // Controladores para los campos de entrada
  final Map<String, TextEditingController> controllers = {};
  final Map<String, String> values = {};
  String result = '';

  @override
  void initState() {
    super.initState();
    _setupControllers();
  }

  // Configura los controladores basados en la descripción de la fórmula
  void _setupControllers() {
    // Extrae símbolos de variables de la descripción
    final description = widget.formula.description;
    final lines = description.split('\n');
    
    for (final line in lines) {
      if (line.contains('=')) {
        final parts = line.split('=');
        if (parts.length >= 2) {
          final symbol = parts[0].trim();
          if (symbol.length == 1) {  // Solo letras simples como variables
            controllers[symbol] = TextEditingController();
          }
        }
      }
    }
  }

  // Calcula el resultado basado en la fórmula y los valores ingresados
  void _calculateResult() {
    // Aquí se podría implementar la lógica para calcular
    // basado en la fórmula específica. Por ahora, solo mostramos
    // los valores ingresados.
    setState(() {
      result = 'Valores ingresados:\n';
      controllers.forEach((key, controller) {
        if (controller.text.isNotEmpty) {
          result += '$key = ${controller.text}\n';
        }
      });
    });
    
    // Muestra el resultado
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Cálculo realizado. Verifica los resultados.'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  @override
  void dispose() {
    // Limpia los controladores
    for (final controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.formula.title),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sección de la fórmula
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Fórmula',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    MathFormula(
                      formula: widget.formula.formula,
                      fontSize: 28,
                      textColor: theme.colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Descripción de variables
            Text(
              'Descripción:',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              widget.formula.description,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
            
            const SizedBox(height: 32),
            
            // Calculadora (si hay variables para calcular)
            if (controllers.isNotEmpty) ...[
              Text(
                'Calculadora:',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              
              ...controllers.entries.map((entry) {
                final symbol = entry.key;
                final controller = entry.value;
                
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: 'Ingresa $symbol',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                );
              }).toList(),
              
              const SizedBox(height: 16),
              
              Center(
                child: ElevatedButton(
                  onPressed: _calculateResult,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.secondary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Calcular'),
                ),
              ),
              
              if (result.isNotEmpty) ...[
                const SizedBox(height: 24),
                Card(
                  color: theme.colorScheme.primaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Resultado:',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          result,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}