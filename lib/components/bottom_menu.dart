import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 20,
        ),
        child: GNav(
          backgroundColor: Colors.blue.shade300,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.white24,
          gap: 8,
          padding: EdgeInsets.all(16),
          onTabChange: (value) => print(value),
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
              text: "Inicio",
            ),
            GButton(
              icon: Icons.add_location_alt_outlined,
              text: "Viagens",
            ),
            GButton(
              icon: Icons.people_alt_outlined,
              text: "Passageiros",
            ),
            GButton(
              icon: Icons.settings,
              text: "Configurações",
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.blue.shade300,
        boxShadow: [
          BoxShadow(color: Colors.blue.shade300, spreadRadius: 4),
        ],
      ),
    );
  }
}
