import 'package:flutter/material.dart';
import 'package:myvan_flutter/models/motorista.dart';

class MotoristaList extends StatelessWidget {
  final List<Motorista> motoristas;
  final void Function(int) onRemove;

  MotoristaList(this.motoristas, this.onRemove);

  Widget build(BuildContext context) {
    return motoristas.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  'Nenhum motorista encontrado.',
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
            itemCount: motoristas.length,
            itemBuilder: ((context, index) {
              final tr = motoristas[index];

              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text(tr.codigo.toString()),
                      ),
                    ),
                  ),
                  title: Text(
                    tr.nome,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    tr.telefone,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => onRemove(tr.codigo),
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              );
            }),
          );
  }
}
