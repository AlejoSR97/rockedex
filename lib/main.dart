import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rockedex/pages/favs_page.dart';
import 'package:rockedex/pages/home_page.dart';
import 'package:rockedex/pages/login_page.dart';
import 'package:rockedex/pages/pokemon_page.dart';
import 'package:rockedex/pages/signup_page.dart';
import 'package:rockedex/providers/pokemons_provider.dart';
import 'package:rockedex/providers/styles_provider.dart';
import 'package:rockedex/providers/user_provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PokemonsProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => StylesProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
          lazy: false,
        ),
      ],
      child: const Rockedex(),
    );
  }
}

class Rockedex extends StatelessWidget {
  const Rockedex({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'login',
      routes: {
        'home': (context) => const HomePage(),
        'login': (context) => const LoginPage(),
        'signup': (context) => const SignUpPage(),
        'pokemon': (context) => const PokemonPage(),
        'favs': (context) => const FavsPage(),
      },
      theme: ThemeData(fontFamily: 'Lato'),
    );
  }
}
