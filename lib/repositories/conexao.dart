import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Conexao {
  static const _dbname = "myvan.db";
  static const _sqlUsuario =
      'CREATE TABLE USUARIO(codigo INTEGER PRIMARY KEY, nome_usuario TEXT, senha TEXT)';
  static const _sqlMotorista =
      'CREATE TABLE MOTORISTA(codigo INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, telefone TEXT)';
  static const _sqlTipoVeiculo =
      'CREATE TABLE TIPO_VEICULO(codigo INTEGER PRIMARY KEY AUTOINCREMENT, descricao TEXT)';
  static const _sqlVeiculo =
      'CREATE TABLE VEICULO(codigo INTEGER PRIMARY KEY AUTOINCREMENT, tipo_veiculo_codigo INTEGER, placa TEXT, cor TEXT, capacidade_passageiros INTEGER, FOREIGN KEY (tipo_veiculo_codigo) REFERENCES TIPO_VEICULO(codigo))';
  static const _sqlPassageiro =
      'CREATE TABLE PASSAGEIRO(codigo INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, telefone TEXT, endereco_codigo INTEGER)';
  static const _sqlEndereco =
      'CREATE TABLE ENDERECO(codigo INTEGER PRIMARY KEY AUTOINCREMENT, rua TEXT, bairro TEXT, numero INTEGER, cidade TEXT)';
  static const _sqlViagem =
      'CREATE TABLE VIAGEM(codigo INTEGER PRIMARY KEY AUTOINCREMENT, descricao TEXT, veiculo_codigo INTEGER, motorista_codigo INTEGER, data TEXT, tipo_viagem TEXT)';
  static const _sqlChamada =
      'CREATE TABLE CHAMADA_PASSAGEIRO(codigo INTEGER PRIMARY KEY AUTOINCREMENT, viagem_codigo INTEGER, passageiro_codigo INTEGER, status_chamada INTEGER)';

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
      await db.execute(_sqlVeiculo);
      await db.execute(_sqlEndereco);
      await db.execute(_sqlPassageiro);
      await db.execute(_sqlViagem);
      await db.execute(_sqlChamada);
      await db.execute(_sqlUsuario);
    });
    _database = database;
    return database;
  }
}
