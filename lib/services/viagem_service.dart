import 'package:myvan_flutter/models/enums/tipo_viagem.dart';
import 'package:myvan_flutter/models/viagem.dart';
import 'package:myvan_flutter/repositories/viagem_repository.dart';
import 'package:myvan_flutter/services/chamada_service.dart';

class ViagemService {
  final ViagemRepository viagemRepository = ViagemRepository();
  final ChamadaService chamadaService = ChamadaService();

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
}
