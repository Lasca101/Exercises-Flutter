import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  CadastroState createState() => CadastroState();
}

class CadastroState extends State<Cadastro> {
  String? _selectedGender = 'Masculino'; // Controla o gênero selecionado
  bool _emailNotification = true; // Controla se as notificações por e-mail estão ativas
  bool _cellNotification = false; // Controla se as notificações por celular estão ativas

  @override
  Widget build(BuildContext context) {
    // Obtém a largura da tela
    double screenWidth = MediaQuery.of(context).size.width;

    // Define uma largura apropriada, dependendo do tamanho da tela
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
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0), // Espaçamento ao redor do conteúdo
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: formWidth, // Largura do formulário, conforme o tamanho da tela
            ),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: const TextField(
                    maxLength: 10,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      border: UnderlineInputBorder(), // Apenas borda inferior
                    ),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  color: Colors.white,
                  child: const TextField(
                    maxLength: 20,
                    decoration: InputDecoration(
                      labelText: 'Data de Nascimento',
                      border: UnderlineInputBorder(), // Apenas borda inferior
                    ),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  color: Colors.white,
                  child: const TextField(
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      border: UnderlineInputBorder(), // Apenas borda inferior
                    ),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Campo de senha com botão de visibilidade
                Container(
                  color: Colors.white,
                  child: const PasswordField(),
                ),
                const SizedBox(height: 20),
                // Campo de gênero
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
                // Campo de notificações
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
                ElevatedButton(
                  onPressed: () {
                    // Lógica de registro ou validação pode ser colocada aqui
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Cor de fundo do botão
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // Bordas arredondadas
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 16), // Tamanho do botão
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
    );
  }
}

// Widget do campo de senha com botão de visibilidade
class PasswordField extends StatefulWidget {
  const PasswordField({super.key});

  @override
  PasswordFieldState createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordField> {
  bool _isObscure = true; // Controla se a senha está visível ou não

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 20,
      obscureText: _isObscure, // Define a visibilidade da senha
      decoration: InputDecoration(
        labelText: 'Senha',
        border: const UnderlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(
            _isObscure ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure; // Alterna a visibilidade
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
