import 'dart:convert'; // Import necessário para conversão de JSON
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  CadastroState createState() => CadastroState();
}

class CadastroState extends State<Cadastro> {
  String? _selectedGender = 'Masculino';
  bool _emailNotification = true;
  bool _cellNotification = false;
  bool _isLoading = false; // Controla o estado de carregamento

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _register() async {
    setState(() {
      _isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();

    // Cria um mapa para o novo usuário
    Map<String, dynamic> newUser = {
      'name': _nameController.text,
      'dob': _dobController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
      'gender': _selectedGender ?? 'Masculino',
      'emailNotification': _emailNotification,
      'cellNotification': _cellNotification,
    };

    // Carrega a lista de usuários existente
    List<String> userList = prefs.getStringList('users') ?? [];

    // Adiciona o novo usuário à lista
    userList.add(
        jsonEncode(newUser)); // Converte o mapa para JSON e adiciona à lista

    // Salva a lista atualizada no SharedPreferences
    await prefs.setStringList('users', userList);

    // Define o e-mail do usuário recém-cadastrado como o usuário ativo (logado)
    await prefs.setString('currentUserEmail', _emailController.text);

    // Verifica se o widget ainda está montado antes de navegar
    if (mounted) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/navUser', (Route<dynamic> route) => false);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double formWidth = screenWidth < 600 ? 300 : 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Create an account'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
      body: Container(
        color: Colors.lightBlue[50],
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: formWidth,
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      border: UnderlineInputBorder(),
                    ),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _dobController,
                    maxLength: 20,
                    decoration: const InputDecoration(
                      labelText: 'Data de Nascimento',
                      border: UnderlineInputBorder(),
                    ),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      border: UnderlineInputBorder(),
                    ),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  PasswordField(controller: _passwordController),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        'Gênero:',
                        style: TextStyle(fontSize: 16),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('Masculino'),
                          value: 'Masculino',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('Feminino'),
                          value: 'Feminino',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Notificações:',
                    style: TextStyle(fontSize: 16),
                  ),
                  SwitchListTile(
                    title: const Text('E-mail'),
                    value: _emailNotification,
                    onChanged: (bool value) {
                      setState(() {
                        _emailNotification = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Celular'),
                    value: _cellNotification,
                    onChanged: (bool value) {
                      setState(() {
                        _cellNotification = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 120, vertical: 16),
                          ),
                          child: const Text('Register',
                              style: TextStyle(
                                color: Colors.white,
                              )),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  const PasswordField({super.key, required this.controller});

  @override
  PasswordFieldState createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      maxLength: 20,
      obscureText: _isObscure,
      decoration: InputDecoration(
        labelText: 'Senha',
        border: const UnderlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(
            _isObscure ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        ),
      ),
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }
}
