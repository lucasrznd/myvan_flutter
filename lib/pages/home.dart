import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/bottom_menu.dart';
import 'package:myvan_flutter/components/custom_app_bar.dart';
import 'package:myvan_flutter/components/card_chamada.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Home'),
      body: ListView(
        children: [
          CardExample(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
          CardExample()
        ],
      ),
      bottomNavigationBar: BottomMenu(),
    );
  }
}
