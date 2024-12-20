import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(RandomFoxApp());
}

class RandomFoxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RandomFoxScreen(),
    );
  }
}

class RandomFoxScreen extends StatefulWidget {
  @override
  _RandomFoxScreenState createState() => _RandomFoxScreenState();
}

class _RandomFoxScreenState extends State<RandomFoxScreen> {
  String _foxImageUrl = '';

  // Função para consumir a API e obter uma nova imagem
  Future<void> fetchRandomFoxImage() async {
    final response = await http.get(Uri.parse('https://randomfox.ca/floof/'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _foxImageUrl = data['image'];
      });
    } else {
      // Mostre um erro caso a API falhe
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to load image'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    // Carrega uma imagem ao iniciar o aplicativo
    fetchRandomFoxImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Fox Generator'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: _foxImageUrl.isEmpty
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    _foxImageUrl,
                    height: 300,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: fetchRandomFoxImage,
                    child: Text('Generate New Fox'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange, // Correct parameter
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
