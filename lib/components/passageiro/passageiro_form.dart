import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:myvan_flutter/models/endereco.dart';
import 'package:myvan_flutter/models/passageiro.dart';

class PassageiroForm extends StatefulWidget {
  final Passageiro _passageiro;
  final Endereco _endereco;
  final void Function(Passageiro, Endereco) onSubmit;

  const PassageiroForm(this.onSubmit, this._passageiro, this._endereco,
      {super.key});

  @override
  State<PassageiroForm> createState() => _PassageiroFormState();
}

class _PassageiroFormState extends State<PassageiroForm> {
  final _formKey = GlobalKey<FormState>();

  _submitForm() {
    widget.onSubmit(widget._passageiro, widget._endereco);
  }

  var maskFormatter = MaskTextInputFormatter(
      mask: '(##) # ####-####', filter: {"#": RegExp(r'[0-9]')});

  String exibirNumeroEndereco() {
    if (widget._endereco.numero == null) {
      return '';
    }
    return widget._endereco.numero.toString();
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
                  initialValue: widget._passageiro.nome,
                  onChanged: (value) => widget._passageiro.nome = value,
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
                  initialValue: widget._passageiro.telefone,
                  onChanged: (value) => widget._passageiro.telefone = value,
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
                  initialValue: widget._endereco.rua,
                  onChanged: (value) => widget._endereco.rua = value,
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
                  initialValue: widget._endereco.bairro,
                  onChanged: (value) => widget._endereco.bairro = value,
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
                  initialValue: exibirNumeroEndereco(),
                  onChanged: (value) =>
                      widget._endereco.numero = int.tryParse(value),
                  keyboardType: TextInputType.number,
                  maxLength: 5,
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
                  initialValue: widget._endereco.cidade,
                  onChanged: (value) => widget._endereco.cidade = value,
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
