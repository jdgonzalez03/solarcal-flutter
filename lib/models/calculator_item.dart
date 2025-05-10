import 'package:flutter/material.dart';
import 'package:calculator/router/router_names.dart';

class CalculatorItem {
  final String title;
  final String route;
  final IconData icon;

  CalculatorItem({required this.title, required this.route, required this.icon});
}

final List<CalculatorItem> calculators = [
  CalculatorItem(title: 'Batería', route: '/${RouteNames.batery}', icon: Icons.battery_full),
  CalculatorItem(title: 'Controlador', route: '/${RouteNames.controller}', icon: Icons.settings_input_component),
  CalculatorItem(title: 'Energía', route: '/${RouteNames.controller}', icon: Icons.flash_on),
  CalculatorItem(title: 'Full', route: '/${RouteNames.controller}', icon: Icons.functions),
  CalculatorItem(title: 'Inversor', route: '/${RouteNames.controller}', icon: Icons.transform),
  CalculatorItem(title: 'Potencia', route: '/${RouteNames.controller}', icon: Icons.electric_bolt),
];
