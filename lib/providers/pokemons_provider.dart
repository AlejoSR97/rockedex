import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rockedex/models/pokemon.dart';

class PokemonsProvider extends ChangeNotifier {
  List<Pokemon> listaPokemones = [];
  List<Pokemon> pokemonesFavoritos = [];

  final String _baseUrl = 'pokeapi.co';
  final String _apiUrl = 'api/v2/pokemon';
  int _offset = 0;
  final int _limit = 12;

  PokemonsProvider() {
    getPokemonsList();
  }

  getPokemonsList() async {
    var url = Uri.https(
      _baseUrl,
      _apiUrl,
      {
        'offset': _offset.toString(),
        'limit': _limit.toString(),
      },
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = json.decode(response.body);
        List<dynamic> lista = decodedData['results'];

        for (var e in lista) {
          Pokemon newPokemon = Pokemon(
            number: Uri.dataFromString(e['url']).pathSegments[6],
            url: e['url'],
            name: e['name'],
            types: [],
          );

          var pokemonData = await getPokemonData(
            '$_apiUrl/${Uri.dataFromString(e['url']).pathSegments[6]}',
          );
          pokemonData = json.decode(pokemonData);

          var pokemonDescription = await getPokemonData(
            '$_apiUrl-species/${Uri.dataFromString(e['url']).pathSegments[6]}',
          );
          pokemonDescription = json.decode(pokemonDescription);
          List lenguajes = pokemonDescription['flavor_text_entries'];

          newPokemon.weight = pokemonData['weight'].toString();
          newPokemon.height = pokemonData['height'].toString();
          newPokemon.description = lenguajes.firstWhere(
              (element) => element['language']['name'] == 'es')['flavor_text'];
          newPokemon.image = pokemonData['sprites']['other']['official-artwork']
              ['front_default'];

          for (var type in pokemonData['types']) {
            newPokemon.types.add(type['type']['name']);
          }

          listaPokemones.add(newPokemon);
          listaPokemones.sort((a, b) => int.parse(a.number!) > int.parse(b.number!) ? 1 : 0);
          notifyListeners();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  getPokemonData(String apiUrl) async {
    var url = Uri.https(
      _baseUrl,
      apiUrl,
    );

    try {
      final response = await http.get(url);
      return response.body;
    } catch (e) {
      print(e);
    }
  }

  agregarPokemones() {
    _offset += 12;
    getPokemonsList();
  }

  agregarFavorito(Pokemon pokemon) {
    pokemonesFavoritos.add(pokemon);
    notifyListeners();
  }

  eliminarFavorito(Pokemon pokemon) {
    pokemonesFavoritos.removeWhere((e) => e.number == pokemon.number);
    notifyListeners();
  }

  toggleFavorito(Pokemon pokemon) {
    if (esFavorito(pokemon.number)) {
      eliminarFavorito(pokemon);
    } else {
      agregarFavorito(pokemon);
    }
    pokemonesFavoritos.sort((a, b) => int.parse(a.number!) > int.parse(b.number!) ? 1 : 0);
  }

  esFavorito(String? number) {
    if (number == null) {
      return false;
    }
    return pokemonesFavoritos.any((element) => element.number == number);
  }
}
