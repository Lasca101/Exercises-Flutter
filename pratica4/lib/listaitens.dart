import 'package:flutter/material.dart';

class ListaItens extends StatefulWidget {
  const ListaItens({super.key});

  @override
  ListaItensState createState() => ListaItensState();
}

class ListaItensState extends State<ListaItens> {
  @override
  Widget build(BuildContext context) {
    // Recebe o argumento enviado pela rota
    final String nome;
    if (ModalRoute.of(context)!.settings.arguments != null){
      nome = ModalRoute.of(context)!.settings.arguments as String;
    } else {
      nome = 'Usuário';
    }

    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Bem vindo(a), $nome'),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item ${index + 1}'),
            onTap: () {
              _mostrarDialog(context, index + 1);
            },
          );
        },
      ),
    );
  }

  void _mostrarDialog(BuildContext context, int numeroItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.lightBlue[50],
          title: const Text('Alerta'),
          content: Text('Você clicou no item $numeroItem'),
          actions: <Widget>[
            TextButton(
              child: const Text('Sim'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Não'),
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