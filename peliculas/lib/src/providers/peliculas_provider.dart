import 'dart:async';
import 'dart:convert';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_details_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProvider {
  String _apiKey = '555a92db4ab3f3c0ac33f81fd350c1b2';
  String _url = 'api.themoviedb.org';
  String _lenguaje = 'es-MX';
  int _popularesPage = 0;
  bool _cargando = false;
  List<Pelicula> _populares = new List();

  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;
  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, "3/movie/now_playing", {
      'api_key': _apiKey,
      'language': _lenguaje,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];
    _cargando = true;
    _popularesPage++;
    final url = Uri.https(_url, "3/movie/popular", {
      'api_key': _apiKey,
      'language': _lenguaje,
      'page': _popularesPage.toString(),
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);
    _cargando = false;
    return resp;
  }

  Future<List<Actor>> getCast(String peliId) async {
    if (_cargando) return [];
    _cargando = true;
    final url = Uri.https(_url, "3/movie/$peliId/credits", {
      'api_key': _apiKey,
      'language': _lenguaje,
    });
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final cast = new Cast.fromJsonList(decodedData['cast']);
    _cargando = false;
    return cast.actores;
  }

  Future<List<Pelicula>> getSearch(String query) async {
    if (_cargando) return [];
    _cargando = true;
    final url = Uri.https(_url, "3/search/movie",
        {'api_key': _apiKey, 'language': _lenguaje, 'query': query});
    _cargando = false;
    return await _procesarRespuesta(url);
  }

  Future<MovieDetails> getPeliculaDetalles(int id) async {
    if (_cargando) return null;
    _cargando = true;
    final url = Uri.https(_url, "3/movie/$id", {
      'api_key': _apiKey,
      'language': _lenguaje,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculaDetalle = new PeliDetalle.fromJson(decodedData);
    _cargando = false;
    return peliculaDetalle.pelicula;
  }

  Future<List<Pelicula>> getSimilar(int id) async {
    if (_cargando) return [];
    _cargando = true;
    final url = Uri.https(_url, "3/movie/$id/similar", {
      'api_key': _apiKey,
      'language': _lenguaje,
    });
    _cargando = false;
    return _procesarRespuesta(url);
  }
}
