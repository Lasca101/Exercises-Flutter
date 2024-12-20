import 'package:flutter/material.dart';
import 'package:flutter_application_1/listaitens.dart';
import 'package:flutter_application_1/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Login',
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        '/listaitens': (context) => const ListaItens(),
      },
    );
  }
}


