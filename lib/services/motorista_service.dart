import 'package:myvan_flutter/models/motorista.dart';
import 'package:myvan_flutter/repositories/motorista_repository.dart';

class MotoristaService {
  final MotoristaRepository repository = MotoristaRepository();

  Future<List<Motorista>> selectAll() {
    return repository.selectAll();
  }

  Future<void> insert(Motorista motorista) {
    return repository.insert(motorista);
  }

  Future<void> update(Motorista motorista) {
    return repository.update(motorista);
  }

  Future<void> delete(int codigo) {
    return repository.delete(codigo);
  }
}
