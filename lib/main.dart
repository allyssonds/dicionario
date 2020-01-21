import 'package:dicionario_sebastianico/database.dart';
import 'package:dicionario_sebastianico/novaPalavra.dart';
import 'package:dicionario_sebastianico/palavra.dart';
import 'package:dicionario_sebastianico/update.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(
    MaterialApp(
      theme: ThemeData.light(),
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var palavras = DBhelper().palavras();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Dicionario Sebastianico"),
        ),
        body: Corpo(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NovaPalavra()),
            );
          },
        ),
      ),
    );
  }
}

class Corpo extends StatefulWidget {
  @override
  _CorpoState createState() => _CorpoState();
}

class _CorpoState extends State<Corpo> {
  Future dialog() {
    return showDialog(
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Palavra>>(
      future: DBhelper().palavras(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          // return: show loading widget
        }
        if (snapshot.hasError) {
          // return: show error widget
        }
        List<Palavra> palavras = snapshot.data ?? [];
        return ListView.builder(
          itemCount: palavras.length,
          itemBuilder: (context, index) {
            Palavra palavra = palavras[index];
            return new ListTile(
              title: Text(
                palavra.nome,
                style: TextStyle(fontSize: 25),
              ),
              subtitle: Text(
                'Significado: ' + palavra.significado,
                style: TextStyle(fontSize: 15),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => new AlertDialog(
                      title: Text("APAGAR ?"),
                      actions: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: Row(
                            children: <Widget>[
                              FlatButton(
                                child: Text("SIM"),
                                onPressed: () async {
                                  await DBhelper().deletePalavra(palavra.id);
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                              ),
                              FlatButton(
                                child: Text("NÃO"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                  setState(() {});
                },
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdatePalavra(
                    palavra: palavra,
                  ),
                ),
              ),
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => new AlertDialog(
                    title: Text("APAGAR ?"),
                    actions: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          children: <Widget>[
                            FlatButton(
                              child: Text("SIM"),
                              onPressed: () async {
                                await DBhelper().deletePalavra(palavra.id);
                                Navigator.pop(context);
                                setState(() {});
                              },
                            ),
                            FlatButton(
                              child: Text("NÃO"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
                setState(() {});
              },
            );
          },
        );
      },
    );
  }
}
