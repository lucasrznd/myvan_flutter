import 'package:flutter/material.dart';

void main() => runApp(const BotaoChamada());

class BotaoChamada extends StatelessWidget {
  const BotaoChamada({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: const CardExample(),
      ),
    );
  }
}

class CardExample extends StatelessWidget {
  const CardExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        height: 150,
        child: Card(
          color: const Color(0xff79cbfd),
          child: Column(
            children: <Widget>[
              const ListTile(
                title: Text('Chamada Ida'),
                leading: Icon(Icons.album),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
