import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myvan_flutter/models/viagem.dart';

class ViagemList extends StatelessWidget {
  final List<Viagem> viagens;
  final void Function(Viagem) onEditing;
  final void Function(int) onRemove;

  const ViagemList(this.viagens, this.onEditing, this.onRemove, {super.key});

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
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
                        viagem.nomeViagem,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${viagem.tipoViagem}, ${formatter.format(viagem.data!)}',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        viagem.motorista.toString(),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => onEditing(viagem),
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => onRemove(viagem.codigo!),
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
