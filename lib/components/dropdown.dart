import 'package:flutter/material.dart';

const List<String> list = <String>['Van', 'Carro'];

class DropDownCustom extends StatefulWidget {
  const DropDownCustom({super.key});

  @override
  State<DropDownCustom> createState() => _DropDownCustomState();
}

class _DropDownCustomState extends State<DropDownCustom> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: dropdownValue,
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          print(dropdownValue);
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
