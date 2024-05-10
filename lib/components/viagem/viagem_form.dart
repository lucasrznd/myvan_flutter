import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myvan_flutter/components/motorista/dropdown.dart';
import 'package:myvan_flutter/components/veiculo/dropdown.dart';
import 'package:myvan_flutter/models/enums/tipo_viagem.dart';
import 'package:myvan_flutter/models/motorista.dart';
import 'package:myvan_flutter/models/veiculo.dart';
import 'package:myvan_flutter/models/viagem.dart';

class ViagemForm extends StatefulWidget {
  final Viagem _viagem;
  final Future<List<Motorista>> _motoristas;
  final Future<List<Veiculo>> _veiculos;
  final void Function(Viagem) onSubmit;

  const ViagemForm(
      this._viagem, this._motoristas, this._veiculos, this.onSubmit,
      {super.key});

  @override
  State<ViagemForm> createState() => _ViagemFormState();
}

class _ViagemFormState extends State<ViagemForm> {
  final _formKey = GlobalKey<FormState>();
  late Motorista _motoristaSelecionado;
  late Veiculo _veiculoSelecionado;
  late List<TipoViagem> _tiposViagem;

  @override
  void initState() {
    super.initState();
    _motoristaSelecionado = Motorista();
    _veiculoSelecionado = Veiculo();
    _tiposViagem = [TipoViagem.ida, TipoViagem.volta];
  }

  void _submitForm() {
    widget.onSubmit(widget._viagem);
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
                  initialValue: widget._viagem.nomeViagem,
                  onChanged: (value) => widget._viagem.nomeViagem = value,
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
                const SizedBox(height: 10),
                TextFormField(
                  readOnly: true,
                  controller:
                      TextEditingController(text: widget._viagem.tipoViagem),
                  decoration: InputDecoration(
                    labelText: 'Tipo de Viagem',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tipo de Viagem é obrigatório.';
                    }
                    return null;
                  },
                  onTap: () {
                    _autocompleteTipoViagem(context, _tiposViagem);
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: widget._viagem.data == null
                        ? ''
                        : DateFormat('dd/MM/yyyy').format(widget._viagem.data!),
                  ),
                  decoration: InputDecoration(
                    labelText: 'Data',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selecionarData(context),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: DropdownMotorista(
                      items: widget._motoristas,
                      hint: 'Selecione uma opção',
                      initialValue: _motoristaSelecionado,
                      onChanged: (newValue) {
                        setState(() {
                          if (newValue != null) {
                            widget._viagem.motorista = newValue.codigo!;
                          }
                        });
                      },
                    ))
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: DropdownVeiculo(
                      items: widget._veiculos,
                      hint: 'Selecione uma opção',
                      initialValue: _veiculoSelecionado,
                      onChanged: (newValue) {
                        setState(() {
                          if (newValue != null) {
                            widget._viagem.veiculo = newValue.codigo!;
                          }
                        });
                      },
                    ))
                  ],
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _submitForm();
                    }
                  },
                  child: const Text(
                    'Salvar',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      locale: const Locale('pt', 'BR'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        widget._viagem.data = pickedDate;
      });
    }
  }

  void _autocompleteTipoViagem(
      BuildContext context, List<TipoViagem> tiposViagem) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Column(
            children: tiposViagem.map((tipoViagem) {
              return ListTile(
                title: Text(tipoViagem.descricao),
                onTap: () {
                  setState(() {
                    widget._viagem.tipoViagem = tipoViagem.descricao;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
