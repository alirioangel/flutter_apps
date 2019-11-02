import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actores_model.dart';

class ActorPage extends StatelessWidget {
  const ActorPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Actor actor = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[],
      ),
    );
  }
}
