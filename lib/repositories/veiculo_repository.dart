import 'package:myvan_flutter/models/veiculo.dart';
import 'package:myvan_flutter/repositories/conexao.dart';
import 'package:sqflite/sqflite.dart';

class VeiculoRepository {
  Future<Database> get _db async => await Conexao.instance.database;

  Future<List<Veiculo>> selectAll() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query('veiculo');
    return List.generate(maps.length, (i) {
      return Veiculo(
        codigo: maps[i]['codigo'],
        tipoVeiculo: maps[i]['tipo_veiculo_codigo'],
        placa: maps[i]['placa'],
        cor: maps[i]['cor'],
        capacidadePassageiros: maps[i]['capacidade_passageiros'],
      );
    });
  }

  Future<void> insert(Veiculo veiculo) async {
    final db = await _db;
    await db.insert('veiculo', veiculo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(Veiculo veiculo) async {
    final db = await _db;
    await db.update('veiculo', veiculo.toMap(),
        where: 'codigo = ?', whereArgs: [veiculo.codigo]);
  }

  Future<void> delete(int codigo) async {
    final db = await _db;
    await db.delete('veiculo', where: 'codigo = ?', whereArgs: [codigo]);
  }
}
