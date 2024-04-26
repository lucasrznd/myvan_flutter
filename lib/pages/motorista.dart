import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/custom_app_bar.dart';

class TelaMotorista extends StatefulWidget {
  const TelaMotorista({super.key});

  @override
  State<TelaMotorista> createState() => _TelaMotoristaState();
}

class _TelaMotoristaState extends State<TelaMotorista> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Motoristas'),
      body: Text('Motorista'),
    );
  }
}
