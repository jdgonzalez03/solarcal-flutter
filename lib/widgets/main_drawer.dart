import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 180,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              child: SvgPicture.asset(
                'assets/images/drawer_header.svg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Elementos del menú
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
                context.go('/home');
                Navigator.of(context).pop();
              },
          ),
          
          ListTile(
            leading: const Icon(Icons.calculate),
            title: const Text('Tablas y fórmulas'),
            onTap: () {
              context.go('/tables');
              Navigator.of(context).pop();
            },
          ),
          
          const Divider(),
          
          ListTile(
            leading: const Icon(Icons.solar_power),
            title: const Text('Calculadoras'),
            onTap: () {
              context.go('/calculator');
              Navigator.of(context).pop();
              // Navegar a la calculadora solar
            },
          ),
          
          const Divider(),
          
          // ListTile(
          //   leading: const Icon(Icons.info),
          //   title: const Text('Acerca de'),
          //   onTap: () {
          //     Navigator.pop(context);
          //     // Mostrar información sobre la app
          //   },
          // ),
        ],
      ),
    );
  }
}