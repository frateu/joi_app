import 'package:flutter/material.dart';
import 'dadosPagina/tela_principal.dart';
import 'dadosPagina/tela_financeira.dart';
import 'dadosPagina/tela_treinamento.dart';

var telaAtual;

void main() {
  runApp(const MyApp());
}

GlobalKey<MyHomePageState> myGlobalKey = GlobalKey<MyHomePageState>();

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
      home: MyHomePage(key: myGlobalKey),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  bool exibirPaginaPrincipal = true;
  bool exibirPaginaFinanceiro = false;
  bool exibirPaginaLembretes = false;
  bool exibirPaginaTreinamento = false;

  void actionPaginaPrincipal() {
    setState(() {
      exibirPaginaPrincipal = true;
      exibirPaginaFinanceiro = false;
      exibirPaginaLembretes = false;
      exibirPaginaTreinamento = false;
    });
  }

  void actionPaginaFinanceiro() {
    setState(() {
      exibirPaginaPrincipal = false;
      exibirPaginaFinanceiro = true;
      exibirPaginaLembretes = false;
      exibirPaginaTreinamento = false;
    });
  }

  void actionPaginaLembretes() {
    setState(() {
      exibirPaginaPrincipal = false;
      exibirPaginaFinanceiro = false;
      exibirPaginaLembretes = true;
      exibirPaginaTreinamento = false;
    });
  }

  void actionPaginaTreinamento() {
    setState(() {
      exibirPaginaPrincipal = false;
      exibirPaginaFinanceiro = false;
      exibirPaginaLembretes = false;
      exibirPaginaTreinamento = true;
    });
  }

  void atualizarPagina(var telaAtualizada) {
    setState(() {
      telaAtual = telaAtualizada;

      exibirPaginaPrincipal = false;
      exibirPaginaFinanceiro = false;
      exibirPaginaLembretes = false;
      exibirPaginaTreinamento = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Seta a pagina principal como a inicial
    //telaAtual = retornarTelaPrincipal();

    // Seleção da exibição da tela
    if (exibirPaginaPrincipal) {
      telaAtual = retornarTelaPrincipal();
    } else if (exibirPaginaFinanceiro) {
      telaAtual = retornarTelaFinanceira();
    } else if (exibirPaginaLembretes) {
      //telaAtual = retornarTelaLembretes();
    } else if (exibirPaginaTreinamento) {
      telaAtual = retornarTelaTreinamento();
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
              leading: const Icon(Icons.favorite),
              title: const Text('Principal'),
              onTap: () {
                actionPaginaPrincipal();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text('Financeiro'),
              onTap: () {
                actionPaginaFinanceiro();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.access_alarm),
              title: const Text('Lembretes'),
              onTap: () {
                actionPaginaLembretes();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.fitness_center),
              title: const Text('Treinamento'),
              onTap: () {
                actionPaginaTreinamento();
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      body: telaAtual,
    );
  }
}
