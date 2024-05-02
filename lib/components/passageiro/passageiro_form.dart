import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PassageiroForm extends StatefulWidget {
  final void Function(String, String, String, String, String, String) onSubmit;

  const PassageiroForm(this.onSubmit, {super.key});

  @override
  State<PassageiroForm> createState() => _PassageiroFormState();
}

class _PassageiroFormState extends State<PassageiroForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _ruaController = TextEditingController();
  final _bairroController = TextEditingController();
  final _numeroController = TextEditingController();
  final _cidadeController = TextEditingController();

  _submitForm() {
    final nome = _nomeController.text;
    final telefone = _telefoneController.text;
    final rua = _ruaController.text;
    final bairro = _bairroController.text;
    final numero = _numeroController.text;
    final cidade = _cidadeController.text;

    if (nome.isEmpty ||
        telefone.isEmpty ||
        rua.isEmpty ||
        bairro.isEmpty ||
        numero.isEmpty ||
        cidade.isEmpty) {
      return;
    }

    widget.onSubmit(nome, telefone, rua, bairro, numero, cidade);
  }

  var maskFormatter = MaskTextInputFormatter(
      mask: '(##) # ####-####', filter: {"#": RegExp(r'[0-9]')});

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
                  controller: _nomeController,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (nome) {
                    if (nome == null || nome.isEmpty || nome.trim() == '') {
                      return 'Nome é obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _telefoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [maskFormatter],
                  decoration: InputDecoration(
                    labelText: 'Telefone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (telefone) {
                    if (telefone == null ||
                        telefone.isEmpty ||
                        telefone.trim() == '') {
                      return 'Telefone é obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _ruaController,
                  decoration: InputDecoration(
                    labelText: 'Rua',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (rua) {
                    if (rua == null || rua.isEmpty || rua.trim() == '') {
                      return 'Rua é obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _numeroController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Número',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (numero) {
                    if (numero == null ||
                        numero.isEmpty ||
                        numero.trim() == '') {
                      return 'Número é obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _bairroController,
                  decoration: InputDecoration(
                    labelText: 'Bairro',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (bairro) {
                    if (bairro == null ||
                        bairro.isEmpty ||
                        bairro.trim() == '') {
                      return 'Bairro é obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _cidadeController,
                  decoration: InputDecoration(
                    labelText: 'Cidade',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (cidade) {
                    if (cidade == null ||
                        cidade.isEmpty ||
                        cidade.trim() == '') {
                      return 'Cidade é obrigatória.';
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
            ),
          ),
        ),
      ),
    );
  }
}
