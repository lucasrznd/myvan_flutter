import 'package:myvan_flutter/models/endereco.dart';

class Passageiro {
  final int codigo;
  final String nome;
  final String telefone;
  final Endereco endereco;

  Passageiro({
    required this.codigo,
    required this.nome,
    required this.telefone,
    required this.endereco,
  });
}
