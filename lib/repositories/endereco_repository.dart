import 'package:myvan_flutter/models/endereco.dart';
import 'package:myvan_flutter/repositories/conexao.dart';
import 'package:sqflite/sqflite.dart';

class EnderecoRepository {
  Future<Database> get _db async => await Conexao.instance.database;

  Future<List<Endereco>> selectAll() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query('endereco');
    return List.generate(maps.length, (i) {
      return Endereco(
        codigo: maps[i]['codigo'],
        rua: maps[i]['rua'],
        bairro: maps[i]['bairro'],
        numero: maps[i]['numero'],
        cidade: maps[i]['cidade'],
      );
    });
  }

  Future<void> insert(Endereco endereco) async {
    final db = await _db;
    await db.insert('endereco', endereco.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(Endereco endereco) async {
    final db = await _db;
    await db.update('endereco', endereco.toMap(),
        where: 'codigo = ?', whereArgs: [endereco.codigo]);
  }

  Future<void> delete(int codigo) async {
    final db = await _db;
    await db.delete('endereco', where: 'codigo = ?', whereArgs: [codigo]);
  }

  Future<Endereco> obterUltimo() async {
    try {
      final db = await _db;

      List<Map<String, dynamic>> maps =
          await db.rawQuery('SELECT * FROM endereco ORDER BY codigo DESC LIMIT 1');

      if (maps.isNotEmpty) {
        return Endereco(
          codigo: maps[0]['codigo'],
          rua: maps[0]['rua'],
          bairro: maps[0]['bairro'],
          numero: maps[0]['numero'],
          cidade: maps[0]['cidade'],
        );
      } else {
        return Endereco(codigo: 0, rua: '', bairro: '', numero: 0, cidade: '');
      }
    } catch (e) {
      return Endereco(codigo: 0, rua: '', bairro: '', numero: 0, cidade: '');
    }
  }
}
