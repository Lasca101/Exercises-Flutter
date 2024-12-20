import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _welcomeMessage = "Bem vindo(a)!";

  @override
  void initState() {
    super.initState();
    _loadWelcomeMessage();
  }

  Future<void> _loadWelcomeMessage() async {
    final prefs = await SharedPreferences.getInstance();

    // Recupera o e-mail do usuário logado atualmente
    final currentUserEmail = prefs.getString('currentUserEmail');

    // Recupera a lista de usuários
    final List<String> userList = prefs.getStringList('users') ?? [];

    String name = 'User';

    // Procura o usuário correspondente ao e-mail logado
    for (String userJson in userList) {
      Map<String, dynamic> user =
          Map<String, dynamic>.from(jsonDecode(userJson));

      if (user['email'] == currentUserEmail) {
        name = user['name'];
        break;
      }
    }

    // Atualiza a mensagem de boas-vindas
    setState(() {
      _welcomeMessage = 'Bem vindo(a), $name!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlue[50],
        child: Center(
          child: Text(
            _welcomeMessage,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
