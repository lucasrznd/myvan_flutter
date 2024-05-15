import 'package:myvan_flutter/models/enums/tipo_viagem.dart';
import 'package:myvan_flutter/models/viagem.dart';
import 'package:myvan_flutter/repositories/viagem_repository.dart';
import 'package:myvan_flutter/services/chamada_service.dart';

class ViagemService {
  final ViagemRepository repository = ViagemRepository();
  final ChamadaService chamadaService = ChamadaService();

  Future<List<Viagem>> selectAll() {
    return repository.selectAll();
  }

  Future<Viagem> obterUltimaViagem(String tipoViagem) async {
    Viagem viagem = await repository.obterUltimaViagem(tipoViagem);
    return viagem;
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

      insert(novaViagem);
    }
  }

  void criarViagemIda(Viagem viagem) {
    if (viagem.data == '') {
      viagem.data = DateTime.now().toIso8601String();
    }

    repository.insert(viagem);
  }

  void criarViagemVolta(Viagem viagem) {
    Viagem viagemVolta = Viagem().fromViagem(viagem);
    viagemVolta.tipoViagem = TipoViagem.volta.descricao;

    repository.insert(viagemVolta);
  }

  void insert(Viagem viagem) {
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

  Future<void> update(Viagem viagem) {
    return repository.update(viagem);
  }

  Future<void> delete(int codigo) {
    return repository.delete(codigo);
  }
}
