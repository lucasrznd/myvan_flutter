import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myvan_flutter/models/chamada_passageiro.dart';
import 'package:myvan_flutter/models/passageiro.dart';
import 'package:myvan_flutter/models/viagem.dart';

class ChamadaForm extends StatefulWidget {
  final ChamadaPassageiro _chamada;
  final Future<List<Viagem>> _viagens;
  final Future<List<Passageiro>> _passageiros;
  final void Function(ChamadaPassageiro) _onSubmit;

  const ChamadaForm(
      this._onSubmit, this._chamada, this._viagens, this._passageiros,
      {super.key});

  @override
  State<ChamadaForm> createState() => _ChamadaFormState();
}

class _ChamadaFormState extends State<ChamadaForm> {
  final _formKey = GlobalKey<FormState>();

  _submitForm() {
    widget._onSubmit(widget._chamada);
  }

  bool _statusChamadaToBool() =>
      widget._chamada.statusChamada == 0 ? false : true;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10)
            .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              InputDecorator(
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.assistant_direction_rounded,
                    color: Colors.blue.shade300,
                  ),
                  hintText: 'Viagem',
                  border: InputBorder.none,
                ),
                child: Autocomplete<Viagem>(
                  optionsBuilder: (TextEditingValue textEditingValue) async {
                    final viagens = await widget._viagens;
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<Viagem>.empty();
                    }
                    return viagens.where((Viagem option) {
                      return option.descricao
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  displayStringForOption: (Viagem option) {
                    DateTime data = DateTime.parse(option.data);

                    return '${option.descricao} - ${option.tipoViagem} - ${DateFormat('dd/MM/yyyy').format(data)}';
                  },
                  onSelected: (Viagem selection) {
                    widget._chamada.viagem = selection.codigo;
                  },
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              InputDecorator(
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.people_alt,
                    color: Colors.blue.shade300,
                  ),
                  hintText: 'Viagem',
                  border: InputBorder.none,
                ),
                child: Autocomplete<Passageiro>(
                  optionsBuilder: (TextEditingValue textEditingValue) async {
                    final passageiros = await widget._passageiros;
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<Passageiro>.empty();
                    }
                    return passageiros.where((Passageiro option) {
                      return option.nome
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  displayStringForOption: (Passageiro option) => option.nome,
                  onSelected: (Passageiro selection) {
                    widget._chamada.passageiro = selection.codigo;
                  },
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _statusChamadaToBool(),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value!) {
                          widget._chamada.statusChamada = 1;
                          return;
                        }
                        widget._chamada.statusChamada = 0;
                      });
                    },
                    activeColor: Colors.blue.shade300,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Presente',
                    style: TextStyle(
                        fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.blue),
                      shape: MaterialStateProperty.resolveWith(
                        (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Salvar',
                      style:
                          TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _submitForm();
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
