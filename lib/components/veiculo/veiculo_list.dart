import 'package:flutter/material.dart';
import 'package:myvan_flutter/models/veiculo.dart';

class VeiculoList extends StatelessWidget {
  final List<Veiculo> veiculos;
  final void Function(int) onRemove;

  const VeiculoList(this.veiculos, this.onRemove, {super.key});

  @override
  Widget build(BuildContext context) {
    return veiculos.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
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
                SizedBox(height: 20),
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
            itemCount: veiculos.length,
            itemBuilder: ((context, index) {
              final tr = veiculos[index];

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
                        child: Text(tr.tipoVeiculo.descricao[0]),
                      ),
                    ),
                  ),
                  title: Text(
                    tr.tipoVeiculo.descricao,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    tr.cor,
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
