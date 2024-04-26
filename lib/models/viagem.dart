import 'package:myvan_flutter/models/enums/tipo_viagem.dart';
import 'package:myvan_flutter/models/motorista.dart';
import 'package:myvan_flutter/models/veiculo.dart';

class Viagem {
  final int codigo;
  final Veiculo veiculo;
  final Motorista motorista;
  final DateTime data;
  final TipoViagem tipoViagem;

  Viagem(
      {required this.codigo,
      required this.veiculo,
      required this.motorista,
      required this.data,
      required this.tipoViagem});
}
