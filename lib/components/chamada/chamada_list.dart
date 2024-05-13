import 'package:flutter/material.dart';
import 'package:myvan_flutter/models/chamada_passageiro.dart';

class ChamadaList extends StatelessWidget {
  final Future<List<ChamadaPassageiro>> _chamadas;
  final void Function(ChamadaPassageiro) onEditing;
  final void Function(int) onRemove;

  const ChamadaList(this._chamadas, this.onEditing, this.onRemove, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ChamadaPassageiro>>(
      future: _chamadas,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Se a Future ainda estiver esperando, exiba um indicador de progresso
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Se ocorrer um erro, exiba uma mensagem de erro
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else {
          // Se a Future for concluída com sucesso, exiba os dados
          List<ChamadaPassageiro> chamadas = snapshot.data!;
          if (chamadas.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Nenhuma chamada encontrada.',
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
              itemCount: chamadas.length,
              itemBuilder: ((context, index) {
                final chamada = chamadas[index];
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
                            chamada.viagem.toString(),
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      chamada.passageiro.toString(),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      chamada.statusChamada.toString(),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () => onEditing(chamada),
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              )),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => onRemove(chamada.codigo!),
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
