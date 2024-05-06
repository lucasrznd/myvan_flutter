import 'package:myvan_flutter/models/motorista.dart';
import 'package:myvan_flutter/repositories/conexao.dart';
import 'package:sqflite/sqflite.dart';

class MotoristaRepository {
  Future<Database> get _db async => await Conexao.instance.database;

  Future<List<Motorista>> selectAll() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query('motorista');
    return List.generate(maps.length, (i) {
      return Motorista(
        codigo: maps[i]['codigo'],
        nome: maps[i]['nome'],
        telefone: maps[i]['telefone'],
      );
    });
  }

  Future<void> insert(Motorista motorista) async {
    final db = await _db;
    await db.insert('motorista', motorista.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(Motorista motorista) async {
    final db = await _db;
    await db.update('motorista', motorista.toMap(),
        where: 'codigo = ?', whereArgs: [motorista.codigo]);
  }

  Future<void> delete(int codigo) async {
    final db = await _db;
    await db.delete(
      'motorista',
      where: 'codigo = ?',
      whereArgs: [codigo],
    );
  }
}
