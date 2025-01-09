import 'package:a/pages/HomePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Jersey15',
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.grey.shade900,
          primaryColor: Colors.deepPurple.shade300,
        ),
        home: SafeArea(child: const HomePage()));
  }
}
