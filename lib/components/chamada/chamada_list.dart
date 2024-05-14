import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myvan_flutter/models/chamada_passageiro.dart';
import 'package:myvan_flutter/models/passageiro.dart';
import 'package:myvan_flutter/models/viagem.dart';
import 'package:myvan_flutter/services/whatsapp_service.dart';

class ChamadaList extends StatefulWidget {
  final List<ChamadaPassageiro> _chamadas;
  final void Function(ChamadaPassageiro) onSubmit;
  final void Function(int) onRemove;
  final Future<List<Viagem>> Function() _listarViagens;
  final Future<List<Passageiro>> Function() _listarPassageiros;

  const ChamadaList(this._chamadas, this.onSubmit, this.onRemove,
      this._listarViagens, this._listarPassageiros,
      {super.key});

  @override
  State<ChamadaList> createState() => _ChamadaListState();
}

class _ChamadaListState extends State<ChamadaList> {
  late Future<List<dynamic>> _future;

  @override
  void initState() {
    super.initState();
    _future = Future.wait([
      widget._listarViagens(),
      widget._listarPassageiros(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _future,
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else {
          List<Viagem> viagens = snapshot.data![0];
          List<Passageiro> passageiros = snapshot.data![1];

          if (widget._chamadas.isEmpty) {
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
              itemCount: widget._chamadas.length,
              itemBuilder: ((context, index) {
                final chamada = widget._chamadas[index];

                Viagem fetchViagem() {
                  Viagem viagem = viagens
                      .firstWhere((viagem) => chamada.viagem == viagem.codigo);
                  return viagem;
                }

                obterData() {
                  DateTime data = DateTime.parse(fetchViagem().data);
                  return data;
                }

                Passageiro fetchPassageiro() {
                  Passageiro passageiro = passageiros.firstWhere(
                      (passageiro) => chamada.passageiro == passageiro.codigo);
                  return passageiro;
                }

                String formatarStatus() {
                  if (chamada.statusChamada == 1) {
                    return 'Presente';
                  }
                  return 'Ausente';
                }

                bool statusChamadaToBool() =>
                    chamada.statusChamada == 0 ? false : true;

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
                        child: Checkbox(
                          value: statusChamadaToBool(),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value != null) {
                                if (value) {
                                  chamada.statusChamada = 1;
                                } else {
                                  chamada.statusChamada = 0;
                                }
                                widget.onSubmit(chamada);
                              }
                            });
                          },
                          activeColor: Colors.blue.shade300,
                        ),
                      ),
                    ),
                    title: Text(
                      fetchPassageiro().nome,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${formatarStatus()} - ${fetchViagem().tipoViagem} - ${DateFormat('dd/MM/yyyy').format(obterData())}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => WhatsappService.abrirConversa(
                                fetchPassageiro().telefone),
                            icon: Image.asset(
                              'assets/app/whatsapp-icon.png',
                              width: 23,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => widget.onRemove(chamada.codigo!),
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
