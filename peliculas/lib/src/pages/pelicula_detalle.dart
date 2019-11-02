import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_details_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    final peliculaprovider = new PeliculasProvider();
    return FutureBuilder(
        future: peliculaprovider.getPeliculaDetalles(pelicula.id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final detalles = snapshot.data;
            return Scaffold(
              body: CustomScrollView(
                slivers: <Widget>[
                  _crearAppbar(context, detalles),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      SizedBox(
                        height: 10.0,
                      ),
                      _posterTitulo(context, detalles, pelicula.uniqueId),
                      _description(context, detalles),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Reparto',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.title,
                      ),
                      _crearCasting(detalles),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Similares',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.title,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      _crearSimilares(detalles),
                    ]),
                  )
                ],
              ),
            );
          } else {
            return Container(child: Center(child: CircularProgressIndicator()));
          }
        });
  }

  Widget _crearAppbar(BuildContext context, MovieDetails pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.redAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          '${pelicula.title}',
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
            image: NetworkImage(pelicula.getBackgroundImage()),
            placeholder: AssetImage('assets/images/loading.gif'),
            fadeInDuration: Duration(microseconds: 150),
            fit: BoxFit.cover),
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, MovieDetails pelicula, uniqueID) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: uniqueID,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(pelicula.getPosterImage()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  pelicula.title,
                  style: Theme.of(context).textTheme.title,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  pelicula.originalTitle,
                  style: Theme.of(context).textTheme.subhead,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(
                      pelicula.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subhead,
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Icon(Icons.timer),
                    Text('${pelicula.runtime.toString()} minutos',
                        style: Theme.of(context).textTheme.subhead)
                  ],
                ),
                SizedBox(
                  height: 4.0,
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.theaters),
                    _getGenres(context, pelicula),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _description(BuildContext context, MovieDetails pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          Text(
            'Descripcion:',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.title,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            pelicula.overview,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _crearCasting(MovieDetails pelicula) {
    final peliProvider = new PeliculasProvider();
    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _crearActoresPageView(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearActoresPageView(List<Actor> actores) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        itemCount: actores.length,
        itemBuilder: (context, i) => _actorTarjeta(context, actores[i]),
      ),
    );
  }

  Widget _actorTarjeta(BuildContext context, Actor actor) {
    final actorTarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(actor.getProfileImg()),
              placeholder: AssetImage('assets/images/no-image.jpg'),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
    return GestureDetector(
      child: actorTarjeta,
      onTap: () {
        Navigator.pushNamed(context, '/actor', arguments: actor);
      },
    );
  }

  Widget _getGenres(BuildContext context, MovieDetails pelicula) {
    List<Genres> genres = pelicula.genres;
    if (genres == null) return Text('Sin definir');
    List<Widget> listGenreWidget = new List();
    genres.forEach((Genres genre) {
      Widget genreWidget = Row(
        children: <Widget>[
          Text(
            '${genre.name[0]}${genre.name[1]}${genre.name[2]}${genre.name[3]}',
            style: Theme.of(context).textTheme.subhead,
          ),
          SizedBox(
            width: 4.0,
          )
        ],
      );
      listGenreWidget.add(genreWidget);
    });
    return Row(children: listGenreWidget);
  }

  Widget _crearSimilares(MovieDetails pelicula) {
    final peliculaprovider = new PeliculasProvider();
    return FutureBuilder(
      future: peliculaprovider.getSimilar(pelicula.id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData)
          return _crearSimilaresPageView(snapshot.data);
        else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearSimilaresPageView(List<Pelicula> pelicula) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(viewportFraction: 0.33, initialPage: 1),
        itemCount: pelicula.length,
        itemBuilder: (context, i) => _similarTarjeta(context, pelicula[i]),
      ),
    );
  }

  Widget _similarTarjeta(BuildContext context, Pelicula pelicula) {
    pelicula.uniqueId = '${pelicula.id}-similar';
    final _similar = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(pelicula.getPosterImage()),
              placeholder: AssetImage('assets/images/no-image.jpg'),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
    return GestureDetector(
      child: _similar,
      onTap: () {
        Navigator.pushNamed(context, '/detalle', arguments: pelicula);
      },
    );
  }
}
