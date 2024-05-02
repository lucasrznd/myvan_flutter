import 'package:flutter/material.dart';

class DropdownPersonalizado extends StatefulWidget {
  final List<String> items; // Lista de itens do menu suspenso
  final String hint; // Texto de sugestão
  final String? value; // Valor selecionado atualmente (nullable)
  final Function(String?)
      onChanged; // Função de callback para lidar com a mudança de seleção
  final String initialValue; // Initial value for the dropdown

  const DropdownPersonalizado({
    Key? key,
    required this.items,
    required this.hint,
    this.value,
    required this.onChanged,
    required this.initialValue,
  }) : super(key: key);

  @override
  State<DropdownPersonalizado> createState() => _DropdownPersonalizadoState();
}

class _DropdownPersonalizadoState extends State<DropdownPersonalizado> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue; // Use only initialValue
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedValue,
      hint: Text(widget.hint),
      items: widget.items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item),
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
    );
  }
}
