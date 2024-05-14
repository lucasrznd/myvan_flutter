import 'package:myvan_flutter/models/chamada_passageiro.dart';
import 'package:myvan_flutter/models/enums/tipo_viagem.dart';
import 'package:myvan_flutter/models/passageiro.dart';
import 'package:myvan_flutter/models/viagem.dart';
import 'package:myvan_flutter/repositories/chamada_repository.dart';
import 'package:myvan_flutter/repositories/passageiro_repository.dart';
import 'package:myvan_flutter/repositories/viagem_repository.dart';

class ChamadaService {
  final ChamadaRepository _repository = ChamadaRepository();

  void criarChamadaIda() async {
    ViagemRepository viagemRepository = ViagemRepository();
    PassageiroRepository passageiroRepository = PassageiroRepository();
    Viagem viagem =
        await viagemRepository.obterUltimaViagem(TipoViagem.ida.descricao);

    List<Passageiro> passageiros = await passageiroRepository.selectAll();

    for (var passageiro in passageiros) {
      ChamadaPassageiro chamada = ChamadaPassageiro(
          viagem: viagem.codigo, passageiro: passageiro.codigo);
      _repository.insert(chamada);
    }
  }

  void criarChamadaVolta() async {
    ViagemRepository viagemRepository = ViagemRepository();
    PassageiroRepository passageiroRepository = PassageiroRepository();
    Viagem viagem =
        await viagemRepository.obterUltimaViagem(TipoViagem.volta.descricao);

    List<Passageiro> passageiros = await passageiroRepository.selectAll();

    for (var passageiro in passageiros) {
      ChamadaPassageiro chamada = ChamadaPassageiro(
          viagem: viagem.codigo,
          passageiro: passageiro.codigo,
          statusChamada: 0);
      _repository.insert(chamada);
    }
  }
}
