import 'package:myvan_flutter/models/passageiro.dart';
import 'package:myvan_flutter/models/viagem.dart';

class ViagemPassageiro {
  final int codigo;
  final Viagem viagem;
  final Passageiro passageiro;
  final bool statusChamada;

  ViagemPassageiro(
      {required this.codigo,
      required this.viagem,
      required this.passageiro,
      required this.statusChamada});
}
