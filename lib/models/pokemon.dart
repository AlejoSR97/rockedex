import 'dart:convert';

Pokemon pokemonFromJson(String str) => Pokemon.fromJson(json.decode(str));

String pokemonToJson(Pokemon data) => json.encode(data.toJson());

class Pokemon {
  String? number;
  String url;
  String name;
  String? description;
  String? height;
  String? weight;
  String? image;
  List<String> types = [];

  Pokemon({
    this.number,
    required this.url,
    required this.name,
    this.description,
    this.height,
    this.weight,
    this.image,
    required this.types,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        number: json["number"],
        url: json["url"],
        name: json["name"],
        description: json["description"],
        height: json["height"],
        weight: json["weight"],
        image: json["image"],
        types: json["types"] != null
            ? List<String>.from(json["types"].map((x) => x))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "url": url,
        "name": name,
        "description": description,
        "height": height,
        "weight": weight,
        "image": image,
        "types": List<dynamic>.from(types.map((x) => x)),
      };
}
