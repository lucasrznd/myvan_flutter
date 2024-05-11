import 'package:flutter/material.dart';
import 'package:myvan_flutter/models/tipo_veiculo.dart';

class DropdownTipoVeiculo extends StatefulWidget {
  final Future<List<TipoVeiculo>> items; // Lista de itens do menu suspenso
  final String hint; // Texto de sugestão
  final TipoVeiculo? value; // Valor selecionado atualmente (nullable)
  final Function(TipoVeiculo?)
      onChanged; // Função de callback para lidar com a mudança de seleção
  final TipoVeiculo initialValue; // Initial value for the dropdown

  const DropdownTipoVeiculo(
      {required this.items,
      required this.hint,
      this.value,
      required this.onChanged,
      required this.initialValue,
      super.key});

  @override
  State<DropdownTipoVeiculo> createState() => _DropdownTipoVeiculoState();
}

class _DropdownTipoVeiculoState extends State<DropdownTipoVeiculo> {
  TipoVeiculo? _selectedValue;
  late Future<List<TipoVeiculo>> _futureItems;

  @override
  void initState() {
    super.initState();
    _futureItems = widget.items;
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TipoVeiculo>>(
      future: _futureItems,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Mostrar um indicador de progresso enquanto os itens estão sendo carregados
        } else if (snapshot.hasError) {
          return Text(
              'Erro: ${snapshot.error}'); // Mostrar mensagem de erro se houver algum erro ao carregar os itens
        } else {
          // Verificar se o valor inicial está na lista de itens
          if (!snapshot.data!.contains(widget.initialValue)) {
            _selectedValue =
                null; // ou defina um valor inicial diferente que está na lista de itens
          }
          return DropdownButtonFormField<TipoVeiculo>(
            value: _selectedValue,
            hint: Text(widget.hint),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<TipoVeiculo>(
                      value: item,
                      child: Text(item.descricao),
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
                return 'Tipo de Veículo é obrigatório';
              }
              return null;
            },
          );
        }
      },
    );
  }
}
