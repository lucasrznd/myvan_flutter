import 'package:flutter/material.dart';
import 'package:myvan_flutter/models/tipo_veiculo.dart';

class TipoVeiculoList extends StatelessWidget {
  final List<TipoVeiculo> tiposVeiculos;
  final void Function(int) onRemove;

  const TipoVeiculoList(this.tiposVeiculos, this.onRemove, {super.key});

  @override
  Widget build(BuildContext context) {
    return tiposVeiculos.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                const SizedBox(height: 20),
                const Text(
                  'Nenhum tipo de veículo encontrado.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/app/warning.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
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
                        child: Text(tr.descricao[0]),
                      ),
                    ),
                  ),
                  title: Text(
                    tr.descricao,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => onRemove(tr.codigo),
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              );
            }),
          );
  }
}
