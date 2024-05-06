import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:myvan_flutter/components/tipo_veiculo/tp_veiculo_form.dart';
import 'package:myvan_flutter/models/enums/tipo_viagem.dart';
import 'package:myvan_flutter/models/motorista.dart';
import 'package:myvan_flutter/models/tipo_veiculo.dart';
import 'package:myvan_flutter/models/veiculo.dart';

class ViagemForm extends StatefulWidget {
  final void Function(Veiculo, Motorista, DateTime, TipoViagem, String)
      onSubmit;

  const ViagemForm(this.onSubmit, {Key? key}) : super(key: key);

  @override
  State<ViagemForm> createState() => _ViagemFormState();
}

class _ViagemFormState extends State<ViagemForm> {
  final _formKey = GlobalKey<FormState>();
  final _veiculoController = TextEditingController();
  final _motoristaController = TextEditingController();
  final _dataController = TextEditingController();
  final _tipoviagemController = TextEditingController();
  final _nomeviagemController = TextEditingController();

  _submitForm() {
    final veiculo = Veiculo(
        codigo: 01,
        capacidadePassageiros: 16,
        cor: 'Prata',
        placa: 'BRA2E19',
        tipoVeiculo: TipoVeiculo(codigo: 03, descricao: 'descricao'));
    final motorista =
        Motorista(codigo: 02, nome: 'Sergio', telefone: '43984989722');
    final data = DateTime.parse(_dataController.text);
    final tipoViagem = TipoViagem.values[int.parse(_tipoviagemController.text)];
    final nomeViagem = _nomeviagemController.text;

    if (nomeViagem.isEmpty) {
      return;
    }

    widget.onSubmit(
      veiculo,
      motorista,
      data,
      tipoViagem,
      nomeViagem,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _veiculoController,
                  decoration: InputDecoration(
                    labelText: 'Veículo',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _motoristaController,
                  decoration: InputDecoration(
                    labelText: 'Motorista',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _dataController,
                  decoration: InputDecoration(
                    labelText: 'Data',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _tipoviagemController,
                  decoration: InputDecoration(
                    labelText: 'Tipo de Viagem',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _nomeviagemController,
                  decoration: InputDecoration(
                    labelText: 'Nome da Viagem',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nome da Viagem é obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateColor.resolveWith((states) => Colors.blue),
                    shape: MaterialStateProperty.resolveWith(
                      (states) => RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Salvar',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _submitForm();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
