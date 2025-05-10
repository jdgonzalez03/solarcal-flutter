import 'package:go_router/go_router.dart';
import 'package:calculator/screens/home_screen.dart';
import 'package:calculator/screens/formula_screen.dart';
import 'package:calculator/screens/welcome_screen.dart';

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
      ],
    ),
  ],
);
