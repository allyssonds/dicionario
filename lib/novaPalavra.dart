import 'package:dicionario_sebastianico/database.dart';
import 'package:dicionario_sebastianico/palavra.dart';
import 'package:dicionario_sebastianico/theme.dart';
import 'package:flutter/material.dart';

class NovaPalavra extends StatelessWidget {
  final nomeController = TextEditingController();
  final significadoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color1,
        title: Text(
          "NOVA PALAVRA",
          style: TextStyle(color: color4),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Palavra",
              ),
              style: TextStyle(
                fontSize: 25,
              ),
              controller: nomeController,
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Significado",
              ),
              style: TextStyle(
                fontSize: 25,
              ),
              controller: significadoController,
            ),
            margin: EdgeInsets.only(bottom: 30),
          ),
          RaisedButton(
            padding: EdgeInsets.all(15),
            color: color2,
            textColor: Colors.white,
            child: Text("SALVAR"),
            onPressed: () async {
              Palavra novaPalavra = Palavra(
                  nome: nomeController.text,
                  significado: significadoController.text);
              await DBhelper().inserirPalavra(novaPalavra);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
