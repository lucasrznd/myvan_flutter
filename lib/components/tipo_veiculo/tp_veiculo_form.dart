import 'package:flutter/material.dart';
import 'package:myvan_flutter/models/tipo_veiculo.dart';

class TipoVeiculoForm extends StatefulWidget {
  final void Function(TipoVeiculo) onSubmit;
  final TipoVeiculo tipoVeiculo;

  const TipoVeiculoForm(this.onSubmit, this.tipoVeiculo, {super.key});

  @override
  State<TipoVeiculoForm> createState() => _TipoVeiculoFormState();
}

class _TipoVeiculoFormState extends State<TipoVeiculoForm> {
  final _formKey = GlobalKey<FormState>();

  _submitForm() {
    widget.onSubmit(widget.tipoVeiculo);
  }

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
              TextFormField(
                initialValue: widget.tipoVeiculo.descricao,
                onChanged: (value) => widget.tipoVeiculo.descricao = value,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (descricao) {
                  if (descricao == null ||
                      descricao.isEmpty ||
                      descricao == '') {
                    return 'Descrição é obrigatória.';
                  }
                  return null;
                },
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
