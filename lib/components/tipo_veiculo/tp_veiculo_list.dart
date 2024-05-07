import 'package:flutter/material.dart';
import 'package:myvan_flutter/models/tipo_veiculo.dart';

class TipoVeiculoList extends StatelessWidget {
  final Future<List<TipoVeiculo>> tiposVeiculos;
  final void Function(TipoVeiculo) onEditing;
  final void Function(int) onRemove;

  const TipoVeiculoList(this.tiposVeiculos, this.onEditing, this.onRemove,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TipoVeiculo>>(
      future: tiposVeiculos,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Se a Future ainda estiver esperando, exiba um indicador de progresso
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Se ocorrer um erro, exiba uma mensagem de erro
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else {
          // Se a Future for concluída com sucesso, exiba os dados
          List<TipoVeiculo> tiposVeiculos = snapshot.data!;

          if (tiposVeiculos.isEmpty) {
            return Column(
              children: <Widget>[
                const SizedBox(height: 20),
                const Text(
                  'Nenhum tipo de veículo encontrado.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
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
              itemCount: tiposVeiculos.length,
              itemBuilder: ((context, index) {
                final tr = tiposVeiculos[index];

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
                              tr.descricao[0],
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                    ),
                    title: Text(
                      tr.descricao,
                      style: const TextStyle(fontFamily: 'Poppins'),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => onRemove(tr.codigo!),
                      color: Theme.of(context).colorScheme.error,
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
