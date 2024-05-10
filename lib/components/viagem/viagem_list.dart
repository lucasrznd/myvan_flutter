import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myvan_flutter/models/motorista.dart';
import 'package:myvan_flutter/models/veiculo.dart';
import 'package:myvan_flutter/models/viagem.dart';

class ViagemList extends StatelessWidget {
  final Future<List<Viagem>> _viagens;
  final void Function(Viagem, Motorista, Veiculo) onEditing;
  final void Function(int) onRemove;
  final Future<List<Motorista>> Function() _listarMotoristas;
  final Future<List<Veiculo>> Function() _listarVeiculos;

  const ViagemList(this._viagens, this.onEditing, this.onRemove,
      this._listarMotoristas, this._listarVeiculos,
      {super.key});

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('dd/MM/yyyy');

    return FutureBuilder(
        future: Future.wait([
          _viagens,
          _listarMotoristas(),
          _listarVeiculos()
        ]), // Aguarda ambos os futures
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else {
            List<Viagem> viagens = snapshot.data![0];
            List<Motorista> motoristas = snapshot.data![1];
            List<Veiculo> veiculos = snapshot.data![2];

            if (viagens.isEmpty) {
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
                itemCount: viagens.length,
                itemBuilder: (context, index) {
                  final viagem = viagens[index];

                  String formatarData() {
                    DateTime data = DateTime.parse(viagem.data);
                    String dataFormada = formatter.format(data);
                    return dataFormada;
                  }

                  Motorista fetchMotoristas() {
                    Motorista motorista = motoristas.firstWhere(
                        (motorista) => motorista.codigo == viagem.motorista);
                    return motorista;
                  }

                  Veiculo fetchVeiculos() {
                    Veiculo veiculo = veiculos.firstWhere(
                        (veiculo) => veiculo.codigo == viagem.veiculo);
                    return veiculo;
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
                              viagem.tipoViagem,
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            viagem.descricao,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            formatarData(),
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '${fetchMotoristas().nome} - ${fetchVeiculos().placa}',
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
                              onPressed: () => onEditing(
                                  viagem, fetchMotoristas(), fetchVeiculos()),
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
        });
  }
}
