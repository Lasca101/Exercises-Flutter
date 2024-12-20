import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/navUser.dart';
import 'package:flutter_application_1/cadastro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        '/cadastro': (context) => const Cadastro(),
        '/navUser': (context) => const NavUser(),
      },
      onGenerateInitialRoutes: (_) {
        // Garante que não haja histórico de navegação ao iniciar a aplicação
        return [
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        ];
      },
    );
  }
}