import 'package:flutter/material.dart';

class BasicoPage extends StatelessWidget {
  final estiloTitulo = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final estiloSubTitulo = TextStyle(fontSize: 18.0, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Image(
              image: NetworkImage(
                  'https://images.pexels.com/photos/371633/pexels-photo-371633.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
              height: 260.0,
              fit: BoxFit.cover,
            ),
          ),
          _construirRow(),
          _crearAcciones(),
          _crearTexto(),
        ],
      ),
    ));
  }

  Widget _construirRow() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 20.0,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Practicar diseños',
                    style: estiloTitulo,
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Text(
                    'Es bastante divertido',
                    style: estiloSubTitulo,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.star,
              color: Colors.red,
              size: 30.0,
            ),
            Text(
              '41',
              style: TextStyle(fontSize: 20.0),
            )
          ],
        ),
      ),
    );
  }

  Widget _crearAcciones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _accion(Icons.call, 'call'),
        _accion(Icons.near_me, 'route'),
        _accion(Icons.share, 'share'),
      ],
    );
  }

  Widget _accion(IconData icon, String accion) {
    final estiloIconoTexto =
        TextStyle(color: Colors.blue, fontWeight: FontWeight.bold);
    return Column(
      children: <Widget>[
        Icon(
          icon,
          size: 35.0,
          color: Colors.blueAccent,
        ),
        SizedBox(
          height: 7.0,
        ),
        Text(
          accion.toUpperCase(),
          style: estiloIconoTexto,
        )
      ],
    );
  }

  Widget _crearTexto() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 20.0,
        ),
        child: Text(
          'Adipisicing cillum ut non minim commodo non ea eu aliquip eiusmod qui. Duis eiusmod veniam fugiat ea exercitation voluptate ad et dolore excepteur qui aute. Fugiat anim nulla dolore voluptate id ut deserunt exercitation id Lorem voluptate. Anim officia eiusmod est occaecat dolor. Sunt labore sunt Lorem cupidatat in et esse. Ipsum eu ullamco deserunt Lorem laborum eu magna amet.',
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
