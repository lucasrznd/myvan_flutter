import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/bottom_navigation/fab_tabs.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 100,
            child: DrawerHeader(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(1.0),
                  bottomRight: Radius.circular(1.0),
                ),
                color: Colors.blue.shade300,
              ),
              child: Image.asset(
                'assets/app/icon_negativo.png',
                alignment: Alignment.centerLeft,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home_filled,
              color: Colors.blue.shade300,
            ),
            title: const Text(
              "Home",
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color.fromARGB(255, 49, 49, 49),
                  fontWeight: FontWeight.w600),
            ),
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FabTabs(selectedIndex: 0)))
            },
          ),
          ListTile(
            leading: Icon(
              Icons.assistant_direction_rounded,
              color: Colors.blue.shade300,
            ),
            title: const Text(
              "Viagens",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Color.fromARGB(255, 49, 49, 49),
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FabTabs(selectedIndex: 1)))
            },
          ),
          ListTile(
            leading: Icon(
              Icons.people_alt,
              color: Colors.blue.shade300,
            ),
            title: const Text(
              "Passageiros",
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color.fromARGB(255, 49, 49, 49),
                  fontWeight: FontWeight.w600),
            ),
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FabTabs(selectedIndex: 2)))
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person_pin_circle_rounded,
              color: Colors.blue.shade300,
            ),
            title: const Text(
              "Motoristas",
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color.fromARGB(255, 49, 49, 49),
                  fontWeight: FontWeight.w600),
            ),
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FabTabs(selectedIndex: 3)))
            },
          ),
          ListTile(
            leading: Icon(
              Icons.drive_eta,
              color: Colors.blue.shade300,
            ),
            title: const Text(
              "Veículos",
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color.fromARGB(255, 49, 49, 49),
                  fontWeight: FontWeight.w600),
            ),
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FabTabs(selectedIndex: 4)))
            },
          ),
          ListTile(
            leading: Icon(
              Icons.directions_bus,
              color: Colors.blue.shade300,
            ),
            title: const Text(
              "Tipos de Veículos",
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color.fromARGB(255, 49, 49, 49),
                  fontWeight: FontWeight.w600),
            ),
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FabTabs(selectedIndex: 5)))
            },
          ),
        ],
      ),
    );
  }
}
