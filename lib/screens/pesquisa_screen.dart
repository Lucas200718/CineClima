import 'package:flutter/material.dart';

class PesquisaScreen extends StatefulWidget {
  @override
  _PesquisaScreenState createState() => _PesquisaScreenState();
}

class _PesquisaScreenState extends State<PesquisaScreen> {
  TextEditingController controller = TextEditingController();
  List<String> resultados = [];
  
  void buscarFilmes(String query){
    setState(() {
      resultados = [
        "Filme 1 - $query",
        "Filme 2 - $query",
        "Filme 3 - $query",
      ];
    });
  }  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pesquisar"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              onChanged: buscarFilmes,
              decoration: InputDecoration(
                labelText: "Digite o nome do filme",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: resultados.length,
                itemBuilder: (context, index){
                  return ListTile(
                    leading: Icon(Icons.movie),
                    title: Text(resultados[index]),
                    onTap: () {
                      // aqui vai ser a ação ao clicar em um filme
                    },
                  );
                },
              ), 
            ),
          ],
        ),
      ),
    );
  }
}