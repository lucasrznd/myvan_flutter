import 'package:flutter/material.dart';
import 'package:myvan_flutter/models/passageiro.dart';

class PassageiroList extends StatelessWidget {
  final List<Passageiro> passageiros;
  final void Function(int) onRemove;

  PassageiroList(this.passageiros, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return passageiros.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  'Nenhum Passageiro encontrado.',
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
            itemCount: passageiros.length,
            itemBuilder: ((context, index) {
              final tr = passageiros[index];

              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text(tr.nome[0]),
                      ),
                    ),
                  ),
                  title: Text(
                    tr.nome,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  subtitle: Text(tr.telefone),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => onRemove(tr.codigo),
                    color: Theme.of(context).errorColor,
                  ),
                ),
              );
            }),
          );
  }
}
