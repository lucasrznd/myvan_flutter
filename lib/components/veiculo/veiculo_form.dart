import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myvan_flutter/components/dropdown.dart';

class VeiculoForm extends StatefulWidget {
  final void Function(String) onSubmit;

  const VeiculoForm(this.onSubmit, {super.key});

  @override
  State<VeiculoForm> createState() => _VeiculoFormState();
}

class _VeiculoFormState extends State<VeiculoForm> {
  final _formKey = GlobalKey<FormState>();
  String _tipoVeiculoSelecionado = "Van";
  final _placaController = TextEditingController();
  final _corController = TextEditingController();
  final _capacidadePassageirosController = TextEditingController();

  _submitForm() {
    final tipoVeiculo = _tipoVeiculoSelecionado;

    if (tipoVeiculo.isEmpty || tipoVeiculo.isEmpty) {
      return;
    }

    widget.onSubmit(tipoVeiculo);
  }

  @override
  void initState() {
    super.initState();
    _tipoVeiculoSelecionado = "Van";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: DropdownPersonalizado(
                      items: const ["Van", "Carro"],
                      hint: "Selecione uma opção",
                      initialValue:
                          _tipoVeiculoSelecionado, // Always use initial value
                      onChanged: (newValue) {
                        setState(() {
                          _tipoVeiculoSelecionado = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              TextFormField(
                controller: _placaController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  label: const Text('Placa Veículo'),
                ),
                inputFormatters: [PlacaVeiculoInputFormatter()],
                validator: (placa) {
                  if (placa == null || placa.isEmpty || placa == '') {
                    return 'Placa é obrigatória.';
                  }
                  return null;
                },
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              TextFormField(
                controller: _corController,
                decoration: InputDecoration(
                  labelText: 'Cor',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (cor) {
                  if (cor == null || cor.isEmpty || cor == '') {
                    return 'Cor é obrigatória.';
                  }
                  return null;
                },
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              TextFormField(
                controller: _capacidadePassageirosController,
                decoration: InputDecoration(
                  labelText: 'Capacidade de Passageiros',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
                maxLength: 2,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], // Only numbers can be entered
                validator: (capacidadePassageiros) {
                  if (capacidadePassageiros == null ||
                      capacidadePassageiros.isEmpty ||
                      capacidadePassageiros == '') {
                    return 'Capacidade de Passageiros é obrigatório.';
                  }
                  return null;
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
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
