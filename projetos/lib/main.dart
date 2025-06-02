import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Oloco Meu", // Título do aplicativo
      theme: _getAppTheme(), // Chama o método para obter o tema do aplicativo
      home: _getHomePage(), // Chama o método para construir a página inicial
    );
  }

  // Método para obter o tema do aplicativo
  ThemeData _getAppTheme() {
    return ThemeData(
      primarySwatch: Colors.blue, // Cor principal do tema
      scaffoldBackgroundColor: Colors.white, // Cor de fundo da tela
    );
  }

  // Método para construir a página principal
  Widget _getHomePage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Oloco Meu"), // Título da barra superior (AppBar)
      ),
      body:
          _getBody(), // Chama o método que constrói o conteúdo principal da tela
    );
  }

  // Método para construir o conteúdo da tela (corpo da página)
  Widget _getBody() {
    return Center(
      child: Column(
        mainAxisSize:
            MainAxisSize.min, // Faz a Column ocupar o mínimo possível de espaço
        children: [
          _getImage(), // Chama o método para exibir a imagem
          const SizedBox(height: 10), // Espaço entre a imagem e o texto
          _getText(), // Chama o método para exibir o texto
        ],
      ),
    );
  }

  // Método para exibir a imagem
  Widget _getImage() {
    return Image.asset('assets/imagens/Circle.png'); // Caminho para a imagem
  }

  // Método para exibir o texto abaixo da imagem
  Widget _getText() {
    return const Text(
      'Texto abaixo da imagem', // Texto que será exibido
      style: TextStyle(fontSize: 18), // Estilo do texto (tamanho)
    );
  }
}
