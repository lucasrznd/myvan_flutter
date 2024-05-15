import 'package:myvan_flutter/models/tipo_veiculo.dart';
import 'package:myvan_flutter/repositories/tipo_veiculo_repository.dart';

class TipoVeiculoService {
  final TipoVeiculoRepository repository = TipoVeiculoRepository();

  Future<List<TipoVeiculo>> selectAll() {
    return repository.selectAll();
  }

  Future<void> insert(TipoVeiculo tipoVeiculo) {
    return repository.insert(tipoVeiculo);
  }

  Future<void> update(TipoVeiculo tipoVeiculo) {
    return repository.update(tipoVeiculo);
  }

  Future<void> delete(int codigo) {
    return repository.delete(codigo);
  }
}
