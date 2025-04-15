import 'package:flutter/material.dart';

class SalvosScreen extends StatefulWidget {
  @override
  State<SalvosScreen> createState() => _SalvosScreenState();
}

class _SalvosScreenState extends State<SalvosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Salvos")),
      body: Center(child: Text("Filmes Salvos")),
    );
  }
}