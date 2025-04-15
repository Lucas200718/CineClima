import 'package:flutter/material.dart';

class PerfilScreen extends StatefulWidget {
  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil")),
        body: Center(child: Text("Tela de Perfil")),
    );
  }
}