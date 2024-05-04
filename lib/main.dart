import 'package:flutter/material.dart';
import 'package:myvan_flutter/components/bottom_navigation/fab_tabs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade300),
            borderRadius: BorderRadius.circular(10),
          ),
          floatingLabelStyle: const TextStyle(
            color: Color.fromARGB(255, 46, 46, 46),
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        primaryColor: Colors.blue.shade300,
      ),
      home: FabTabs(selectedIndex: 0),
    );
  }
}
