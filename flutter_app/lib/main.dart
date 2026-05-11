import 'package:flutter/material.dart';

void main() => runApp(const OlaMundoApp());

class OlaMundoApp extends StatelessWidget {
  const OlaMundoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Olá Mundo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  String _resposta = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(_atualizarResposta);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _atualizarResposta() {
    final normalizado = _removerAcentos(_controller.text.trim().toLowerCase());
    setState(() {
      _resposta = (normalizado == 'ola') ? 'olá mundo' : '';
    });
  }

  static String _removerAcentos(String texto) {
    const comAcento = 'áàâãäåéèêëíìîïóòôõöúùûüçñÁÀÂÃÄÅÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇÑ';
    const semAcento = 'aaaaaaeeeeiiiiooooouuuucnAAAAAAEEEEIIIIOOOOOUUUUCN';
    final mapa = <int, int>{
      for (var i = 0; i < comAcento.length; i++)
        comAcento.codeUnitAt(i): semAcento.codeUnitAt(i),
    };
    return String.fromCharCodes(
      texto.codeUnits.map((c) => mapa[c] ?? c),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
          child: Column(
            children: [
              const Text(
                'Digite algo',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _controller,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Escreva aqui...',
                ),
              ),
              const SizedBox(height: 32),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: Text(
                  _resposta,
                  key: ValueKey<String>(_resposta),
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
