import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextStyle estiloTexto = new TextStyle(fontSize: 25.0);
    final conteo = 10;

    return Scaffold(
      appBar: AppBar(
        title: Text('Titulo'),
        centerTitle: true,
        elevation: 1.7,
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Text(
              'Numero de clicks: ',
              style: estiloTexto,
            ),
            Text(
              '$conteo',
              style: estiloTexto,
            ),
          ])),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print('hola mundo');
          // conteo = conteo +1;
        },
      ),
    );
  }
}
