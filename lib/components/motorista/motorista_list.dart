import 'package:flutter/material.dart';
import 'package:myvan_flutter/models/motorista.dart';

class MotoristaList extends StatelessWidget {
  final Future<List<Motorista>> motoristas;
  final void Function(Motorista) onEditing;
  final void Function(int) onRemove;

  const MotoristaList(this.motoristas, this.onEditing, this.onRemove,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Motorista>>(
      future: motoristas,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Se a Future ainda estiver esperando, exiba um indicador de progresso
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Se ocorrer um erro, exiba uma mensagem de erro
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else {
          // Se a Future for concluída com sucesso, exiba os dados
          List<Motorista> motoristas = snapshot.data!;
          if (motoristas.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Nenhum motorista encontrado.',
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
              itemCount: motoristas.length,
              itemBuilder: ((context, index) {
                final motorista = motoristas[index];
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
                            motorista.nome[0],
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    title: Text(  
                      motorista.nome,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      motorista.telefone,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () => onEditing(motorista),
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              )),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => onRemove(motorista.codigo!),
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
