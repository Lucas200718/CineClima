import 'package:http/http.dart' as http;
import 'dart:convert';

class FilmesService {
  final String apiKey = '2a640d904bb6755ac7e97ad5b9c8d049';
  final String baseUrl = 'https://api.themoviedb.org/3/discover/movie';

  // gêneros do TMDb
  final Map<String, List<int>> climaParaGeneros = {
    'Sol': [35, 12, 10751], // Comédia, Aventura
    'Nublado': [18, 14, 16], // Drama, Fantasia, Animação
    'Chuva': [53, 9648, 27], // Suspense, Mistério, Terror
    'Frio': [10749, 878], // Romance, Ficção Científica
    'Vento': [28, 53, 878], // Ação, Thriller, Super-heróis
  };

  Future<List<Map<String, String >>>getFilmesPorClima(String climaDescricao) async {
    String climaChave = _mapearClima(climaDescricao);
    List<int>? generos = climaParaGeneros[climaChave];

    if (generos == null) return [];

    final url = Uri.parse(
      '$baseUrl?api_key=$apiKey&language=pt-BR&sort_by=popularity.desc&with_genres=${generos.join(",")}',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Map<String, String>> filmes = [];
      for (var movie in data['results']) {
        filmes.add({
          "titulo": movie["title"],
          "imagem": 'http://image.tmdb.org/t/p/w500${movie['poster_path']}',
        });
      }
      return filmes;
    } else {
      throw Exception('Falha ao carregar filmes por clima');
    }
  }

  String _mapearClima(String descricao) {
    final desc = descricao.toLowerCase();
    if (desc.contains("sol")) return "Sol";
    if (desc.contains("nublado")) return "Nublado";
    if (desc.contains("chuva")) return 'Chuva';
    if (desc.contains("neve") || desc.contains("frio")) return "Frio";
    if (desc.contains("vento")) return "Vento";
    return "Sol";
  }
}
