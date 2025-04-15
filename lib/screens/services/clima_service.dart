import 'dart:convert';
import 'package:http/http.dart' as http;

class ClimaService {
  final String apiKey = 'b03ff2bee248c15f1338edd7e505ba82'; 
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>> getClimaPorCoordenadas(double lat, double lon) async {
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=b03ff2bee248c15f1338edd7e505ba82&units=metric&lang=pt_br');
    final response = await http.get(url);
    


    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final descricaoClima = data['weather'][0]['description'];
      final temperatura = data['main']['temp'];
      final sensacaoTermica = data['main']['feels_like'];
      final umidade = data['main']['humidity'];
      final vento = data['wind']['speed'];
      final iconCode = data['weather'][0]['icon'];

      return {
        'descricao': descricaoClima,
        'temperatura': temperatura,
        'sensacao': sensacaoTermica,
        'umidade': umidade,
        'vento': vento,
        'iconCode': iconCode,
      };
    } else {
      throw Exception('Erro ao buscar clima');
    }
  }
}
