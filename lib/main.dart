import 'package:flutter/material.dart';
import 'package:flutter_internship_task/screens/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      title: 'Online Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //flutter theming
        primarySwatch: Colors.deepPurple,
        appBarTheme: const AppBarTheme(
            color: Colors.transparent,
            iconTheme: IconThemeData(
              color: Colors.black,
              size: 30,
            ),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w400,
            )),
        useMaterial3: true,
      ),
    );
  }
}
