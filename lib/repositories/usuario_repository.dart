import 'package:myvan_flutter/models/usuario.dart';
import 'package:myvan_flutter/repositories/conexao.dart';
import 'package:sqflite/sqflite.dart';

class UsuarioRepository {
  Future<Database> get _db async => await Conexao.instance.database;

  Future<bool> login(Usuario usuario) async {
    final db = await _db;
    var result = await db.rawQuery(
        "SELECT * FROM USUARIO WHERE nome_usuario = '${usuario.nomeUsuario}' AND senha = '${usuario.senha}'");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getByNomeUsuario(String nomeUsuario) async {
    final db = await _db;
    var result = await db
        .rawQuery("SELECT * FROM USUARIO WHERE nome_usuario = '$nomeUsuario'");
    if (result.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> insert(Usuario usuario) async {
    final db = await _db;
    await db.insert('usuario', usuario.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
