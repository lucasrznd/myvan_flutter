import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myvan_flutter/models/enums/tipo_viagem.dart';
import 'package:myvan_flutter/models/motorista.dart';
import 'package:myvan_flutter/models/veiculo.dart';
import 'package:myvan_flutter/models/viagem.dart';

class ViagemForm extends StatefulWidget {
  final Viagem _viagem;
  final void Function(Viagem) onSubmit;

  const ViagemForm(this._viagem, this.onSubmit, {super.key});

  @override
  State<ViagemForm> createState() => _ViagemFormState();
}

class _ViagemFormState extends State<ViagemForm> {
  final _formKey = GlobalKey<FormState>();
  String _motoristaSelecionado = '';

  String _formatarCampoMotorista() {
    if (widget._viagem.motorista == null) {
      return '';
    }
    return widget._viagem.motorista.toString();
  }

  String _formatarCampoVeiculo() {
    if (widget._viagem.veiculo == null) {
      return '';
    }
    return widget._viagem.veiculo.toString();
  }

  final List<TipoViagem> tiposViagem = [TipoViagem.ida, TipoViagem.volta];

  final List<Motorista> motoristas = [
    Motorista(codigo: 1, nome: 'Sergio', telefone: '4399999999'),
    Motorista(codigo: 2, nome: 'Lucas', telefone: '4399999999'),
  ]; // Exemplos de motoristas

  final List<Veiculo> veiculos = [
    Veiculo(
        codigo: 1,
        tipoVeiculo: 2,
        placa: 'AGJ-1212',
        capacidadePassageiros: 16),
    Veiculo(
        codigo: 2,
        tipoVeiculo: 1,
        placa: 'ALF-1552',
        capacidadePassageiros: 16),
  ]; // Exemplos de veículos

  void _submitForm() {
    widget._viagem.data ??= DateTime.now();

    print(widget._viagem.toString());
    widget.onSubmit(widget._viagem);
  }

  Future<void> _selectDate(BuildContext context) async {
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
                    _autocompleteTipoViagem(context, tiposViagem);
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
                      onPressed: () => _selectDate(context),
                    ),
                  ),
                  validator: (value) {
                    if (widget._viagem.data == null) {
                      return 'Data é obrigatória.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  readOnly: true,
                  controller:
                      TextEditingController(text: _motoristaSelecionado),
                  decoration: InputDecoration(
                    labelText: 'Motorista',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Motorista é obrigatório.';
                    }
                    return null;
                  },
                  onTap: () {
                    _autoCompleteMotoristas(context, motoristas);
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  readOnly: true,
                  initialValue: _formatarCampoVeiculo(),
                  decoration: InputDecoration(
                    labelText: 'Veículo',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veículo é obrigatório.';
                    }
                    return null;
                  },
                  onTap: () {
                    _autocompleteVeiculos(context, veiculos);
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
                  onPressed: _submitForm,
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

  void _autoCompleteMotoristas(
      BuildContext context, List<Motorista> motoristas) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Column(
            children: motoristas.map((motorista) {
              return ListTile(
                title: Text(motorista.nome),
                onTap: () {
                  setState(() {
                    _motoristaSelecionado = motorista.nome;
                    widget._viagem.motorista = motorista.codigo;
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

  void _autocompleteVeiculos(BuildContext context, List<Veiculo> veiculos) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Column(
            children: veiculos.map((veiculo) {
              return ListTile(
                title: Text(veiculo.placa),
                onTap: () {
                  widget._viagem.veiculo = veiculo.codigo;
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
