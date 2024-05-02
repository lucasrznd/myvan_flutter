import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:myvan_flutter/pages/home.dart';
import 'package:myvan_flutter/pages/motorista.dart';
import 'package:myvan_flutter/pages/veiculo.dart';

class NavegacaoPage extends StatefulWidget {
  const NavegacaoPage({super.key});

  @override
  State<NavegacaoPage> createState() => _NavegacaoPageState();
}

class _NavegacaoPageState extends State<NavegacaoPage> {
  int _selectedIndex = 0;

  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 400),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          const Home(),
          const MotoristaPage(),
          const VeiculoPage(),
          Container(
              color: Colors.purple,
              child: const Center(child: Text('Configurações'))),
        ],
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade300,
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: GNav(
            backgroundColor: Colors.blue.shade300,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.white24,
            gap: 8,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            selectedIndex: _selectedIndex,
            onTabChange: _onItemTapped,
            tabs: [
              GButton(
                icon: Icons.home_outlined,
                text: 'Home',
              ),
              GButton(
                icon: Icons.people_alt_outlined,
                text: 'Motoristas',
              ),
              GButton(
                icon: Icons.car_repair,
                text: 'Veiculos',
              ),
              GButton(
                icon: Icons.settings,
                text: 'Configurações',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
