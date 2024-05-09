import 'package:flutter/material.dart';
import 'package:myvan_flutter/models/endereco.dart';
import 'package:myvan_flutter/models/passageiro.dart';

class PassageiroList extends StatelessWidget {
  final Future<List<Passageiro>> _passageiros;
  final void Function(Passageiro, Endereco) onEditing;
  final void Function(int) _onRemove;
  final Future<List<Endereco>> Function() _listarEnderecos;

  const PassageiroList(
      this._passageiros, this.onEditing, this._onRemove, this._listarEnderecos,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([
          _passageiros,
          _listarEnderecos(),
        ]), // Aguarda ambos os futures
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Se a Future ainda estiver esperando, exiba um indicador de progresso
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Se ocorrer um erro, exiba uma mensagem de erro
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else {
            // Se a Future for concluída com sucesso, exiba os dados
            List<Passageiro> passageiros = snapshot.data![0];
            List<Endereco> enderecos = snapshot.data![1];

            if (passageiros.isEmpty) {
              return Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  const Text(
                    'Nenhum Passageiro encontrado.',
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
                itemCount: passageiros.length,
                itemBuilder: ((context, index) {
                  final passageiro = passageiros[index];

                  Endereco fetchEndereco() {
                    Endereco endereco = enderecos
                        .firstWhere((end) => passageiro.endereco == end.codigo);
                    return endereco;
                  }

                  return Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text(
                              passageiro.nome[0],
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        passageiro.nome,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        textAlign: TextAlign.left,
                        '${fetchEndereco().rua}, ${fetchEndereco().bairro}, ${fetchEndereco().numero}',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () =>
                                  onEditing(passageiro, fetchEndereco()),
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _onRemove(passageiro.codigo!),
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
        });
  }
}
