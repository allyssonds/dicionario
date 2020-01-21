import 'package:dicionario_sebastianico/database.dart';
import 'package:dicionario_sebastianico/palavra.dart';
import 'package:flutter/material.dart';

class NovaPalavra extends StatefulWidget {
  @override
  _NovaPalavraState createState() => _NovaPalavraState();
}

class _NovaPalavraState extends State<NovaPalavra> {
  final nomeController = TextEditingController();
  final significadoController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nomeController.dispose();
    significadoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nova Palavra"),
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
            color: Colors.blue,
            textColor: Colors.white,
            child: Text("Salvar"),
            onPressed: () async {
              Palavra novaPalavra = Palavra(nome: nomeController.text, significado: significadoController.text);
              await DBhelper().inserirPalavra(novaPalavra);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
