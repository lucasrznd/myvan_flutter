import 'package:flutter/material.dart';
import 'package:myvan_flutter/models/tipo_veiculo.dart';
import 'package:myvan_flutter/models/veiculo.dart';

class VeiculoList extends StatelessWidget {
  final Future<List<Veiculo>> _veiculos;
  final void Function(Veiculo) onEditing;
  final void Function(int) onRemove;
  final Future<List<TipoVeiculo>> Function() _listarTiposVeiculos;

  const VeiculoList(
      this._veiculos, this.onEditing, this.onRemove, this._listarTiposVeiculos,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        _veiculos,
        _listarTiposVeiculos(),
      ]), // Aguarda ambos os futures
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else {
          List<Veiculo> veiculos = snapshot.data![0];
          List<TipoVeiculo> tiposVeiculos = snapshot.data![1];

          if (veiculos.isEmpty) {
            return Column(
              children: <Widget>[
                const SizedBox(height: 20),
                const Text(
                  'Nenhum veículo encontrado.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Image.asset(
                    'assets/app/warning.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          } else {
            return ListView.builder(
              itemCount: veiculos.length,
              itemBuilder: ((context, index) {
                final veiculo = veiculos[index];

                TipoVeiculo fetchTiposVeiculos() {
                  TipoVeiculo tp = tiposVeiculos
                      .firstWhere((tp) => tp.codigo == veiculo.tipoVeiculo);
                  return tp;
                }

                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            veiculo.codigo.toString(),
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      '${fetchTiposVeiculos().descricao} - ${veiculo.placa}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${veiculo.cor}, Passageiros: ${veiculo.capacidadePassageiros}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () => onEditing(veiculo),
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              )),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => onRemove(veiculo.codigo!),
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            );
          }
        }
      },
    );
  }
}
