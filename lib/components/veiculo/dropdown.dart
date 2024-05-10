import 'package:flutter/material.dart';
import 'package:myvan_flutter/models/veiculo.dart';

class DropdownVeiculo extends StatefulWidget {
  final Future<List<Veiculo>> items; // Lista de itens do menu suspenso
  final String hint; // Texto de sugestão
  final Veiculo? value; // Valor selecionado atualmente (nullable)
  final Function(Veiculo?)
      onChanged; // Função de callback para lidar com a mudança de seleção
  final Veiculo initialValue; // Initial value for the dropdown

  const DropdownVeiculo(
      {required this.items,
      required this.hint,
      this.value,
      required this.onChanged,
      required this.initialValue,
      super.key});

  @override
  State<DropdownVeiculo> createState() => _DropdownVeiculoState();
}

class _DropdownVeiculoState extends State<DropdownVeiculo> {
  Veiculo? _selectedValue;
  late Future<List<Veiculo>> _futureItems;

  @override
  void initState() {
    super.initState();
    _futureItems = widget.items;
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Veiculo>>(
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
          return DropdownButtonFormField<Veiculo>(
            value: _selectedValue,
            hint: Text(
              widget.hint,
              style: const TextStyle(fontFamily: 'Poppins'),
            ),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<Veiculo>(
                      value: item,
                      child: Text(
                        '${item.placa} - ${item.cor}',
                        style: const TextStyle(fontFamily: 'Poppins'),
                      ),
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
                return 'Veiculo é obrigatório';
              }
              return null;
            },
          );
        }
      },
    );
  }
}
