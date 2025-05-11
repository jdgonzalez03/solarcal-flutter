import 'package:flutter/material.dart';

class MyInput extends StatelessWidget {
  final String placeholder;
  final TextEditingController controller;
  final String label;

  const MyInput({
    super.key,
    required this.placeholder,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          keyboardType: TextInputType.number,
          controller: controller,
          decoration: InputDecoration(
            labelText: placeholder,
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 4),
        Text('$label: ${controller.text}'),
        const SizedBox(height: 12),
      ],
    );
  }
}
