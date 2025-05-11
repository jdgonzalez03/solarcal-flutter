import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class MathFormula extends StatelessWidget {
  final String formula;
  final double fontSize;
  final Color? textColor;
  final TextAlign textAlign;

  const MathFormula({
    super.key,
    required this.formula,
    this.fontSize = 22.0,
    this.textColor,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = textColor ?? theme.colorScheme.primary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Math.tex(
        formula,
        textStyle: TextStyle(
          fontSize: fontSize,
          color: color,
        ),
      ),
    );
  }
}
