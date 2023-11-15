import 'package:flutter/material.dart';

class StylesProvider extends ChangeNotifier {
  late String deviceType;
  late int homeColumnCount;
  late double homeCardsAspectRatio;
  late double homePokemonImageSize;
  late double homeSearchButtonWidth;

  late double pokemonPokemonImageSize;
  late double pokemonPokemonCardSize;

  StylesProvider() {
    deviceType = '';
  }

  getDeviceType(BuildContext context) {
    /**
     * mobile: <= 420
     * tablet: <= 780
     * pc: > 780
     */
    switch (MediaQuery.of(context).size.width) {
      case <= 480:
        deviceType = 'phone';
        homeColumnCount = 2;
        homeCardsAspectRatio = 0.7;
        homePokemonImageSize = MediaQuery.of(context).size.width * 0.25;
        homeSearchButtonWidth = MediaQuery.of(context).size.width * 0.275;

        pokemonPokemonImageSize = MediaQuery.of(context).size.width * 0.5;
        pokemonPokemonCardSize = MediaQuery.of(context).size.width * 0.9;
        break;
      case <= 1080:
        deviceType = 'tablet';
        homeColumnCount = 2;
        homeCardsAspectRatio = 2;
        homePokemonImageSize = MediaQuery.of(context).size.width * 0.15;
        homeSearchButtonWidth = MediaQuery.of(context).size.width * 0.15;

        pokemonPokemonImageSize = MediaQuery.of(context).size.width * 0.3;
        pokemonPokemonCardSize = MediaQuery.of(context).size.width * 0.6;
        break;
      case > 1080:
        deviceType = 'desktop';
        homeColumnCount = 3;
        homeCardsAspectRatio = 2.5;
        homePokemonImageSize = MediaQuery.of(context).size.width * 0.15;
        homeSearchButtonWidth = MediaQuery.of(context).size.width * 0.10;

        pokemonPokemonImageSize = MediaQuery.of(context).size.width * 0.15;
        pokemonPokemonCardSize = MediaQuery.of(context).size.width * 0.3;
        break;
    }
  }
}
