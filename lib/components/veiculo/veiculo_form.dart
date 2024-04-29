import 'package:flutter/material.dart';

class VeiculoForm extends StatefulWidget {
  final void Function(String) onSubmit;

  const VeiculoForm(this.onSubmit, {super.key});

  @override
  State<VeiculoForm> createState() => _VeiculoFormState();
}

class _VeiculoFormState extends State<VeiculoForm> {
  final _formKey = GlobalKey<FormState>();
  final _tipoVeiculoController = TextEditingController();
  final _telefoneController = TextEditingController();

  _submitForm() {
    final tipoVeiculo = _tipoVeiculoController.text;
    final telefone = _telefoneController.text;

    if (tipoVeiculo.isEmpty || tipoVeiculo.isEmpty) {
      return;
    }

    widget.onSubmit(tipoVeiculo);
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
              TextFormField(
                controller: _tipoVeiculoController,
                decoration: InputDecoration(
                  labelText: 'Tipo do Veículo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (tipoVeiculo) {
                  if (tipoVeiculo == null ||
                      tipoVeiculo.isEmpty ||
                      tipoVeiculo == '') {
                    return 'Tipo do Veículo é obrigatório.';
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
