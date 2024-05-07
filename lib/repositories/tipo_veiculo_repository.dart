import 'package:myvan_flutter/models/tipo_veiculo.dart';
import 'package:myvan_flutter/repositories/conexao.dart';
import 'package:sqflite/sqflite.dart';

class TipoVeiculoRepository {
  Future<Database> get _db async => await Conexao.instance.database;

  Future<List<TipoVeiculo>> selectAll() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query('tipo_veiculo');
    return List.generate(maps.length, (i) {
      return TipoVeiculo(
        codigo: maps[i]['codigo'],
        descricao: maps[i]['descricao'],
      );
    });
  }

  Future<void> insert(TipoVeiculo tipoVeiculo) async {
    final db = await _db;
    await db.insert('tipo_veiculo', tipoVeiculo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(TipoVeiculo tipoVeiculo) async {
    final db = await _db;
    await db.update('tipo_veiculo', tipoVeiculo.toMap(),
        where: 'codigo = ?', whereArgs: [tipoVeiculo.codigo]);
  }

  Future<void> delete(int codigo) async {
    final db = await _db;
    await db.delete(
      'tipo_veiculo',
      where: 'codigo = ?',
      whereArgs: [codigo],
    );
  }
}
