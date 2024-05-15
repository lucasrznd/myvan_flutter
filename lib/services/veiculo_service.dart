import 'package:myvan_flutter/models/veiculo.dart';
import 'package:myvan_flutter/repositories/veiculo_repository.dart';

class VeiculoService {
  final VeiculoRepository repository = VeiculoRepository();

  Future<List<Veiculo>> selectAll() {
    return repository.selectAll();
  }

  Future<void> insert(Veiculo veiculo) {
    return repository.insert(veiculo);
  }

  Future<void> update(Veiculo veiculo) {
    return repository.update(veiculo);
  }

  Future<void> delete(int codigo) {
    return repository.delete(codigo);
  }
}
