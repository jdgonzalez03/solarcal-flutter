import 'package:flutter/material.dart';
import 'package:calculator/widgets/custom_container.dart';
import 'package:calculator/models/calculator_item.dart';
import 'package:go_router/go_router.dart';


class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 20),
            CustomContainer(
              title: 'Calculadora Solar',
              description: 'Calcula la energía solar necesaria para tu hogar.',
              backgroundColor: Colors.blue[50],
              titleColor: Colors.blue,
              textColor: Colors.black,
              icon: Icons.calculate,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                padding: const EdgeInsets.all(10),
                children:
                    calculators.map((calculator) {
                      return GestureDetector(
                        onTap: () {
                          context.push(calculator.route);
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                calculator.icon,
                                size: 40,
                                color: Colors.blue,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                calculator.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
