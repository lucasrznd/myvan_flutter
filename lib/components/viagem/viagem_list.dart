import 'package:flutter/material.dart';
import 'package:myvan_flutter/models/viagem.dart';

class ViagemList extends StatelessWidget {
  final List<Viagem> viagens;
  final void Function(int) onRemove;

  const ViagemList(this.viagens, this.onRemove, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return viagens.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                const SizedBox(height: 20),
                const Text(
                  'Nenhuma Viagem encontrada.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
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
            itemCount: viagens.length,
            itemBuilder: (context, index) {
              final viagem = viagens[index];

              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text(viagem.nomeViagem[0]),
                      ),
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Veículo: ${viagem.veiculo}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        'Motorista: ${viagem.motorista}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        'Data: ${viagem.data}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        'Tipo de Viagem: ${viagem.tipoViagem}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        'Nome da Viagem: ${viagem.nomeViagem}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                  subtitle: Text(viagem.nomeViagem),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => onRemove(viagem.codigo),
                    color: Theme.of(context).errorColor,
                  ),
                ),
              );
            },
          );
  }
}
