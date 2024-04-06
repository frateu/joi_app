library tela_principal;

import 'package:flutter/material.dart';

Container retornarTelaPrincipal() {
  return Container(
    color: Colors.black87,
    child: const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Oi Amor! ❤️",
            style: TextStyle(
              color: Colors.white,
              fontSize: 21,
            ),
          ), // Usando spread operator para adicionar os widgets da lista
          SizedBox(height: 20.0),
        ],
      ),
    ),
  );
}
