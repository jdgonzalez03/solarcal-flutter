import 'package:go_router/go_router.dart';
import 'package:calculator/screens/HomeScreen.dart';
import 'package:calculator/screens/FormulasScreen.dart';
import 'package:calculator/screens/WelcomeScreen.dart';

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
