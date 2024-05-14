import 'package:flutter/material.dart';

class ChamadaDropdown extends StatefulWidget {
  final List<String> items;
  final String hint;
  final String? value;
  final Function(String?) onChanged;
  final String initialValue;

  const ChamadaDropdown(
      {required this.items,
      required this.hint,
      this.value,
      required this.onChanged,
      required this.initialValue,
      super.key});

  @override
  State<ChamadaDropdown> createState() => _ChamadaDropdownState();
}

class _ChamadaDropdownState extends State<ChamadaDropdown> {
  late String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedValue,
      hint: Text(
        widget.hint,
        style: const TextStyle(fontFamily: 'Poppins', fontSize: 10),
      ),
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
      validator: (value) {
        if (value == null) {
          return 'Seleção é obrigatória';
        }
        return null;
      },
    );
  }
}
