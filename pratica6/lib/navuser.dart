import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/listaitens.dart';
import 'package:flutter_application_1/perfil.dart';
import 'package:flutter_application_1/home.dart';

class NavUser extends StatelessWidget {
  const NavUser({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainPage();
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // Lista de widgets que representam as telas de cada item do BottomNavigationBar
  static const List<Widget> _pages = <Widget>[
    Home(),
    ListaItens(),
    Perfil(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();

    // Remove apenas o e-mail do usuário atual para "deslogar" sem excluir cadastros
    await prefs.remove('currentUserEmail');

    if (mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/', (route) => false); // Navega para a tela de login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[
              _selectedIndex], // Mostra a tela de acordo com o item selecionado
          Positioned(
            top: 8,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.logout),
              color: Colors.black,
              onPressed: _logout,
              tooltip: 'Logout',
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white, // Cor do ícone selecionado
        unselectedItemColor: Colors.black, // Cor dos ícones não selecionados
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex, // Indica o item selecionado
        onTap: _onItemTapped, // Chama a função para alterar a aba
      ),
    );
  }
}
