import 'package:calculator/screens/calculators/full_calculator.dart';
import 'package:calculator/screens/calculators/inversor_calculator.dart';
import 'package:go_router/go_router.dart';
import 'package:calculator/screens/home_screen.dart';
import 'package:calculator/screens/formula_screen.dart';
import 'package:calculator/screens/welcome_screen.dart';
import 'package:calculator/screens/calculator_screen.dart';
import 'package:calculator/router/router_names.dart';
import 'package:calculator/screens/calculators/controller_calculator.dart';
import 'package:calculator/screens/calculators/batery_calculator.dart';
import 'package:calculator/screens/calculators/energy_calculator.dart';
import 'package:calculator/screens/calculators/power_calculator.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) => HomeScreen(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const WelcomeScreen(),
        ),
        GoRoute(
          path: '/tables',
          builder: (context, state) => const FormulasScreen(),
        ),
        GoRoute(
          path: '/calculator',
          builder: (context, state) => const CalculatorScreen(),
        )
      ],
    ),
    GoRoute(
      name: RouteNames.batery,
      path: '/${RouteNames.batery}',
      builder:(context, state) => const BateryCalculatorScreen(),
    ),
    GoRoute(
      name: RouteNames.controller,
      path: '/${RouteNames.controller}',
      builder:(context, state) => const ControllerCalculatorScreen(),
    ),
    GoRoute(
      name: RouteNames.energy,
      path: '/${RouteNames.energy}',
      builder:(context, state) => const EnergyCalculatorScreen(), 
    ),
    GoRoute(
      name: RouteNames.full,
      path: '/${RouteNames.full}',
      builder:(context, state) => const FullCalculator(),
    ),
    GoRoute(
      name: RouteNames.inverter,
      path:'/${RouteNames.inverter}',
      builder:(context, state) => const InversorCalculatorScreen(),
    ),
    GoRoute(
      name: RouteNames.power,
      path: '/${RouteNames.power}',
      builder:(context, state) => const PowerCalculatorScreen(),
    ),
  ],
);
