import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MotoristaForm extends StatefulWidget {
  final void Function(String, String) onSubmit;

  const MotoristaForm(this.onSubmit, {super.key});

  @override
  State<MotoristaForm> createState() => _MotoristaFormState();
}

class _MotoristaFormState extends State<MotoristaForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();

  _submitForm() {
    final nome = _nomeController.text;
    final telefone = _telefoneController.text;

    if (nome.isEmpty || telefone.isEmpty) {
      return;
    }

    widget.onSubmit(nome, telefone);
  }

  var maskFormatter = MaskTextInputFormatter(
      mask: '(##) # ####-####', type: MaskAutoCompletionType.lazy);

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
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (nome) {
                  if (nome == null || nome.isEmpty || nome == '') {
                    return 'Nome é obrigatório.';
                  }
                  return null;
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
              ),
              TextFormField(
                controller: _telefoneController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [maskFormatter],
                decoration: InputDecoration(
                  labelText: 'Telefone',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (telefone) {
                  if (telefone == null || telefone.isEmpty || telefone == '') {
                    return 'Telefone é obrigatório.';
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
