import 'package:flutter/material.dart';
import 'package:calculator/widgets/custom_container.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              CustomContainer(
                title: 'Bienvenido a SolarCal',
                description:
                    'SolarCal es una aplicación diseñada para ayudarte a calcular y entender mejor los paneles solares.',
                additionalText:
                    'Para empezar, selecciona una opción del menú. Allí podrás encontrar las diferentes calculadoras y tablas que te ayudarán a tomar decisiones informadas sobre la energía solar.',
                icon: Icons.solar_power,
              ),
              const SizedBox(height: 30),
            ],
          ),
      ),
    );
  }
}