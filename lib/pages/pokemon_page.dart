import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rockedex/models/pokemon.dart';
import 'package:rockedex/providers/pokemons_provider.dart';
import 'package:rockedex/providers/styles_provider.dart';
import 'package:rockedex/providers/user_provider.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({super.key});

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  late PokemonsProvider pokemonsProvider;
  late UserProvider userProvider;
  late StylesProvider stylesProvider;
  @override
  Widget build(BuildContext context) {
    pokemonsProvider = Provider.of<PokemonsProvider>(
      context,
      listen: true,
    );

    userProvider = Provider.of<UserProvider>(
      context,
      listen: true,
    );

    stylesProvider = Provider.of<StylesProvider>(
      context,
      listen: true,
    );
    stylesProvider.getDeviceType(context);

    final pokemon = ModalRoute.of(context)!.settings.arguments as Pokemon;

    return Scaffold(
      appBar: appbar(context),
      body: body(context, pokemon),
    );
  }

  AppBar appbar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Image(
        image: AssetImage('assets/images/logo.jpeg'),
        height: 30,
      ),
      actions: [
        IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.solidHeart,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'favs');
          },
        ),
      ],
    );
  }

  Widget body(BuildContext context, Pokemon pokemon) {
    return Container(
      height: double.maxFinite,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[100],
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          botonVolver(),
          stylesProvider.deviceType != 'desktop'
              ? Column(
                  children: [
                    imagenPokemon(context, pokemon.image),
                    tarjetaInformacion(context, pokemon),
                  ],
                )
              : Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      imagenPokemon(context, pokemon.image),
                      tarjetaInformacion(context, pokemon),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget botonVolver() {
    return Container(
      width: double.maxFinite,
      alignment: Alignment.centerLeft,
      child: IconButton(
        icon: const FaIcon(FontAwesomeIcons.arrowLeft),
        onPressed: () {
          Navigator.pushReplacementNamed(context, 'home');
        },
      ),
    );
  }

  Widget imagenPokemon(BuildContext context, String? imagenPokemon) {
    return SizedBox(
      width: stylesProvider.pokemonPokemonImageSize,
      height: stylesProvider.pokemonPokemonImageSize,
      child: Image(
        fit: BoxFit.contain,
        image: NetworkImage(imagenPokemon ?? ''),
      ),
    );
  }

  Widget tarjetaInformacion(BuildContext context, Pokemon pokemon) {
    List<Widget> listaTipos = [];
    for (var tipo in pokemon.types) {
      listaTipos.add(toastTipo(tipo));
    }

    return Container(
      width: stylesProvider.pokemonPokemonCardSize,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 25,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          textoNombre(pokemon.name),
          const SizedBox(height: 15),
          Wrap(
            direction: Axis.horizontal,
            spacing: 5,
            children: listaTipos,
          ),
          const SizedBox(height: 10),
          textoDescripcion(pokemon.description),
          const SizedBox(height: 10),
          textoAtributo('ID', pokemon.number!.padLeft(4, '0')),
          const SizedBox(height: 10),
          textoAtributo('Altura', pokemon.height),
          const SizedBox(height: 10),
          textoAtributo('Peso', pokemon.weight),
          const SizedBox(height: 15),
          botonFavoritos(pokemon),
        ],
      ),
    );
  }

  Widget textoNombre(String nombre) {
    return Text(
      nombre,
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget toastTipo(String tipo) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[200],
      ),
      child: Text(
        tipo,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget textoDescripcion(String? texto) {
    return SizedBox(
      width: double.maxFinite,
      child: Text(
        texto ?? '',
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Widget textoAtributo(String titulo, String? valor) {
    return Row(
      children: [
        Text(
          '$titulo: ',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          valor ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget botonFavoritos(Pokemon pokemon) {
    return Container(
      width: double.maxFinite,
      height: 50,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: () {
          pokemonsProvider.toggleFavorito(
            userProvider.currentUser.name,
            pokemon,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            pokemonsProvider.esFavorito(pokemon.number)
                ? 'ELIMINAR DE FAVORITOS'
                : 'AGREGAR A FAVORITOS',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
