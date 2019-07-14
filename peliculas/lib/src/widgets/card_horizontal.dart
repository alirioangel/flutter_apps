import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;

  CardHorizontal({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.25,
      child: PageView(
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.33,
        ),
        children: _tarjetas(context),
      ),
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return peliculas.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(17.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImage()),
                placeholder: AssetImage('assets/images/loading.gif'),
                fit: BoxFit.fill,
                height: 150,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(pelicula.title),
          ],
        ),
      );
    }).toList();
  }
}
