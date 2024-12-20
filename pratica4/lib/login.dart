import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  void _loginAction(BuildContext context) {
    String email = _emailController.text;
    String senha = _senhaController.text;

    if (email == "eumesmo@gmail.com" && senha == "12345") {
      // Navegar para a página de lista de itens
      Navigator.pushNamed(
        context,
        '/listaitens',
        arguments: 'Tiago', // Aqui você pode enviar o nome
      );
    } else {
      // Mostrar AlertDialog para erro
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.lightBlue[50], // Altere a cor aqui
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
            child: TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 16.0),
                labelText: 'E-mail',
                border: UnderlineInputBorder(), // Apenas borda inferior
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
                border: UnderlineInputBorder(), // Apenas borda inferior
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

            RichText(
              text: const TextSpan(
                text: 'New here? ',
                children: <TextSpan>[
                  TextSpan(
                    text: 'Create an account',
                    style: TextStyle(
                      color: Colors.blue, // Cor do link
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ]),
      ),


      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lightBlue[100],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Minha conta',
          )
        ],
      ),
    );
  }
}