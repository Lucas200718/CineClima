import 'dart:async';
import 'package:flutter/material.dart';

class CarrosselFilmes extends StatefulWidget {
  final List<String> titulos;
  final List<String> imagens;

  CarrosselFilmes({required this.titulos, required this.imagens});

  @override
  _CarrosselFilmesState createState() => _CarrosselFilmesState();
}

class _CarrosselFilmesState extends State<CarrosselFilmes> {
  late ScrollController _scrollController;
  late Timer _timer;
  double _scrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController =ScrollController();

    _timer = Timer.periodic(Duration(seconds: 4),(timer) {
      if (_scrollController.hasClients) {
        double itemWidth = 120 + 16; 
        _scrollPosition += itemWidth;
        if (_scrollPosition >= _scrollController.position.maxScrollExtent) {
          _scrollPosition = 0;
        }

        _scrollController.animateTo(
          _scrollPosition,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }
  );
}

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.titulos.length,
        itemBuilder: (context, index) {
          return Container(
            width: 120,
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: widget.imagens[index].isNotEmpty
                      ? Image.network(
                          widget.imagens[index],
                          height: 140,
                          width: 120,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 140,
                          width: 120,
                          color: Colors.grey[300],
                          child: Icon(Icons.image_not_supported, color: Colors.grey[600]),
                        ),
                ),
                SizedBox(height: 5),
                Text(
                  widget.titulos[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
