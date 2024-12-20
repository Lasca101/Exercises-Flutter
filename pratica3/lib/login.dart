import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:pratica02/cadastro.dart'; // Certifique-se de que o caminho está correto

class Login extends StatelessWidget {
  const Login({super.key});

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
        color: Colors.lightBlue[50], // Cor de fundo do body
        alignment: Alignment.center,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 250,
            color: Colors.white,
            child: const TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 16.0),
                labelText: 'E-mail',
                border: UnderlineInputBorder(), // Apenas borda inferior
              ),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: 250,
            color: Colors.white,
            child: const TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 16.0),
                labelText: 'Password',
                border: UnderlineInputBorder(), // Apenas borda inferior
              ),
              style: TextStyle(
                fontSize: 20,
              ),
              obscureText: true, // Campo de senha oculto
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Cor de fundo do botão
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // Bordas levemente arredondadas
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16), // Tamanho do botão
            ),
            child: const Text('Enter',
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
          const SizedBox(height: 20),
          Builder(
            builder: (BuildContext context) {
              return RichText(
                text: TextSpan(
                  text: 'New here? ',
                  style: const TextStyle(
                      color: Colors.black), // Cor do texto principal
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Create an account',
                      style: const TextStyle(
                        color: Colors.blue, // Cor do link
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Cadastro(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              );
            },
          ),
        ]),
      ),
    );
  }
}
