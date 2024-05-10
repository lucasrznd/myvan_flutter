import 'package:flutter/material.dart';
import 'package:myvan_flutter/models/motorista.dart';

class DropdownMotorista extends StatefulWidget {
  final Future<List<Motorista>> items; // Lista de itens do menu suspenso
  final String hint; // Texto de sugestão
  final Motorista? value; // Valor selecionado atualmente (nullable)
  final Function(Motorista?)
      onChanged; // Função de callback para lidar com a mudança de seleção
  final Motorista initialValue; // Initial value for the dropdown

  const DropdownMotorista(
      {required this.items,
      required this.hint,
      this.value,
      required this.onChanged,
      required this.initialValue,
      super.key});

  @override
  State<DropdownMotorista> createState() => _DropdownMotoristaState();
}

class _DropdownMotoristaState extends State<DropdownMotorista> {
  Motorista? _selectedValue;
  late Future<List<Motorista>> _futureItems;

  @override
  void initState() {
    super.initState();
    _futureItems = widget.items;
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Motorista>>(
      future: _futureItems,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        } else {
          if (!snapshot.data!.contains(widget.initialValue)) {
            _selectedValue =
                null; // ou defina um valor inicial diferente que está na lista de itens
          }
          return DropdownButtonFormField<Motorista>(
            value: _selectedValue,
            hint: Text(
              widget.hint,
              style: const TextStyle(fontFamily: 'Poppins'),
            ),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<Motorista>(
                      value: item,
                      child: Text(item.nome),
                    ))
                .toList(),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (newValue) {
              setState(() {
                _selectedValue = newValue;
                widget.onChanged(newValue);
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Motorista é obrigatório';
              }
              return null;
            },
          );
        }
      },
    );
  }
}
