import 'package:flutter/material.dart';

class HomePageTemp extends StatelessWidget {
  final List<String> opciones = ['Uno', 'Dos', 'Tres', 'Cuatro', 'Cinco'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Componentes Temp'),
      ),
      body: ListView(
        children: _crearItemsCorta(),
      ),
    );
  }

  List<Widget> _crearItems() {
    List<Widget> lista = new List<Widget>();

    for (String opt in opciones) {
      final widgetTemp = ListTile(title: Text(opt));

      lista
        ..add(widgetTemp)
        ..add(Divider(
          height: 1.5,
          color: Colors.blueGrey,
        ));
    }
    return lista;
  }

  List<Widget> _crearItemsCorta() {
    var widgets = opciones.map((String item) {
      return Column(
        children: <Widget>[
          ListTile(
            title: Text(item),
            subtitle: Text('Cualquier Cosa'),
            leading: Icon(Icons.account_balance),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          ),
          Divider(
            height: 1.5,
            color: Colors.blueGrey,
          ),
        ],
      );
    }).toList();

    return widgets;
  }
}
