import 'package:flutter/material.dart';

class TipoVeiculoForm extends StatefulWidget {
  final void Function(String) onSubmit;

  const TipoVeiculoForm(this.onSubmit, {super.key});

  @override
  State<TipoVeiculoForm> createState() => _TipoVeiculoFormState();
}

class _TipoVeiculoFormState extends State<TipoVeiculoForm> {
  final _formKey = GlobalKey<FormState>();
  final _descricaoController = TextEditingController();

  _submitForm() {
    final descricao = _descricaoController.text;

    if (descricao.isEmpty) {
      return;
    }

    widget.onSubmit(descricao);
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
                controller: _descricaoController,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (nome) {
                  if (nome == null || nome.isEmpty || nome == '') {
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
