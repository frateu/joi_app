library tela_treinamento;

import 'package:joi_app/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<dynamic> listTreinamento = [];

List<FutureBuilder<Container>> funcoesTreinamento = [
  retornarConsultaTreinoDia('2'),
  retornarConsultaTreinoDia('4'),
  retornarConsultaTreinoDia('6')
];

Container retornarTelaTreinamento() {
  List<String> botoesFinanceira = [
    'Segunda', // Opção 1
    'Quarta', // Opção 2
    'Sexta', // Opção 3
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

              telaAtual = funcoesTreinamento[index];

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

Future<Container> consultaTreinoDia(var diaSemana) async {
  final response = await http
      .get(Uri.parse('http://10.0.0.119:8080/joi/treinoAcademiaDia?pDiaSemana=$diaSemana'));

  if (response.statusCode == 200) {
    listTreinamento = jsonDecode(response.body);
  }

  return Container(
    padding: const EdgeInsets.all(16.0),
    color: Colors.black87,
    child: Center (
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var infoTreino in listTreinamento)
            Container(
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${infoTreino['nomeTreino']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    'Series: ${infoTreino['seriesTreino']} | Repetições: ${infoTreino['repeticoesTreino']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    )
  );
}

FutureBuilder<Container> retornarConsultaTreinoDia(var diaSemana) {
  return FutureBuilder<Container>(
    future: consultaTreinoDia(diaSemana),
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
