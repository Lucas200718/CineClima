import 'package:flutter/material.dart';
import 'package:cineclima/screens/services/clima_service.dart';
import 'package:cineclima/screens/services/filmes_service.dart';
import 'package:cineclima/screens/widgets/clima_widget.dart';
import 'package:cineclima/screens/widgets/carrossel_filmes.dart';
import 'package:cineclima/screens/pesquisa_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String clima = "Carregando";
  String temperatura = "-- °C";
  String iconCode = "01d";
  List<String> filmesTitulos = [];
  List<String> filmesImagens = [];

  final ClimaService climaService = ClimaService();
  final FilmesService filmesService = FilmesService();
  
  Future<void> atualizarDados() async {
    try {     
      var climaData= await climaService.getClima("São José dos Campos");
      setState(() {
        clima = climaData['descricao'];
        temperatura = "${climaData['temperatura']} °C";
        iconCode = climaData['iconCode'];
      });

      final listaDeFilmes = await filmesService.getFilmesPorClima(clima);

      filmesTitulos.clear();
      filmesImagens.clear();

      for (var filme in listaDeFilmes) {
        filmesTitulos.add(filme['titulo'] ?? '');
        filmesImagens.add(filme['imagem'] ?? '');
      }

      setState(() {});
    } catch (e) {
      print('Erro ao carregar dados: $e');
      setState(() {
        clima = 'Erro ao carregar clima';
        temperatura = '-- °C';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    atualizarDados();
  }

  String getMensagemPorClima(String clima) {
    clima = clima.toLowerCase();
    if (clima.contains("clear sky")) { // Sol
      return "Filmes perfeitos para um dia ensolarado ☀️";
    } else if (clima.contains("few clouds")) { // Algumas nuvens
      return "Melhores filmes para assistir em um dia nublado 🌥";
    } else if (clima.contains("rain")) { // Chuva
      return "Filmes para curtir em um dia chuvoso ⛈️";
    } else if (clima.contains("snow")) { // Neve
      return "Filmes aconchegantes para o frio ❄️";
    } else if (clima.contains("wind")) { // Vento
      return "Filmes eletrizantes para um dia com ventania 🌬️";
    } else {
      return "Filmes recomendados para hoje 🎬";
    }
  }
  int _iconeSelecionado = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 228, 225, 94), Color.fromARGB(255, 65, 119, 182)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              SizedBox(height: 16),
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                toolbarHeight: 100,
                automaticallyImplyLeading: false,
                title: Image.asset('imagens/logo.png', height: 90),
                centerTitle: true,
              ),
              SizedBox(height: 16)
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on, color: Colors.white),
                  SizedBox(width: 8),
                  Text("Permitir localização",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
              ),
              ClimaWidget(
                clima: clima,
                temperatura: temperatura,
                iconCode: iconCode,
                onRefresh: atualizarDados,
              ),

              SizedBox(height: 20),
              if (filmesTitulos.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getMensagemPorClima(clima),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    SizedBox(height: 30),
                    CarrosselFilmes(
                      titulos: filmesTitulos,
                      imagens: filmesImagens,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color.fromARGB(255, 53, 53, 51), Color.fromARGB(255, 44, 44, 42),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          ),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
          ),
          child: BottomNavigationBar(
            backgroundColor: const Color.fromARGB(249, 68, 67, 67),            
            currentIndex: _iconeSelecionado,
            onTap: (index){
              setState(() {
                _iconeSelecionado = index;
              });
              if(index==1){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PesquisaScreen()));
              } else if(index==2){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SalvosScreen()));
              } else if(index==3){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PerfilScreen()));
              }
            },
            selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
            unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
            type: BottomNavigationBarType.fixed,
            items: [BottomNavigationBarItem(icon: Icon(Icons.home),
            label: "Início",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.search),
            label: "Pesquisa",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.bookmark),
            label: "Salvos",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person),
            label: "Perfil",
            ),
          ],
         ), 
        ),
      ),
    );
  }
}
