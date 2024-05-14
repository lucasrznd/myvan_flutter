import 'package:myvan_flutter/models/enums/tipo_viagem.dart';
import 'package:myvan_flutter/models/viagem.dart';
import 'package:myvan_flutter/repositories/viagem_repository.dart';
import 'package:myvan_flutter/services/chamada_service.dart';

class ViagemService {
  final ViagemRepository viagemRepository = ViagemRepository();
  final ChamadaService chamadaService = ChamadaService();

  Future<List<Viagem>> selectAll() {
    return viagemRepository.selectAll();
  }

  void importarDaUltimaViagem() async {
    Viagem viagem = await obterUltimaViagem(TipoViagem.ida.descricao);

    if (viagem.codigo != 0) {
      Viagem novaViagem = Viagem(
          codigo: null,
          descricao: viagem.descricao,
          tipoViagem: viagem.tipoViagem,
          data: DateTime.now().toIso8601String(),
          motorista: viagem.motorista,
          veiculo: viagem.veiculo);

      salvarViagem(novaViagem);
    }
  }

  void criarViagemIda(Viagem viagem) {
    if (viagem.data == '') {
      viagem.data = DateTime.now().toIso8601String();
    }

    viagemRepository.insert(viagem);
  }

  void criarViagemVolta(Viagem viagem) {
    Viagem viagemVolta = Viagem(
        codigo: viagem.codigo,
        descricao: viagem.descricao,
        veiculo: viagem.veiculo,
        motorista: viagem.motorista,
        tipoViagem: viagem.tipoViagem,
        data: viagem.data);

    viagemVolta.codigo = null;
    viagemVolta.tipoViagem = 'VOLTA';

    viagemRepository.insert(viagemVolta);
  }

  void salvarViagem(Viagem viagem) {
    if (viagem.codigo == null &&
        viagem.tipoViagem == TipoViagem.ida.descricao) {
      criarViagemIda(viagem);
      criarViagemVolta(viagem);
      chamadaService.criarChamadaIda();
      chamadaService.criarChamadaVolta();
    } else {
      criarViagemIda(viagem);
    }
  }

  Future<Viagem> obterUltimaViagem(String tipoViagem) async {
    Viagem viagem = await viagemRepository.obterUltimaViagem(tipoViagem);
    return viagem;
  }
}
