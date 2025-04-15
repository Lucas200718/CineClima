import 'package:flutter/material.dart';
import 'package:cineclima/screens/login.dart';

void main() {
  runApp( MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CineClima",
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
