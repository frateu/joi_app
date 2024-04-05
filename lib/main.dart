import 'package:flutter/material.dart';
import 'dadosPagina/tela_principal.dart';
import 'dadosPagina/tela_financeira.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JOI ❤️',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(203, 109, 182, 100)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'JOI ❤️'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _exibirPaginaPrincipal = true;
  bool _exibirPaginaFinanceiro = false;
  bool _exibirPaginaLembretes = false;

  List<String> botaoPaginaAtual = [];

  void _actionPaginaPrincipal() {
    setState(() {
      _exibirPaginaPrincipal = true;
      _exibirPaginaFinanceiro = false;
      _exibirPaginaLembretes = false;
    });
  }

  void _actionPaginaFinanceiro() {
    setState(() {
      _exibirPaginaPrincipal = false;
      _exibirPaginaFinanceiro = true;
      _exibirPaginaLembretes = false;
    });
  }

  void _actionPaginaLembretes() {
    setState(() {
      _exibirPaginaPrincipal = false;
      _exibirPaginaFinanceiro = false;
      _exibirPaginaLembretes = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Seta a pagina principal como a inicial
    botaoPaginaAtual = botoesPrincipal;

    // Seleção da exibição da tela
    if (_exibirPaginaPrincipal) {
      botaoPaginaAtual = botoesPrincipal;
    } else if (_exibirPaginaFinanceiro) {
      botaoPaginaAtual = botoesFinanceira;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('JOI ❤️'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(203, 109, 182, 100),
              ),
              child: Text(
                'Suas opções, amor ❤️',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.accessibility_new),
              title: const Text('Principal'),
              onTap: () {
                _actionPaginaPrincipal();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text('Financeiro'),
              onTap: () {
                _actionPaginaFinanceiro();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.access_alarm),
              title: const Text('Lembretes'),
              onTap: () {
                _actionPaginaLembretes();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.black87,
        child: GridView.builder(
          itemCount: botaoPaginaAtual.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 colunas
            mainAxisSpacing: 13.0, // Espaçamento vertical entre os itens
            crossAxisSpacing: 13.0, // Espaçamento horizontal entre os itens
            childAspectRatio: 1.5, // Relação entre a altura e a largura dos itens
          ),
          itemBuilder: (BuildContext context, int index) {
            return FloatingActionButton(
              onPressed: () {},
              tooltip: 'Increment',
              child: Text(
                botaoPaginaAtual.elementAt(index),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 21,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
