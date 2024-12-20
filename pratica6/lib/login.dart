import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/gestures.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  Future<void> _loginAction(BuildContext context) async {
    String email = _emailController.text;
    String senha = _senhaController.text;

    final prefs = await SharedPreferences.getInstance();
    final List<String> userList = prefs.getStringList('users') ?? [];

    bool userFound = false;

    // Percorre a lista de usuários
    for (String userJson in userList) {
      Map<String, dynamic> user =
          Map<String, dynamic>.from(jsonDecode(userJson));

      // Verifica se o email e senha correspondem
      if (user['email'] == email && user['password'] == senha) {
        userFound = true;

        // Salva o e-mail do usuário atual para indicar que está logado
        await prefs.setString('currentUserEmail', email);
        break;
      }
    }

    if (mounted) {
      if (userFound) {
        // Navegar para a página principal (navUser) se o login for bem-sucedido
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/navUser', (Route<dynamic> route) => false);
      } else {
        // Mostrar AlertDialog para erro de login
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.lightBlue[50],
              title: const Text('Dados inválidos'),
              content: const Text('Usuário e/ou senha incorreto(a)'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Login'),
        ),
        drawer: Drawer(
          child: ListView(
            children: const <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: Text('Item 1'),
              ),
              ListTile(
                title: Text('Item 2'),
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.lightBlue[50],
          alignment: Alignment.center,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              width: 250,
              color: Colors.white,
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 16.0),
                  labelText: 'E-mail',
                  border: UnderlineInputBorder(),
                ),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 250,
              color: Colors.white,
              child: TextField(
                controller: _senhaController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 16.0),
                  labelText: 'Password',
                  border: UnderlineInputBorder(),
                ),
                style: const TextStyle(
                  fontSize: 20,
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _loginAction(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              child: const Text('Enter',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                text: 'New here? ',
                style: const TextStyle(color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Create an account',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Navega para a rota de cadastro
                        Navigator.pushNamed(context, '/cadastro');
                      },
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
