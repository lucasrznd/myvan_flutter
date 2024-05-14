import 'package:myvan_flutter/models/viagem.dart';
import 'package:myvan_flutter/repositories/conexao.dart';
import 'package:sqflite/sqflite.dart';

class ViagemRepository {
  Future<Database> get _db async => await Conexao.instance.database;

  Future<List<Viagem>> selectAll() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query('viagem');
    return List.generate(maps.length, (i) {
      return Viagem(
        codigo: maps[i]['codigo'],
        descricao: maps[i]['descricao'],
        veiculo: maps[i]['veiculo_codigo'],
        motorista: maps[i]['motorista_codigo'],
        data: maps[i]['data'],
        tipoViagem: maps[i]['tipo_viagem'],
      );
    });
  }

  Future<void> insert(Viagem viagem) async {
    final db = await _db;
    await db.insert('viagem', viagem.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(Viagem viagem) async {
    final db = await _db;
    await db.update('viagem', viagem.toMap(),
        where: 'codigo = ?', whereArgs: [viagem.codigo]);
  }

  Future<void> delete(int codigo) async {
    final db = await _db;
    await db.delete(
      'viagem',
      where: 'codigo = ?',
      whereArgs: [codigo],
    );
  }

  Future<Viagem> obterUltimaViagem(String tipoViagem) async {
    try {
      final db = await _db;

      List<Map<String, dynamic>> maps = await db.rawQuery(
          '''SELECT * FROM viagem WHERE viagem.tipo_viagem = ? ORDER BY codigo DESC LIMIT 1''',
          [tipoViagem]);

      if (maps.isNotEmpty) {
        return Viagem(
          codigo: maps[0]['codigo'],
          descricao: maps[0]['descricao'],
          tipoViagem: maps[0]['tipo_viagem'],
          data: maps[0]['data'],
          veiculo: maps[0]['veiculo'],
          motorista: maps[0]['motorista'],
        );
      } else {
        return Viagem(
            codigo: 0,
            descricao: '',
            tipoViagem: '',
            data: '',
            veiculo: 0,
            motorista: 0);
      }
    } catch (e) {
      return Viagem(
          codigo: 0,
          descricao: '',
          tipoViagem: '',
          data: '',
          veiculo: 0,
          motorista: 0);
    }
  }
}
