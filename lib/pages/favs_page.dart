import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rockedex/providers/pokemons_provider.dart';
import 'package:rockedex/models/pokemon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rockedex/providers/styles_provider.dart';

class FavsPage extends StatefulWidget {
  const FavsPage({super.key});

  @override
  State<FavsPage> createState() => _FavsPageState();
}

class _FavsPageState extends State<FavsPage> {
  late PokemonsProvider pokemonsProvider;
  late StylesProvider stylesProvider;

  @override
  Widget build(BuildContext context) {
    pokemonsProvider = Provider.of<PokemonsProvider>(
      context,
      listen: true,
    );

    stylesProvider = Provider.of<StylesProvider>(
      context,
      listen: true,
    );
    stylesProvider.getDeviceType(context);

    return Scaffold(
      appBar: appbar(context),
      body: body(context, pokemonsProvider.pokemonesFavoritos),
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
    );
  }

  Widget body(BuildContext context, List<Pokemon> pokemones) {
    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 25,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          titulo(),
          const SizedBox(height: 15),
          contenedorTarjetas(context, pokemones),
        ],
      ),
    );
  }

  Widget titulo() {
    return Row(
      children: [
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'home');
          },
        ),
        const SizedBox(width: 10),
        const Text(
          'Favoritos',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  Widget contenedorTarjetas(BuildContext context, List<Pokemon> pokemones) {
    if (pokemones.isEmpty) {
      return Container(
        padding: EdgeInsets.zero,
        height: MediaQuery.of(context).size.height * 0.65,
        width: double.maxFinite,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                width: MediaQuery.of(context).size.width * 0.6,
                color: Colors.grey[500],
                image: const AssetImage('assets/images/no-favs.png'),
              ),
              Text(
                'Aún no tienes favoritos',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.zero,
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.9,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Wrap(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                crossAxisCount: stylesProvider.homeColumnCount,
                childAspectRatio: stylesProvider.homeCardsAspectRatio,
              ),
              padding: EdgeInsets.zero,
              itemCount: pokemones.length,
              itemBuilder: (BuildContext context, int index) {
                return tarjeta(context, pokemones[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget tarjeta(BuildContext context, Pokemon pokemon) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(
          context,
          'pokemon',
          arguments: pokemon,
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.325,
        width: MediaQuery.of(context).size.width * 0.425,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: tarjetaContenido(context, pokemon),
      ),
    );
  }

  Widget tarjetaContenido(BuildContext context, Pokemon pokemon) {
    List<Widget> listaTipos = [];
    for (var element in pokemon.types) {
      listaTipos.add(toastTipo(element));
    }

    return Stack(
      children: [
        stylesProvider.deviceType == 'phone'
            ? Column(
                children: [
                  imagenPokemon(context, pokemon.image),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      numeroPokemon(pokemon.number),
                      const SizedBox(height: 5),
                      nombrePokemon(pokemon.name),
                      const SizedBox(height: 5),
                      Wrap(
                        direction: Axis.horizontal,
                        spacing: 5,
                        children: listaTipos,
                      ),
                    ],
                  )
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 15),
                  imagenPokemon(context, pokemon.image),
                  const SizedBox(width: 15),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      numeroPokemon(pokemon.number),
                      const SizedBox(height: 5),
                      nombrePokemon(pokemon.name),
                      const SizedBox(height: 5),
                      Wrap(
                        direction: Axis.horizontal,
                        spacing: 5,
                        children: listaTipos,
                      ),
                    ],
                  )
                ],
              ),
        Container(
          width: double.maxFinite,
          alignment: Alignment.topRight,
          child: IconButton(
            icon: pokemonsProvider.esFavorito(pokemon.number)
                ? const FaIcon(FontAwesomeIcons.solidHeart)
                : const FaIcon(FontAwesomeIcons.heart),
            padding: EdgeInsets.zero,
            color: pokemonsProvider.esFavorito(pokemon.number)
                ? Colors.red
                : Colors.black,
            onPressed: () {
              pokemonsProvider.toggleFavorito(pokemon);
            },
          ),
        ),
      ],
    );
  }

  Widget imagenPokemon(BuildContext context, String? imagen) {
    return FadeInImage(
      width: stylesProvider.homePokemonImageSize,
      height: stylesProvider.homePokemonImageSize,
      fit: BoxFit.contain,
      placeholder: const AssetImage(
        'assets/images/not-found2.png',
      ),
      image: NetworkImage(
        imagen ?? '',
      ),
    );
  }

  Text numeroPokemon(String? idPokemon) {
    return Text(
      idPokemon!.padLeft(4, '0'),
      style: const TextStyle(
        fontSize: 14,
      ),
    );
  }

  Text nombrePokemon(String? nombrePokemon) {
    return Text(
      nombrePokemon ?? '',
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget toastTipo(String? tipo) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[200],
      ),
      child: Text(
        tipo ?? '',
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
