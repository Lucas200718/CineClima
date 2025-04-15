import 'package:flutter/material.dart';

class ClimaWidget extends StatelessWidget {
  final String clima;
  final String temperatura;
  final String iconCode;
  final VoidCallback onRefresh;

  const ClimaWidget({
    required this.clima,
    required this.temperatura,
    required this.iconCode,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      color: Color.fromARGB(255, 233, 243, 226),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Clima Atual:',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Image.network(
                      'https://openweathermap.org/img/wn/$iconCode.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 8),
                    Text(
                      clima,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Temperatura: $temperatura',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.refresh, size: 24, color: Colors.blueGrey),
              onPressed: onRefresh,
              tooltip: "Atualizar Clima",
            ),
          ],
        ),
      ),
    );
  }
}
