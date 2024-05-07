import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Conexao {
  static const _dbname = "myvan.db";
  static const _sqlMotorista =
      'CREATE TABLE MOTORISTA(codigo INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, telefone TEXT)';
  static const _sqlTipoVeiculo =
      'CREATE TABLE TIPO_VEICULO(codigo INTEGER PRIMARY KEY AUTOINCREMENT, descricao TEXT)';

  Conexao._privateConstructor();
  static final Conexao instance = Conexao._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    return _database ??= await initDB();
  }

  Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final database = await openDatabase(join(dbPath, _dbname), version: 1,
        onCreate: (db, version) async {
      await db.execute(_sqlMotorista);
      await db.execute(_sqlTipoVeiculo);
    });
    _database = database;
    return database;
  }
}
