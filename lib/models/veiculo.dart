import 'package:myvan_flutter/models/tipo_veiculo.dart';

class Veiculo {
  final int codigo;
  final TipoVeiculo tipoVeiculo;
  final String placa;
  final String cor;
  final int capacidadePassageiros;

  Veiculo(
      {required this.codigo,
      required this.tipoVeiculo,
      required this.placa,
      required this.cor,
      required this.capacidadePassageiros});
}
