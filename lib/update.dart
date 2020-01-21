import 'package:dicionario_sebastianico/database.dart';
import 'package:dicionario_sebastianico/palavra.dart';

import 'package:flutter/material.dart';

class UpdatePalavra extends StatelessWidget {
  final novoNomeController = TextEditingController();
  final novoSignificadoController = TextEditingController();

  final Palavra palavra;

  UpdatePalavra({Key key, @required this.palavra}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Atualizar Palavra"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            TextField(
              controller: novoNomeController,
              decoration: InputDecoration(
                hintText: palavra.nome,
                // labelText: "Palavra",
                helperText: "Palavra",
              ),
            ),
            TextField(
              controller: novoSignificadoController,
              decoration: InputDecoration(
                hintText: palavra.significado,
                // labelText: "Palavra",
                helperText: "Significado",
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
            ),
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              padding: EdgeInsets.all(15),
              child: Text("Atualizar"),
              onPressed: () async {
                await DBhelper().updatePalavra(
                  Palavra(
                    id: palavra.id,
                    nome: (novoNomeController.text.isEmpty ? palavra.nome : novoNomeController.text),
                    significado: (novoSignificadoController.text.isEmpty ? palavra.significado : novoSignificadoController.text),
                  ),
                );
                Navigator.pop(context);
              },
            ),
            Text(novoNomeController.text),
          ],
        ),
      ),
    );
  }
}
