import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dicionario_sebastianico/palavra.dart';

class DBhelper {
  // CONNECTA AO BANCO DE DADOS
  _conectar() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'palavra_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE palavra(id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "nome TEXT,significado TEXT)",
        );
      },
      version: 1,
    );
    return database;
  }

  // RECEBE UM OBJETO DO TIPO PALAVRA E INSERE NO BANCO DE DADOS
  Future<void> inserirPalavra(Palavra palavra) async {
    final Database db = await _conectar();

    await db.insert(
      'palavra',
      palavra.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // BUSCA UMA LISTA DE MAPS DE PALAVRAS
  Future<List<Palavra>> palavras() async {
    final Database db = await _conectar();

    final List<Map<String, dynamic>> maps = await db.query('palavra');

    return List.generate(
      maps.length,
      (i) {
        return Palavra(
          id: maps[i]['id'],
          nome: maps[i]['nome'],
          significado: maps[i]['significado'],
        );
      },
    );
  }

  // UPDATE DE UMA PALAVRA
  Future<void> updatePalavra(Palavra palavra) async {
    final db = await _conectar();

    await db.update(
      'palavra',
      palavra.toMap(),
      where: "id = ?",
      whereArgs: [palavra.id],
    );
  }

  // DELETAR UMA PALAVRA
  Future<void> deletePalavra(int id) async {
    // Get a reference to the database.
    final db = await _conectar();

    // Remove the Dog from the database.
    await db.delete(
      'palavra',
      // Use a `where` clause to delete a specific palavra.
      where: "id = ?",
      // Pass the palavra's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
