import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:myvan_flutter/models/motorista.dart';

class MotoristaForm extends StatefulWidget {
  final Motorista motorista;
  final void Function(Motorista) onSubmit;

  const MotoristaForm(this.onSubmit, this.motorista, {super.key});

  @override
  State<MotoristaForm> createState() => _MotoristaFormState();
}

class _MotoristaFormState extends State<MotoristaForm> {
  final _formKey = GlobalKey<FormState>();

  _submitForm() {
    widget.onSubmit(widget.motorista);
  }

  var maskFormatter = MaskTextInputFormatter(
      mask: '(##) # ####-####', type: MaskAutoCompletionType.lazy);

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
                initialValue: widget.motorista.nome,
                onChanged: (value) => widget.motorista.nome = value,
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
                initialValue: widget.motorista.telefone,
                onChanged: (value) => widget.motorista.telefone = value,
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
