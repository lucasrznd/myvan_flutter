import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myvan_flutter/auth/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade300),
            borderRadius: BorderRadius.circular(10),
          ),
          labelStyle: const TextStyle(
            color: Color.fromARGB(255, 46, 46, 46),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w300,
            fontSize: 16,
          ),
          floatingLabelStyle: const TextStyle(
            color: Color.fromARGB(255, 46, 46, 46),
            fontFamily: 'Poppins',
          ),
        ),
        datePickerTheme: const DatePickerThemeData(
          headerHeadlineStyle: TextStyle(fontFamily: 'Poppins', fontSize: 25),
          dayStyle: TextStyle(fontFamily: 'Poppins'),
          weekdayStyle: TextStyle(fontFamily: 'Poppins'),
          yearStyle: TextStyle(fontFamily: 'Poppins'),
          todayBackgroundColor: MaterialStatePropertyAll(Colors.blue),
          cancelButtonStyle: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.grey),
            foregroundColor: MaterialStatePropertyAll(Colors.white),
          ),
          confirmButtonStyle: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.blue),
            foregroundColor: MaterialStatePropertyAll(Colors.white),
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
      home: const LoginPage(),
      // const FabTabs(selectedIndex: 0),
    );
  }
}
