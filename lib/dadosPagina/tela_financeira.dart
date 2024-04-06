library tela_financeira;

import 'package:joi_app/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Map mapCNPJ = {};

List<FutureBuilder<Container>> funcoesFinanceira = [
  retornarConsultaGeral(),
];

Container retornarTelaFinanceira() {
  List<String> botoesFinanceira = [
    'Consulta Geral', // Opção 1
    'Adicionar Gasto Fixo', // Opção 2
    'Remover Gasto Fixo', // Opção 3
    'Adicionar Saldo', // Opção 4
    'Remover Saldo', // Opção 5
  ];

  return Container(
    color: Colors.black87,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 23.0, horizontal: 8.0),
      child: GridView.builder(
        itemCount: botoesFinanceira.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 colunas
          mainAxisSpacing: 23.0, // Espaçamento vertical entre os itens
          crossAxisSpacing: 13.0, // Espaçamento horizontal entre os itens
          childAspectRatio: 1.5, // Relação entre a altura e a largura dos itens
        ),
        itemBuilder: (BuildContext context, int index) {
          return FloatingActionButton(
            onPressed: () {
              MyHomePageState pageState = myGlobalKey.currentState!;

              telaAtual = funcoesFinanceira[index];

              pageState.atualizarPagina(telaAtual);
            },
            tooltip: botoesFinanceira.elementAt(index),
            child: Text(
              botoesFinanceira.elementAt(index),
              textAlign: TextAlign.center,
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

Future<Container> consultaTesteCNPJ() async {
  final response = await http
      .get(Uri.parse('https://receitaws.com.br/v1/cnpj/06947283000160'));

  if (response.statusCode == 200) {
    mapCNPJ = jsonDecode(response.body);
  }

  return Container(
    color: Colors.black87,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            mapCNPJ['nome'].toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 21,
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    ),
  );
}

FutureBuilder<Container> retornarConsultaGeral() {
  return FutureBuilder<Container>(
    future: consultaTesteCNPJ(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (snapshot.hasError) {
        return const Center(
          child: Text('Erro ao carregar o container.'),
        );
      } else {
        return snapshot.data ?? Container();
      }
    },
  );
}
