import 'package:flutter/material.dart';
import 'package:calculator/widgets/math_formula.dart';

class FormulaCard extends StatelessWidget {
  final String title;
  final String formula;
  final String description;
  final String? id;
  final VoidCallback? onTap;

  const FormulaCard({
    Key? key,
    required this.title,
    required this.formula,
    required this.description,
    this.id,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(height: 24),
              MathFormula(
                formula: formula,
                textColor: theme.colorScheme.secondary,
              ),
              const Divider(height: 24),
              Text(
                description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
