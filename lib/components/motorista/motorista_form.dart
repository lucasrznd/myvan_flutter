import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MotoristaForm extends StatefulWidget {
  final void Function(String, String) onSubmit;

  MotoristaForm(this.onSubmit);

  @override
  State<MotoristaForm> createState() => _MotoristaFormState();
}

class _MotoristaFormState extends State<MotoristaForm> {
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

  var maskFormatter = new MaskTextInputFormatter(
      mask: '(##) # ####-####', type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nomeController,
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Nome',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
            TextField(
              controller: _telefoneController,
              onSubmitted: (_) => _submitForm(),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [maskFormatter],
              decoration: InputDecoration(
                labelText: 'Telefone',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateColor.resolveWith((states) => Colors.blue),
                  ),
                  child: Text(
                    'Salvar',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins'
                    ),
                  ),
                  onPressed: _submitForm,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
