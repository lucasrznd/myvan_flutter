import 'package:intl/intl.dart';
import 'package:myvan_flutter/models/chamada_passageiro.dart';
import 'package:myvan_flutter/repositories/conexao.dart';
import 'package:sqflite/sqflite.dart';

class ChamadaRepository {
  Future<Database> get _db async => await Conexao.instance.database;

  Future<List<ChamadaPassageiro>> selectAllHoje(String tipoViagem) async {
    final db = await _db;

    // Obter a data atual sem considerar o horário
    String dataAtual = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT chamada_passageiro.*, viagem.data
    FROM chamada_passageiro
    INNER JOIN viagem ON chamada_passageiro.viagem_codigo = viagem.codigo
    WHERE date(viagem.data) = ? AND viagem.tipo_viagem = ?
  ''', [dataAtual, tipoViagem]);

    return List.generate(maps.length, (i) {
      return ChamadaPassageiro(
        codigo: maps[i]['codigo'],
        viagem: maps[i]['viagem_codigo'],
        passageiro: maps[i]['passageiro_codigo'],
        statusChamada: maps[i]['status_chamada'],
      );
    });
  }

  Future<List<ChamadaPassageiro>> selectAll() async {
    final db = await _db;

    // Obter a data atual sem considerar o horário
    String dataAtual = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT chamada_passageiro.*, viagem.data
    FROM chamada_passageiro
    INNER JOIN viagem ON chamada_passageiro.viagem_codigo = viagem.codigo
    WHERE date(viagem.data) = ? 
  ''', [dataAtual]);

    return List.generate(maps.length, (i) {
      return ChamadaPassageiro(
        codigo: maps[i]['codigo'],
        viagem: maps[i]['viagem_codigo'],
        passageiro: maps[i]['passageiro_codigo'],
        statusChamada: maps[i]['status_chamada'],
      );
    });
  }

  Future<List<ChamadaPassageiro>> listarPresentesHoje(String tipoViagem) async {
    final db = await _db;

    // Obter a data atual sem considerar o horário
    String dataAtual = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT chamada_passageiro.*, viagem.data
    FROM chamada_passageiro
    INNER JOIN viagem ON chamada_passageiro.viagem_codigo = viagem.codigo
    WHERE date(viagem.data) = ? AND chamada_passageiro.status_chamada = 1 AND viagem.tipo_viagem = ?
  ''', [dataAtual, tipoViagem]);

    return List.generate(maps.length, (i) {
      return ChamadaPassageiro(
        codigo: maps[i]['codigo'],
        viagem: maps[i]['viagem_codigo'],
        passageiro: maps[i]['passageiro_codigo'],
        statusChamada: maps[i]['status_chamada'],
      );
    });
  }

  Future<List<ChamadaPassageiro>> listarPresentes() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query('chamada_passageiro',
        where: 'status_chamada = ?', whereArgs: [1]);
    return List.generate(maps.length, (i) {
      return ChamadaPassageiro(
        codigo: maps[i]['codigo'],
        viagem: maps[i]['viagem_codigo'],
        passageiro: maps[i]['passageiro_codigo'],
        statusChamada: maps[i]['status_chamada'],
      );
    });
  }

  Future<List<ChamadaPassageiro>> listarAusentesHoje(String tipoViagem) async {
    final db = await _db;

    // Obter a data atual sem considerar o horário
    String dataAtual = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT chamada_passageiro.*, viagem.data
    FROM chamada_passageiro
    INNER JOIN viagem ON chamada_passageiro.viagem_codigo = viagem.codigo
    WHERE date(viagem.data) = ? AND chamada_passageiro.status_chamada = 0 AND viagem.tipo_viagem = ?
  ''', [dataAtual, tipoViagem]);

    return List.generate(maps.length, (i) {
      return ChamadaPassageiro(
        codigo: maps[i]['codigo'],
        viagem: maps[i]['viagem_codigo'],
        passageiro: maps[i]['passageiro_codigo'],
        statusChamada: maps[i]['status_chamada'],
      );
    });
  }

  Future<List<ChamadaPassageiro>> listarAusentes() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query('chamada_passageiro',
        where: 'status_chamada = ?', whereArgs: [0]);
    return List.generate(maps.length, (i) {
      return ChamadaPassageiro(
        codigo: maps[i]['codigo'],
        viagem: maps[i]['viagem_codigo'],
        passageiro: maps[i]['passageiro_codigo'],
        statusChamada: maps[i]['status_chamada'],
      );
    });
  }

  Future<void> insert(ChamadaPassageiro chamada) async {
    final db = await _db;
    await db.insert('chamada_passageiro', chamada.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(ChamadaPassageiro chamada) async {
    final db = await _db;
    await db.update('chamada_passageiro', chamada.toMap(),
        where: 'codigo = ?', whereArgs: [chamada.codigo]);
  }

  Future<void> delete(int codigo) async {
    final db = await _db;
    await db.delete(
      'chamada_passageiro',
      where: 'codigo = ?',
      whereArgs: [codigo],
    );
  }
}
