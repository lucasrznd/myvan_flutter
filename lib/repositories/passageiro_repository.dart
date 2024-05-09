import 'package:myvan_flutter/models/passageiro.dart';
import 'package:myvan_flutter/repositories/conexao.dart';
import 'package:sqflite/sqflite.dart';

class PassageiroRepository {
  Future<Database> get _db async => await Conexao.instance.database;

  Future<List<Passageiro>> selectAll() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query('passageiro');
    return List.generate(maps.length, (i) {
      return Passageiro(
        codigo: maps[i]['codigo'],
        nome: maps[i]['nome'],
        telefone: maps[i]['telefone'],
        endereco: maps[i]['endereco_codigo'],
      );
    });
  }

  Future<void> insert(Passageiro passageiro) async {
    final db = await _db;
    await db.insert('passageiro', passageiro.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(Passageiro passageiro) async {
    final db = await _db;
    await db.update('passageiro', passageiro.toMap(),
        where: 'codigo = ?', whereArgs: [passageiro.codigo]);
  }

  Future<void> delete(int codigo) async {
    final db = await _db;
    await db.delete('passageiro', where: 'codigo = ?', whereArgs: [codigo]);
  }
}
