import 'package:dicionario/database.dart';
import 'package:dicionario/novaPalavra.dart';
import 'package:dicionario/palavra.dart';
import 'package:dicionario/update.dart';
import 'package:dicionario/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "DICIONÁRIO",
            style: TextStyle(color: color4),
          ),
          backgroundColor: color1,
        ),
        body: Corpo(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: color1,
          mini: true,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NovaPalavra()),
            ).then((value) {
              setState(() {});
            });
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
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color2,
      child: FutureBuilder<List<Palavra>>(
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
              return Container(
                decoration: BoxDecoration(
                  color: color3,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(2),
                child: ListTile(
                  tileColor: color3,
                  title: Text(
                    palavra.nome,
                    style: TextStyle(fontSize: 25, color: color4),
                  ),
                  subtitle: Text(
                    'Significado: ' + palavra.significado,
                    style: TextStyle(fontSize: 15, color: color4),
                  ),
                  trailing: IconButton(
                    color: color4,
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await buildShowDialog(context, palavra);
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
                  ).then((value) {
                    setState(() {});
                  }),
                  onLongPress: () async {
                    await buildShowDialogOnLongPress(context, palavra);
                    setState(() {});
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  buildShowDialogOnLongPress(BuildContext context, Palavra palavra) async {
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
  }

  buildShowDialog(BuildContext context, Palavra palavra) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => new AlertDialog(
        backgroundColor: color4,
        title: Text("APAGAR ?"),
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                FlatButton(
                  child: Text(
                    "SIM",
                    style: TextStyle(
                      color: color2,
                    ),
                  ),
                  onPressed: () async {
                    await DBhelper().deletePalavra(palavra.id);
                    Navigator.pop(context);
                    setState(() {});
                  },
                ),
                FlatButton(
                  child: Text(
                    "NÃO",
                    style: TextStyle(
                      color: color1,
                    ),
                  ),
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
  }
}
