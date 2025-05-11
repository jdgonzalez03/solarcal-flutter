import 'package:flutter/material.dart';
import 'package:calculator/models/formula_model.dart';
import 'package:calculator/data/formulas.dart';
import 'package:calculator/widgets/formula_card.dart';
import 'package:calculator/widgets/main_drawer.dart';

class FormulasScreen extends StatefulWidget {
  const FormulasScreen({super.key});

  @override
  State<FormulasScreen> createState() => _FormulasScreenState();
}

class _FormulasScreenState extends State<FormulasScreen> {
  late List<Formula> formulas;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    formulas = FormulasData.getFormulas();
  }

  // Filtrar fórmulas por búsqueda
  List<Formula> get filteredFormulas {
    if (searchQuery.isEmpty) {
      return formulas;
    }
    return formulas.where((formula) {
      return formula.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          formula.description.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar fórmulas...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          
          // Lista de fórmulas
          Expanded(
            child: filteredFormulas.isEmpty
                ? const Center(
                    child: Text('No se encontraron fórmulas'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 8, bottom: 24),
                    itemCount: filteredFormulas.length,
                    itemBuilder: (context, index) {
                      final formula = filteredFormulas[index];
                      return FormulaCard(
                        title: formula.title,
                        formula: formula.formula,
                        description: formula.description,
                        onTap: () {
                          // Abre la vista detallada de la fórmula (podría implementarse)
                          _showFormulaDetails(formula);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // Muestra un diálogo con detalles de la fórmula
  void _showFormulaDetails(Formula formula) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(formula.title),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormulaCard(
                title: formula.title,
                formula: formula.formula,
                description: formula.description,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}