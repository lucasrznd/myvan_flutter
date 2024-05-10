import 'package:myvan_flutter/models/enums/tipo_viagem.dart';
import 'package:myvan_flutter/models/motorista.dart';
import 'package:myvan_flutter/models/veiculo.dart';

class Viagem {
  int? codigo;
  String nomeViagem;
  int? veiculo;
  int? motorista;
  DateTime? data;
  String tipoViagem;

  Viagem({
    this.codigo,
    this.nomeViagem = '',
    this.veiculo,
    this.motorista,
    this.data,
    this.tipoViagem = '',
  });

  @override
  String toString() {
    return 'Viagem(codigo: $codigo, nome: $nomeViagem, veiculo: $veiculo, motorista: $motorista, data: $data), tipoViagem: $tipoViagem';
  }
}
