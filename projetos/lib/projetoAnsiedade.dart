import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.black87),
      home: _getHomePagTop(),
    );
  }
}

// 🔑 GlobalKey usada para acessar o estado de AnimatedImage
final GlobalKey<_AnimatedImageState> animatedImageKey =
    GlobalKey<_AnimatedImageState>();
final AudioPlayer _audioPlayer = AudioPlayer();
bool _isPlaying = false;

// ================= TELA PRINCIPAL =================
Widget _getHomePagTop() {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.black87,
      centerTitle: true,
      title: const Text(
        "Olá, espero conseguir ajudar você",
        style: TextStyle(fontSize: 19, color: Colors.white),
      ),
    ),
    body: _getBody(),
  );
}

Widget _getBody() {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [_getImagem(), const SizedBox(height: 30), _getText()],
    ),
  );
}

Widget _getImagem() {
  return AnimatedImage(
    key: animatedImageKey,
  ); // passa a chave para controle externo
}

// ================= TEXTOS E BOTÕES =================
Widget _getText() {
  return Column(
    children: [
      const SizedBox(height: 30),
      _getStartButton(),
      const SizedBox(height: 15),
      _getPauseButton(),
      const SizedBox(height: 15),
      _getPlayConselho(),
    ],
  );
}

// ===== BOTÃO INICIAR =====
Widget _getStartButton() {
  return ElevatedButton(
    onPressed: () {
      animatedImageKey.currentState?.startAnimation();
    },
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(const Color(0xFF37AEAE)),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      ),
    ),
    child: const Text(
      "Iniciar",
      style: TextStyle(fontSize: 17, color: Colors.white),
    ),
  );
}

// ===== BOTÃO PAUSAR =====
Widget _getPauseButton() {
  return ElevatedButton(
    onPressed: () {
      animatedImageKey.currentState?.pauseAnimation();
    },
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(const Color(0xFF37AEAE)),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      ),
    ),
    child: const Text(
      "Pausar",
      style: TextStyle(fontSize: 17, color: Colors.white),
    ),
  );
}

Widget _getPlayConselho() {
  return ElevatedButton(
    onPressed: () async {
      if (_isPlaying) {
        await _audioPlayer.pause();
        _isPlaying = false;
      } else {
        await _audioPlayer.play(AssetSource('audios/Conselho.mp3'));
        _isPlaying = true;
      }
    },
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(const Color(0xFF37AEAE)),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      ),
    ),
    child: const Text(
      "Ouvir Conselho/Pausar Conselho",
      style: TextStyle(fontSize: 17, color: Colors.white),
    ),
  );
}

// =============== WIDGET COM ANIMAÇÃO ===============

class AnimatedImage extends StatefulWidget {
  const AnimatedImage({super.key});

  @override
  State<AnimatedImage> createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  String _respirationText = "Inspire";

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), // ciclo completo 10s
    );

    _animation = Tween<double>(
      begin: 0.9,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Aqui, mudamos o texto conforme o status da animação
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        // animação indo do início para o fim: inspirar
        setState(() {
          _respirationText = "Inspire";
        });
      } else if (status == AnimationStatus.reverse) {
        // animação retornando do fim para o início: expirar
        setState(() {
          _respirationText = "Expire";
        });
      }
    });
  }

  void startAnimation() {
    _controller.repeat(reverse: true);
  }

  void pauseAnimation() {
    _controller.stop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ScaleTransition(
          scale: _animation,
          child: Image.asset("assets/imagens/Circle.png", height: 220),
        ),
        const SizedBox(height: 20),
        Text(
          _respirationText,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ],
    );
  }
}
