import 'dart:math';

import 'package:flutter/material.dart';

class PersonalizadoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _fondoApp(),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _titulos(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _fondoApp() {
    final fondoGradiente = Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.7,
              colors: [Colors.greenAccent, Colors.cyan])),
    );
    final circulo1 = Container(
      height: 300.0,
      width: 300.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200.0),
        color: Colors.white54,
      ),
    );
    final figura2 = Transform.rotate(
      angle: pi / -5.0,
      child: Container(
        height: 250.0,
        width: 300.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.white30],
              begin: FractionalOffset(1.0, 0.9),
              end: FractionalOffset(0.6, 0.2),
            )),
      ),
    );
    return Stack(
      children: <Widget>[
        fondoGradiente,
        Positioned(
          top: 40.0,
          right: 160.0,
          child: circulo1,
        ),
        Positioned(
          bottom: -30.0,
          right: -30.0,
          child: figura2,
        )
      ],
    );
  }

  Widget _titulos() {
    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Titulo de la app',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Este es un subtitulo que\ntiene mas de una linea',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
