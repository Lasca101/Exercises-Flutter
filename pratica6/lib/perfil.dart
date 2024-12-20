import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  PerfilState createState() => PerfilState();
}

class PerfilState extends State<Perfil> {
  String _nome = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    // Recupera o e-mail do usuário logado atualmente
    final currentUserEmail = prefs.getString('currentUserEmail');

    // Recupera a lista de usuários
    final List<String> userList = prefs.getStringList('users') ?? [];

    String nome = 'Nome não encontrado';
    String email = 'Email não encontrado';

    // Procura o usuário correspondente ao e-mail logado
    for (String userJson in userList) {
      Map<String, dynamic> user = Map<String, dynamic>.from(jsonDecode(userJson));

      if (user['email'] == currentUserEmail) {
        nome = user['name'];
        email = user['email'];
        break;
      }
    }

    // Atualiza as variáveis de estado
    setState(() {
      _nome = nome;
      _email = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Perfil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, // Centraliza horizontalmente
          children: [
            Text(
              'Nome: $_nome',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10), // Espaço entre os textos
            Text(
              'E-mail: $_email',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}