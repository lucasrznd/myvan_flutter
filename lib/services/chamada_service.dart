import 'package:myvan_flutter/models/chamada_passageiro.dart';
import 'package:myvan_flutter/models/enums/tipo_viagem.dart';
import 'package:myvan_flutter/models/passageiro.dart';
import 'package:myvan_flutter/models/viagem.dart';
import 'package:myvan_flutter/repositories/chamada_repository.dart';
import 'package:myvan_flutter/repositories/passageiro_repository.dart';
import 'package:myvan_flutter/repositories/viagem_repository.dart';

class ChamadaService {
  final ChamadaRepository _repository = ChamadaRepository();

  Future<List<ChamadaPassageiro>> selectAllHoje(TipoViagem tipoViagem) async {
    List<ChamadaPassageiro> chamadas =
        await _repository.selectAllHoje(tipoViagem.descricao);
    return chamadas;
  }

  Future<List<ChamadaPassageiro>> selectAll() {
    return _repository.selectAll(); 
  }

  Future<List<ChamadaPassageiro>> listarPresentes(TipoViagem tipoViagem) async {
    List<ChamadaPassageiro> chamadas =
        await _repository.listarPresentesHoje(tipoViagem.descricao);
    return chamadas;
  }

  Future<List<ChamadaPassageiro>> listarAusentes(TipoViagem tipoViagem) async {
    List<ChamadaPassageiro> chamadas =
        await _repository.listarAusentesHoje(tipoViagem.descricao);
    return chamadas;
  }

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

  bool insert(ChamadaPassageiro chamada) {
    if (chamada.codigo == null) {
      _repository.insert(chamada);
      return true;
    } else {
      update(chamada);
      return false;
    }
  }

  void update(ChamadaPassageiro chamada) {
    _repository.update(chamada);
  }

  void delete(int codigo) {
    _repository.delete(codigo);
  }
}
